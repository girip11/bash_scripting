# Chapter-5

## Variables

Variables hold some value. Based on the value it holds its type can be integer, string or array.

```Bash
# Variable declaration and initialization
# identifier=value. No space allowed between identifier, = and value. Otherwise bash considers identifier as command and = and value are its arguments.

set -xv # enables verbose debugging
declare -i count=1 # variable count holds an integer
echo $count # prints the value of count
name='Girish' # variable holds a value of type string
fruits=('Apple' 'Orange' 'Mango') # variable holds a value of type array
```

## Strings

Single quote used to take the value as it is(literal value). Double quotes is used when **string interpolation** is required.

```Bash
# execute the below snippet and observe the difference.
# escaping doesnot work within single quotes.
name='Girish Pasupathy'
echo 'My name is $name \"'
echo "My name is \"$name\""
echo ${#name} # prints the string length
```

Variable value is inferred using `$identifier`. Bash replaces value of the variable against the `$identifier` and the executes the command.

While executing the command, Bash splits the words in to tokens using any whitespace. To pass the value of `$identifier` unmodified to the command, enclose the `$identifier` within **double quotes** to make it a string argument to the command.

```Bash
movie_name="Batman           vs           Superman"
echo $movie_name  # observe does not retain spacing in the movie_name
echo "$movie_name" # retains spacing in the movie_name
```

**NOTE**: Always double quote a string which contains any whitespace (space, table or newline).

## Integers

```Bash
# Integer needs to be declared explicitly and erased explicitly.
# Syntax: declare -i variable_name=value
# unset variable_name
declare -i count=1
count+=100
echo $count
unset count
# or unset -v count


#NOTE: below statement assigns a string of value 100 to the variable. + performs string concat.
count=100
count+=10
echo $count
```

* We can also use the `let` builtin to perform arithmetic operations on the declared integer variable.

## Read only variables

**Once set, the variable cannot be unset**. Variable lifetime is till end of the shell process.

```Bash
declare -r msg="Hello world"
echo $msg
unset $msg
echo $msg
```

## Commonly used Shell variables

To list the shell variables use the command `declare -p`

* $BASH
* $BASH_VERSION
* $HOME - current logged in user home directory path
* $HOSTNAME
* $IFS - Internal Field separators
* $PWD - present working directory
* $OLDPWD - previous working directory
* $PATH - command search path
* $PIPESTATUS - array that consists of exit codes of all the commmands in the pipe stream
* $PPID - current shell's parent PID
* $RANDOM - pseudo random integer [0 - 2^15]
* $SECONDS - script execution time in seconds.
* $UID - current user ID

```BASH
echo $RANDOM
```

Name script variables lowercase to avoid name collision with shell variables. Shell variables are used only for read only purposes. They are never set/unset. **shell variable are different from environment variables**

Shell variable is visible only within the current shell/process, while environment variable is visible to the current shell's child processes. In otherwords, child processes inherit environment variables of parent processes.

To print all the non exported and exported shell variables(environment variables), we can use the `( set -o posix ; set )`

## Environment Variables

> Environment variables are a list of name=value pairs that exist whatever the program is (shell, application, daemon…). They are typically inherited by children processes (created by a fork/exec sequence): children processes get their own copy of the parent variables. - [Shell vs environment variables](https://unix.stackexchange.com/questions/363525/what-is-the-difference-in-usage-between-shell-variables-and-environment-variable)

Environment variables are created using `export` shell built-in. Or a shell variable can be exported to become an environment variable with the `export` command.

```Bash
# create an environment variable
export SHELL_VAR=xyz

# or export a shell variable
EDITOR=vim
export EDITOR
```

To persist shell variables, we can use the following ways

* To persist for current user only, add `export SHELL_VAR=xyz` to the `~/.profile`
* To persist for all the users in the system, place the `export` statement inside an `.sh` file which should be placed inside the `/etc/profile.d/` directory.

`printenv` can be used to print all the environment variables. This will be handy when we need to know what all variables will be passed to the child processes created by the current shell.

```Bash
# prints all the environment variables
printenv

# prints a particular environment variable value
printenv HOME

# or using echo
echo $HOME
```

`env` command is used to manipulate the environment variables of the current shell.

```Bash
# prints all the environment variables
env

# set an environment variable and execute the command
env CUSTOM_GREETING="Hello" bash -c 'echo $CUSTOM_GREETING'

# env can also unset an environment variable before executing a command
env --unset=SOME_ENV bash -c 'echo $SOME_ENV'

# env can be used to change the working directory before executing a command
env --chdir="PATH_TO_DIR" bash -c 'echo $PWD'
```

**NOTE**: Both shell and environment variables are local to the shell/process defined them.

---

## References

* [Bash Guide by Joseph Deveau](https://www.amazon.in/BASH-Guide-Joseph-DeVeau-ebook/dp/B01F8AZ1LE/ref=sr_1_4?keywords=bash&qid=1564983319&s=digital-text&sr=1-4)
* [Environment Variables](https://help.ubuntu.com/community/EnvironmentVariables)
