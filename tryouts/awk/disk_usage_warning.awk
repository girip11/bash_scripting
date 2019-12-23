BEGIN { print "DISK USAGE REPORT" }
/dev\/sd.*/ { print $1 " \t " $5 }
END { print "REPORT ENDS HERE" }
