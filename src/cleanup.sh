#!/bin/sh 

# This script is designed to remove all traces of a previous swb2 / swbstats2
# run in order to ensure that downstream Python and/or shell scripts have the
# greatest probability of reading a fresh output file and not detritus left
# froma previous run.

rm -f *.err
rm -f *.out
rm -f *calculated*.asc
rm -f *_as_read_*
rm -f Maximum_rooting_depth__as_assembled*
rm -f Soil_Storage_Maximum__as_calculated*
rm -f *.nc
rm -f *.obs

echo "Files cleaned up."
