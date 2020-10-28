# Input and output

**Input** - positional parameters, special parameters, files, streams, pipes, shell and environment variables.
**Output** - files, streams, pipes, shell and environment variables.

## Positional and special parameters

* `$1` - positional
* `$?` - special parameters.

## Shell variables

* Shell variables are local to shell while environment variables are system wide.
* Shell variables when exported become environment variables and are available to the child processes spawned by the parent process in which the shell variable was exported.

## Environment variables

To list all environment variables in a shell use `printenv` command. (`man printenv`).

```Bash
# Prints all environment variables
printenv

# print the value of specific environment variable
printenv HOME

# env is mostly used for manipulating environment variables
# when executing commands
env

# List all SHELL variables
# =================================
declare -p

# exported variables
declare -px

# To list the shell variables
# In posix mode only shell variables are listed
(set -o posix; set) | less
```

Commonly used ones are listed below. For exhaustive list refer the book.
| Variable | Description                          |
| -------- | ------------------------------------ |
| HOME     | current user's home directory        |
| HOSTNAME | system's name                        |
| PATH     | search path for commands             |
| PWD      | current working directory            |
| SHELL    | path to current user's shell program |
| USER     | currently logged in user             |

> If a change is made to a shell variable, it must be explicitly "exported" to the corresponding environment variable in order for any forked subprocesses to see the change. Recall that shell variables are local to the shell in which they were defined.

* Full listing of the environment variable is obtained using the `printenv` command.
* `export` - add or change environment variable.
* `unset` - remove the environment variable.

```Bash
# add my_dir to PATH
export PATH="$HOME/my_dir:$PATH"

# unset SHELL and add bash as the new value
unset SHELL

export SHELL="/bin/bash"
```

**Environment variables of running programs cannot be changed. Changes made in current shell will reflect in any of its child processes only.**

Changes made to environment variables are valid only during the lifetime of the shell program unless persisted in one of the below files.

* `~/.pam_environment`
* `~/.bashrc`
* `~/.profile`
* `/etc/environment`

* In scripts use **source** or **exec** to reread/refresh the environment changes.

```Bash
source <path to script containing environment variables>

# or

exec bash
```

## Standard streams

* stdin (file descriptor 0)
* stdout (file descriptor 1)
* stderr (file descriptor 2)

## File descriptors (FD)

FD - access file, stream ,pipe, socket, device, network interface etc.

* File descriptor is an abstraction between the hardware device and the device file created by kernel(ex: `/dev` directory).

| stream | Default  | FD  |
| ------ | -------- | --- |
| stdin  | keyboard | 0   |
| stdout | console  | 1   |
| stderr | console  | 2   |

* To redirect from a file descriptor to stdin `<&fd` or `0<&fd` is used.

* To redirect from stdout to a file descriptor `>&fd` or `1>&fd` is used.

* To close a file descriptor `fd>&-`

## Reading using custom file descriptors

```Bash
# open a file for reading using custom file descriptors
exec 3< file

# once a shell is opened using this file descriptor
# input can be read from this file by specifying the file descriptor
# for example
read -u 3 line # read a line from the file
echo $line
```

Redirect a custom file descriptor to stdin of a command

```Bash
# redirects FD3 to stdin of grep
grep -i "foo" <&3
```

Closing the file using file descriptor.

```Bash
# By redirecting 3 to **-**, bash closes the file with FD 3
exec 3>&-
```

## Writing to file using custom file descriptors

```Bash
# open a file for writing
exec 4>file

# redirecting stdout same as 1>&4
echo "hello world" >&4

# closing the file using the file descriptor
exec 4>&-
```

Opening a file for reading and writing using file descriptor is done using the `<>` diamond operator.

```Bash
exec 3<>file

# writing
echo "hello world" >&3

# reading from file
read -u 3 line

# closing the file
exec 3>&-
```

## File redirection

Output redirection carried out using `>` or `>>`. Ex: redirect output of a program from console(default) to a file.

* Redirection to file using `>` - creates non existent file and overwrites the existing file.

* Redirection to file using `>>` - creates non existent file and appends to the existing file.

```Bash
# output written to file and not on console.
echo "Hello world" > output.txt
```

Input redirection is done using `<`.

```Bash
# reads the content of file output.txt
cat output.txt

# or using input redirection. contents of file available to as stdin. Here stdin points a file rather than to input frmo keyboard(default)
cat < output.txt
```

## Redirection using file descriptors

