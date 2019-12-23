# print the output as csv
BEGIN { OFS=","; print "Processing started" }
# BEGIN { OFS=","; print "Processing started" }
/dev\/sd.*/ {print NR,$1,$5}
END { print "Number of records processed: " NR}
