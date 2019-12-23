# GNU AWK

AWK - short for A(Aho) W (Weinberger) K(Kernighan)

* Run a short awk script - `awk 'program' inputfile`
* Run an awk script file - `awk -f awk_script_file inputfiles`

## `Print` command

* FS - Field Separator variable. The default input field separator is one or more whitespaces or tabs
* `$0` - contains the entire line.
* `$1`.. `$n` - contains each field value from a single line.

```bash
df -h | grep -iv 'filesystem' | \
awk '{print "FileSystem: " $1 "\t Used " $5}'

# using regular expressions
# regex patterns enclosed with //
df -h | grep -iv 'filesystem' | \
awk '/dev\/sd.*/ {print "FileSystem: " $1 "\t Used " $5}'

# END statement - executed after the entire input is processed
df -h | grep -iv 'filesystem' | \
awk '/dev\/sd.*/ {print "FileSystem: " $1 "\t Used " $5} \
END { print "Is the output as expected?"}'

# list all .conf files in /etc directory
# field number depends on ls output format
ls -l /etc | awk '/.*\.conf$/ {print $8}'
```

* C-style `printf` available in awk

## GAWK scripts

* **.awk** extension files.
* `BEGIN` and `END` statements executed exactly once and not for every input line.

```aw
BEGIN { print "DISK USAGE REPORT" }
/dev\/sd.*/ { print $1 " \t " $5 }
END { print "REPORT ENDS HERE" }
```

## Field Separator

* `FS` variable. can be a single character or a regular expression.

```bash
#  users with bash as their login shell
awk 'BEGIN { FS=":" } /.*bash/ {print $1 }' /etc/passwd

# users with nologin
awk 'BEGIN { FS=":" } /.*nologin/ {print $1 }' /etc/passwd
```

## Output Field Separator (OFS) and Output Record Separator(ORS)

* Default OFS value - single white space. For default OFS to be applied the field should be separated by **comma** in the print statement

* Any character string may be used as the output field separator by setting this built-in variable.

* The output from an entire print statement is called an output record

* Default ORS value - `\n`

```bash
# Using default OFS and ORS
df -h | awk '/dev\/sd.*/ {print $1,$5}'

df -h | awk 'BEGIN { OFS=":"; ORS="\n-------------\n" } /dev\/sd.*/ {print $1,$5}'

# To get all the records as comma separated entries in the same line
df -h | awk 'BEGIN { OFS=":"; ORS="," } /dev\/sd.*/ {print $1,$5}'
```

## Number of Records(NR)

* Built in variable `NR` holds the number of records processed.
* `NR` is incremented after reading an input line.

```aw
# print the output as csv
BEGIN { OFS=","; print "Processing started" }
/dev\/sd.*/ {print NR,$1,$5}
END { print "Number of records processed: " NR}
```

## User defined variables

* Variables can hold either a string or a numeric value
* No need to refer the variables with `$` prefix like in shell script
* `total = 0` and `total = total + $1` - Spaces can be used in assignments unlike shell script

```aw
BEGIN { OFS=","; print "Processing started" }
/tmpfs/ {
print NR,$1,$2,$3;
total += $2; used += $3
}
END { print "Total: " total ", Used:" used }
```

---

## References

* [Bash beginners guide Chapter 6](books/bash_beginners_guide.pdf)
