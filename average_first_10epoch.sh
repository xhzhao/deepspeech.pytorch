echo "processing file: $1"
grep "Time taken" $1 | awk ' NR < 11 {sum+=$8; print $8} END {print "average epoch time =" sum/10}'

