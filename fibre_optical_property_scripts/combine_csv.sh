#!/bin/bash

#combine, in an arbitrary order, all the LSA results, into a seperate CSV file
# LSA results in ./, and prefixed LSA_a_

LSA_OUT=LSA_all_results.csv
rm $LSA_OUT
for i in $(ls LSA_output/LSA_a_*.csv);
do cat $i >> $LSA_OUT
done
