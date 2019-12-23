# print the output as csv
BEGIN { OFS=","; print "Processing started" }
/tmpfs/ { 
gsub(/M/,"",$2); 
gsub(/M/,"",$3); 
print NR,$1,$2,$3; 
total += $2; used += $3 
}
END { print "Total: " total ", Used:" used }
