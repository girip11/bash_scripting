#!/bin/bash

set -eu
set -o pipefail

function say_hello() {
  if [[ $# -gt 0 ]]; then
    echo "Hello, $1"
  fi
}

# Using echo and command substitution we could return
# a string from a function in bash.
res=$(say_hello Jane)
echo "$res"

function loop_over_array() {
  declare -n languages="$1"

  for lang in "${languages[@]}"; do
    echo "Language: $lang"
  done

  languages+=("typescript")
}

lang_array=("ruby" "python" "javascript" "php" "c" "c++")
declare -p lang_array
loop_over_array lang_array

# lang_array should be modified
echo "${lang_array[@]}"
