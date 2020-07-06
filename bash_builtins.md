# Bash Builtins

Generally, a Bash builtin does not fork a subprocess when it executes within a script. An external system command or filter in a script usually will fork a subprocess.

~~~bash
# listing all builtins in bash

~~~

## `alias` and `unalias`

~~~bash
alias dcon='docker container'

dcon --help

unalias dcon
~~~

We can define useful aliases in say `.docker_aliases` in the user's `$HOME` directory and include it in `.bashrc` as follows

~~~bash
if [[ -s ~/.docker_aliases ]]; then
  . ~/.docker_aliases
fi
~~~

---

## References

* [Bash builtins](https://www.tldp.org/LDP/abs/html/internal.html)
