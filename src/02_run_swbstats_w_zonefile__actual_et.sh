#!/bin/sh

source $( dirname ${BASH_SOURCE[0]} )/00_set_run_variables.sh

AET_NETCDF=$(ls *actual_et*.nc)

echo "Running swbstats2 on file ${AET_NETCDF}, SLURM_PROCID=${SLURM_PROCID}"

${SWBSTATS2} --zone_period_file=swbstats2_zone_period_file___actual_et.csv        \
           --no_netcdf_output                                                   \
           ${AET_NETCDF}

OUTPUT_CSV=zonal_stats__actual_et.csv

echo "Final swbstats2 output file has $(wc -l ${OUTPUT_CSV}) lines."
