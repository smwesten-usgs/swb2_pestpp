#!/usr/bin/env python

'''
Oct 23, 2019
Script to take swbstats2 output and condense and create a pest-compatible
observation file.

For use on the YETI computer system
--> Paths are for YETI
Requires access to OBSSERVATIONS_DATA_ET.csv (actual observations) file
for complete names

# M. Nielsen

2/25/2020 Hacked up badly by SMW: removed all references to file structure; assuming all code/data live in same dir.

3/24/2020 Modified by MGN to fix issues with sorting and matching all new obs.

7/31/2020 Added a lot of SW observations....

'''

# Setup:
import pandas as pd
import os

# Just for testing:


print ('Converting zonal stats to observations')

# --------------------------------------------------
# AET observations
# --------------------------------------------------
# Read in the zonal stats file from swbstats2:
infile2 = 'zonal_stats__actual_et.csv'
tmpdat = pd.read_csv(infile2)
# Get those pesky zeros out of there...
# Only 10 lines are zeros with the full list.
simdata = tmpdat.loc[tmpdat.count_swb != 0][['start_date','zone_id','mean_swb']].copy()

# Put the year and month on the zone ID:
simdata['yr'] = simdata['start_date'].str.split("-").str[0]
simdata['mo'] = simdata['start_date'].str.split("-").str[1]
simdata['zone_str'] = simdata['zone_id'].astype(str).str.rjust(3,'0')
simdata['name1'] = simdata['zone_str'] + "_" + simdata['yr'] + "_" + simdata['mo']

# Get the observation names from the OBSERVATIONS_DATA_ET.csv file:
infile = 'OBSERVATIONS_DATA_ET.csv'
obsnames = pd.read_csv(infile)
obs_short = obsnames[['Zone','ObsName']].copy()
obs_short['obs'] = obs_short['ObsName'].str.split("-").str[1]

# Join simdata and obsdata 
# Use the zone number to give the simdata a name:
simdata2 = pd.merge(simdata, obs_short, left_on='name1', right_on='obs', how='right')
simdata2['Value'] = simdata2['mean_swb']

# Get rid of lines with no data:
simdata_pest = simdata2.loc[~simdata2.Value.isnull()][['ObsName','Value']].copy()

# Sort on obs name:
simdata_pest.sort_values(by='ObsName', inplace=True)

# ----------------------------------------------------------------
# baseflow/net_infiltration and runoff observations
# ----------------------------------------------------------------
# Read in the zonal stats files from swbstats2:
# ANNUAL files
bf_file = 'zonal_stats__net_infiltration.csv'
ro_file = 'zonal_stats__runoff.csv'

def make_obsnames(obs_df, obstype):
    
    months = ['jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec']
    m = ['01','02','03','04','05','06','07','08','09','10','11','12']
    mos_dict = dict(zip(m,months))

    # Get observation watershed info:
    obsinfofile = 'Watersheds_for_OBS_zones.csv'
    obstmp = pd.read_csv(obsinfofile)
    obsinfo = obstmp[['Obs_Zone','SiteID']].sort_values(by='Obs_Zone')

    df1 = pd.merge(obs_df, obsinfo, how='left', left_on='zone_id', right_on='Obs_Zone')
    df1['year'] = df1['start_date'].str[:4]
    df1['zone_id'] = df1['zone_id'].astype(str)
    df1['SiteID'] = df1['SiteID'].astype(str)
    
    df1['start_mon'] = df1['start_date'].str[5:7]
    
    # Calculate time delta for the obs:
    df1['start_date']= pd.to_datetime(df1['start_date']) 
    df1['end_date']= pd.to_datetime(df1['end_date']) 

    df1['TimeDelta'] = df1['end_date'] - df1['start_date'] + pd.to_timedelta(1, unit="D")
    df1['days'] = df1['TimeDelta'].astype(str).str.split(' ').str[0].astype(int)  #Have month-type and year-type lengths
    
    df1['ObsName'] = 'xxxxx'  # Initialize.
    df1['Mon']= df1['start_mon'].map(mos_dict)
    
    # use .loc
    df1.loc[df1.days > 50, 'ObsName'] = obstype + df1['zone_id'] + "_" + df1['SiteID'] + "_yr" + df1['year']
    
    df1.loc[df1.days < 50, 'ObsName'] = obstype + df1['zone_id'] + "_" + df1['SiteID'] + "_" + df1['Mon'] + "-" + df1['year'].str[-2:]

    df2 = df1[['ObsName','start_date','end_date','zone_id','mean_swb','days']].copy()

    return df2



# Read ANNUAL zone stats files:
tmpdat_bf = pd.read_csv(bf_file)
simdata_bf = tmpdat_bf.loc[tmpdat_bf.count_swb != 0][['start_date','end_date','zone_id','mean_swb']].copy()
simdata_bf.sort_values(by=['zone_id','start_date'], inplace=True)

tmpdat_ro = pd.read_csv(ro_file)
simdata_ro = tmpdat_ro.loc[tmpdat_ro.count_swb != 0][['start_date','end_date','zone_id','mean_swb']].copy()
simdata_ro.sort_values(by=['zone_id','start_date'], inplace=True)

# Call function to return prettied-up observations:
dat_bf = make_obsnames(simdata_bf, 'bf_')
dat_ro = make_obsnames(simdata_ro, 'ro_')

# Join both into one file
obsdat_bf_ro = dat_bf.append(dat_ro)
obsdat_bf_ro.sort_values(by='ObsName', inplace=True)

del obsdat_bf_ro['start_date']
del obsdat_bf_ro['end_date']
del obsdat_bf_ro['zone_id']
del obsdat_bf_ro['days']
# ##########################################################
# Save to obs files:

outfile2 = 'swbstats_simulated_obs_SW.obs'
obsdat_bf_ro.to_csv(outfile2, sep=' ', index=False)

outfile1 =  'swbstats_simulated_obs_et_ALL_sorted.obs'
simdata_pest.to_csv(outfile1, sep=' ', index=False)

print ('Saved obs files: ' + outfile1 + ", " + outfile2)

