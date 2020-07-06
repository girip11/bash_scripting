# Bashrc and bashrc profile

* Interactive bash shell - standard input is keyboard and standard output and error point to the screen
* Non interactive bash shell - Shell scripts run in non interactive mode.

* Login shell - when we do SSH, we get a login shell.

> A login shell is one whose first character of argument zero is a -, or one started with the --login option.

## Login shell and `.bash_profile`

`.bash_profile`, `.bash_login`, `.profile` are files that are associated with login shells. `.profile` works with other shells as well. Hence it is recommended to use the `.profile`. A login shell looks for the following files and executes them as well.

```Bash
# bash profile execution logic
if [ -f '/etc/profile' ] then
    . '/etc/profile'
fi

if [ -f '/etc/profile' ] then
    . '/etc/profile'
elif [ -f ~/.bash_profile ] then
    . ~/.bash_profile
elif [ -f ~/.bash_login ] then
    . ~/.bash_login
elif [ -f ~/.profile ] then
    . ~/.profile
fi
```

* Login shell **will not read .bashrc**. So it is common to add the below line to any of `.bash_profile`, `.bash_login`, `.profile`.

```Bash
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
```

## Non login and .bashrc file

When bash shell is started as a non login shell in interactive mode, then it reads **.bashrc**. When you execute the command bash what you get a nonlogin shell.

```Bash
# bashrc file execution logic in non login shells
if [ -f '/etc/bash.bashrc' ] then
    . '/etc/bash.bashrc'
fi

if [ -f ~/.bashrc ] then
    . ~/.bashrc
fi
```

* Shell startup content pertaining to a particular user should go into the user's `.profile` file in the user's home directory, while things common to all users and related to the shell itself should go into **.bashrc**

---

## References

* [Difference Between .bashrc and .bash_profile](https://www.slashroot.in/difference-between-bashrc-and-bashprofile)
