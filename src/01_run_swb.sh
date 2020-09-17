#!/bin/bash

source $( dirname ${BASH_SOURCE[0]} )/00_set_run_variables.sh

${SWB2} --logfile_dir=${LOGFILE_DIR}            \
        --output_prefix=${OUTPUT_FILE_PREFIX}   \
        --data_dir=${DATA_DIR}                  \
        --weather_data_dir=${WEATHER_DIR}       \
        ${SWB_CONTROL_FILE}