[Article on bash redirection](https://catonmat.net/bash-one-liners-explained-part-three)

```Bash
# redirect stdout to file
echo "This text gets stored in the file" > output.txt

# redirect stdout to file using file descriptor
echo "This text gets stored in the file" 1> output.txt

# file to stdin
cat < output.txt

# input redirection using file descriptor
cat 0< output.txt
```

* `/dev/null` - null device (discards anything written to it). When output and error are to be ignored, redirect stdout and stderr to this.

* Redirect stderr (file descriptor is 2) to stdout (file descriptor is 1) using `2>&1`. File descriptors are read from **left to right**

* Just `>&` or `&>` redirects stderr to stdout (same as `2>&1`).

```Bash
# common use case. ignore stdout and stderr
./my_script.sh > /dev/null 2>&1

# shorthand notation for above command
./my_script.sh >&/dev/null

# common use case. redirect both stdout and stderr to a file. this is the **CORRECT** version
# 1. redirect FD1 to file
# 2. duplicate FD1 and place it in place of FD2
./my_script.sh > my_script.log 2>&1

# below version is **INCORRECT**
# 1. duplicate FD1 and place it in place of FD2
# 2. redirect FD1 to file
# because duplication happened before redirection, FD2 never gets redirected to FD1
# in this case only stdout is captured in the file.
# stderr is still directed to the console(default)
./my_script.sh 2>&1 > my_script.log
```

## FIFO(named pipe)

**F**irst **I**n **F**irst **O**ut. Create FIFO using `mkfifo` command. No contents stored on the file system. Kernel passes the data internally.

* FIFO blocks the read operation, until a write operation happens and vice versa.

* FIFO file have user permissions. `[[ -p FILE ]]` checks is the file is a named pipe.

## Pipe

Connects stdout of one command to stdin of another. Each command following a pipe is executed in its subshell. `set -o pipefail` makes the pipe fail as soon as any command in the pipeline fails with non zero exit code.

```Bash
# stdout of first command to stdin of second command
cat planets.txt | grep -i "earth"

# to redirect both stdout and strerr to stdin use |&
cat planets.txt |& grep -i "earth"

# or
cat planets.txt 2>&1 | grep -i "earth"

echo "${PIPESTATUS[@]}"
```

`PIPESTATUS` array saves the exit codes of all the commands in the pipe stream.

## Process substitution

Allows to pipe stdout of multiple commands to another command.

```Bash
# syntax
# no space between > and ()
cmd <(list)
cmd >(list)

# example
# comm is a command to compare two sorted files
# comm --help
# finding unique lines to each file
comm -3 <(sort file1 | uniq) <(sort file2 | uniq)
```

Bash replaces `<()` or `>()` with a file descriptor of a **named pipe** that it created.

In process substitution, bash handles the FIFO files.

* Input substitution `consumer_cmd <(producer_cmd)` - `consumer_cmd` reads from the named pipe while the `producer_cmd` writes to the named pipe.
* Output substitution `producer_cmd >(consumer_cmd)`

```Bash
# In the output, observe the file descriptor created and used by bash to execute this command.
wc -l < <(cat planets.txt)

# Contents of namedpipe for <(grep -i "ar" planets.txt) will
# be redirected to stdin of the wc command
wc -l < <(grep -i "ar" planets.txt)

# stdout of echo will be redirected to the named pipe for  >(cat)
# cat command will read from that named pipe.
echo "hello world" > >(cat)
```

Redirecting stdout to one command while redirecting stderr to another command using process substitution is possible

```Bash
# bash replaces >() with a file descriptor.
# command inside >() listens to the file descriptor(blocked till someone writes)
# when the command executes, the output and error gets redirected to respective files and those commands get unblocked.
cmd > >(stdout_cmd) 2> >(stderr_cmd)

# after FD replacement above command looks as
# command 1> fifo_file1 2> fifo_file2
```

## tee utility

`tee` takes an input stream and duplicates it to a **file and stdout**.

```Bash
# command -> tee -> stdout
#             |
#           file
cmd | tee file
```

## `read` shell built-in

* read data from stdin, file or file descriptors into a variable. Refer [Chapter_7](./chapter_7.md)

---

## References

* [Bash Guide by Joseph Deveau](https://www.amazon.in/BASH-Guide-Joseph-DeVeau-ebook/dp/B01F8AZ1LE/ref=sr_1_4?keywords=bash&qid=1564983319&s=digital-text&sr=1-4)
* [Bash redirection](https://catonmat.net/bash-one-liners-explained-part-three)
* [Process substitution - linuxjournal](https://www.linuxjournal.com/content/shell-process-redirection)
* [Process substitution - tldp](https://www.tldp.org/LDP/abs/html/process-sub.html)
