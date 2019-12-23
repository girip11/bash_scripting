#!/bin/bash

function say_hello() {
  echo 'Hello World' && echo "foo bar"
}

say_hello | wc -l
