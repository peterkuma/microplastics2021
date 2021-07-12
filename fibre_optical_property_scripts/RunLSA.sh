#!/bin/bash

#This only needs to be run to generate pill_mpl.csv
if [ ! -f pill_mpl.csv ] ; then
Rscript generate_values_for_interpolation.r
fi

#matlab -nojvm < create_input_parameters.m
octave --no-window-system create_input_parameters.m

number_runs=$(wc -l < fibre_LSA_params.txt)

# the upper limit here should be the number of lines in fibre_LSA_params.txt
mkdir -p LSA_output
for INDEX in $(seq 1 $number_runs); do
matlab_script=$(Rscript save_lsa_script.r $INDEX)
printf "Script saved to %s\n" $matlab_script
#matlab -nojvm < $matlab_script
octave --no-window-system $matlab_script
rm $matlab_script
printf "Script deleted\n"
done

bash combine_csv.sh
# Columns in the file are
#Wavelength lambda [nm]
#Radius of fibre a [nm]
#Aspect ratio of fibre h
#Asymmetry parameter g
#Orientation averaged Scattering efficiency Qsca
#Orientation averaged Extinction efficiency Qext
#Orientation averaged Absorption efficiency Qabs
#A terminating zero 0
