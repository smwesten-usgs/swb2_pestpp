#!/bin/sh

# Hail Mary attempt to keep netCDF from erroring out based on this SO entry:
# https://stackoverflow.com/questions/49317927/errno-101-netcdf-hdf-error-when-opening-netcdf-file
#
export HDF5_USE_FILE_LOCKING=FALSE

export RES=1000
export DATA_DIR=/lustre/projects/water/wiwsc/swb/projects/MAP/swb_inputs/
export WEATHER_DIR=/lustre/projects/water/wiwsc/swb/data/Daymet_V3_2016/
export LOGFILE_DIR=/lustre/projects/water/wiwsc/swb/projects/MAP/pest_test_dir/logs/
export SWB_CONTROL_FILE=swb_allobs__1000m__MAP_gnatsgo.ctl
export OUTPUT_FILE_PREFIX=allobs_${RES}m

export SWB2=/lustre/projects/water/wiwsc/swb/bin/swb2
export SWBSTATS2=/lustre/projects/water/wiwsc/swb/bin/swbstats2
export PYTHONPATH=/lustre/projects/water/wiwsc/swb/miniconda3
