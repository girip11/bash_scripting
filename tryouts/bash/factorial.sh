#!/bin/bash

# http://rosettacode.org/wiki/Factorial#bash

set -euo pipefail

declare -i RESULT

function factorial() {
  declare -r n=${1:-0}
  declare -i i=2
  RESULT=1

  if [[ $n -gt 1 ]]; then
    while [[ $i -le $n ]]; do
      RESULT=$((RESULT * i))
      i=$((i + 1))
    done
  fi

  unset -v i
}

factorial 5
echo $RESULT

factorial 10
echo $RESULT

unset -v RESULT
exit 0
