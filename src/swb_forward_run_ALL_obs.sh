#!/bin/bash

# Clean up directory:
rm -rf *.nc
rm -rf zonal_stats*.csv
rm -rf *.obs
rm -rf *.asc

# per Falgout, try increasing stack size
ulimit -s unlimited

# --------------------------
# Part 1 - run SWB
# Produces netcdf files for next step
# Uses environment variables from "set_run_variables.sh"
# -------------------------
printf "Running SWB\n"
./run_swb.sh  
wait
printf "Finished SWB Run.\n\n"

# -------------------------
# Part 2 - Run swbstats to get zone stats 
# Processes netcdf files to produce .csv files
# Uses environment variables from "set_run_variables.sh"
# -------------------------
printf "Running swbstats2\n"
./run_swbstats_zonefile.sh
./run_swbstats_zonefile_sw_ALL.sh
wait
printf "Finished swbstats2 run.\n\n"

# ------------------------
# Part 3 - run post-processor observation 
# python script for PEST input
# ------------------------
printf "Starting postprocessing script\n"
python swbstats2_post_processor_for_pest_ET_BF_RO_yr_and_mo.py

echo "All Done!"


