# Loops

SIGINT -  Keyboard interrupt. `ctrl + c`
`kill -2 PID`

## While

Using a while-loop is generally the recommended way in Bash for iterating over each line of a file or stream.

```Bash
# Syntax
while test_condition
do
  # Statements
done

while (( i < 10 ))
do
  # logic
  i+=1
done
```

Example

```Bash
# infinite loop
while : ; do echo "infinite loop"; done

content=$(cat <<EOF
hello world
foo bar
fizz buzz
EOF
)

# read each line
# stops when no more lines are to read
while read line
do
echo $line
done <<< "$content"
```

## Until

Until success(exit code 0) continues execution.

```Bash
until condition
do
  # Statements
done

until false; do echo "infinite loop"; done
```

## For

```Bash
for (( initial; condition; increment ))
do
  # statements
done

# iterate through al characters of a string
str="Hello"
for ((i=0; i< ${#str}; i++))
do
  echo "${str:$i:1}"
done

# Syntax for looping through a list
for item in list
do
  # statements
done

# example
# step by 2
for i in {0..10..2}
do
  echo $i
done

# infinite loop
for ((;;)); do echo "infinite loop"; done
```

## Break

To jump out of loop (exit loop) use the `break` statement.

## Continue

To skip a loop iteration use the `continue` statement.

---

## References

* [Bash Guide by Joseph Deveau](https://www.amazon.in/BASH-Guide-Joseph-DeVeau-ebook/dp/B01F8AZ1LE/ref=sr_1_4?keywords=bash&qid=1564983319&s=digital-text&sr=1-4)

* [Bash loops](https://www.shell-tips.com/bash/loops/)
