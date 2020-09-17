#!/bin/sh

source $( dirname ${BASH_SOURCE[0]} )/00_set_run_variables.sh

RO_NETCDF=$(ls *1000mrunoff__*.nc)

${SWBSTATS2} --zone_period_file=swbstats2_zone_period_file_ALL_SW.csv        \
             --no_netcdf_output                                                 \
           ${RO_NETCDF}

OUTPUT_CSV=zonal_stats__runoff.csv

echo "Final runoff swbstats2 output file has $(wc -l ${OUTPUT_CSV}) lines."
