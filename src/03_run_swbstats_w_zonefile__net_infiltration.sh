#!/bin/sh

source $( dirname ${BASH_SOURCE[0]} )/00_set_run_variables.sh

NI_NETCDF=$(ls *1000mnet_infiltration*.nc)

${SWBSTATS2} --zone_period_file=swbstats2_zone_period_file_ALL_SW.csv        \
             --no_netcdf_output                                                 \
           ${NI_NETCDF}

OUTPUT_CSV=zonal_stats__net_infiltration.csv

echo "Final net_infiltration swbstats2 output file has $(wc -l ${OUTPUT_CSV}) lines."
