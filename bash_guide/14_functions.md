# Functions

```Bash
# function syntax
function function_name() {
  # commands
}

# alternate syntax
function_name() {
  #commands
}

# example
function simple_function() {
  echo "Hello world"
}

# calling the function
simple_function
```

**Function definition must precede its call. Call to empty function also results in error. Function must have atleast 1 command.**

Function call is equivalent to a command. Nesting of functions is possible.

Functions can access and modify global variables. local variables inside a function are not visible outside. local variables are defined using the `local` keyword. Any variable defined inside a function using `declare` builtin will be local by default.

Inside a function, local variable hides the global variables with the same name. Without the **local** keyword, variable inside the function becomes **globally available to that script**.

```Bash
function print_message(){
  local msg="Hello world"
  RESULT="$msg"
  echo "$msg"
}

# RESULT not yet defined.
echo "RESULT=$RESULT"
print_message

echo "RESULT=$RESULT"
# variables declared as local are not visible outside the function
echo "MESSAGE:$msg"

# declaring an array visible only within a function. local accepts all options accept by declare.
function local_array_example() {
  local -a arr=(1 2 3)

  for i in "${arr[@]}"
  do
    echo $i
  done
}

local_array_example
```

## Parameter to functions

Function parameters are accessed as positional parameters starting from $1 similar to a script.

```Bash
function say_hello() {
  echo "Hey, $1"
}

say_hello "Roger Federer"
```

Functions do not have access to the script parameters directly unless passed as parameters in the function call.

## Passing array to function

Passing array as parameter to the function. Modifying the parameter array does not modify the original array in this approach.

```Bash
function loop_over_array() {
  local arr=("$@")

  for lang in "${arr[@]}"
  do
    echo "Language: $lang"
  done
}

lang_array=("ruby" "python" "javascript" "php" "c" "c++")
declare -p lang_array
loop_over_array "${lang_array[@]}"
```

Above approach can be used when we don't want the function to modify the source array.

## Passing indexed and associative array to function as name reference

This approach can be used for arrays as well as associative arrays. When we use name reference, any modification on the name reference is reflected on the underlying variable. So this approach can be used to pass when we want the target function to populate some data and return it.

* Indexed arrays can also be passed to [functions via name reference](https://unix.stackexchange.com/questions/510715/what-is-a-name-reference-variable-attribute).

```Bash
function loop_over_array() {
  declare -n languages="$1"

  for lang in "${languages[@]}"
  do
    echo "Language: $lang"
  done

  languages+=("typescript")
}

lang_array=("ruby" "python" "javascript" "php" "c" "c++")
declare -p lang_array
loop_over_array lang_array
echo "${lang_array[@]}"
```

* Associative arrays can also be passed to functions as name reference

```Bash
# This is supported from bash 4.3

# using name reference, we can even modify the associative array
function loop_over_dict() {
  local -n arr=$1

  for field in "${!arr[@]}"
  do
    echo "$field: ${arr[$field]}"
  done

  arr[greeting]="hello"
}

declare -A person
person["name"]="John Doe"
person[gender]="male"

declare -p person
loop_over_dict person

# observe the greeting entry added to the person
declare -p person
unset -v person
```

## Functions returning values

* Functions in bash does not return any value. Returns just the exit code.

* One approach is to use global variables **RESULT**, **EXCEPTION** and **EXCEPTION_MSG** to store the result, error code and error message respectively.

```Bash
function get_value() {
  return 10
}
get_value
echo $? # this way we can return values.

# way to return a string
# doesnot work when the function has multiple echo statements
function to_upper() {
  local input_str=$1
  RESULT=""
  EXCEPTION=""
  EXCEPTION_MSG=""

  if [[ -z $input_str ]]
  then
    EXCEPTION=1
    EXCEPTION_MSG="Input string is empty"
  else
    RESULT="${input_str^^}"
  fi
}

to_upper "hello"
echo "$RESULT"
```

* Another approach is to use `echo` to return a string and use command subtitution to get the return value.

```Bash
function say_hello() {
  if [[ $# -gt 0 ]]; then
    echo "Hello, $1"
  fi
}

res=$(say_hello Jane)
echo "$res"
```

---

## References

* [Bash Guide by Joseph Deveau](https://www.amazon.in/BASH-Guide-Joseph-DeVeau-ebook/dp/B01F8AZ1LE/ref=sr_1_4?keywords=bash&qid=1564983319&s=digital-text&sr=1-4)
