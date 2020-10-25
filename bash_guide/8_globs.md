# Chapter-8: Globs

* Globs(wildcards) are not regular expressions. These are wildcards for searching files. **Glob characters helps in pathname expansion**. Pathname expansion is also known as filename expansion.

* If one of the below characters appear, then the word is considered as a pattern and is replaced with matching files sorted **alphabetically**.

**NOTE**: globbing/pathname expansion **doesnot work as expected inside either single or double quotes.**

```Bash
# Note the difference when globs are put inside quotes
# and used without quotes

# Does path name expansion and prints all file names ending with .java
echo *.java
echo '*.java' # prints *.java
echo "*.java" # prints *.java


# Here the pattern is expanded to all the files in
# directory /etc/cron.d and made in to a single string
# This loop will run for only one iteration
for file in "/etc/cron.d/*"
do
  echo "$file"
done

# Iterates through every file in the directory /etc/cron.d/
for file in /etc/cron.d/*
do
  echo "$file"
done
```

## Glob characters

* `?` - matches a single character against any value(wildcard character)
* `*` - matches any number of characters with any value(wildcard string)
* `[]` - matches a single character for a list of values or ranges (wildcard list)

## `?` glob

```Bash
# list all the file in the current directory
ls doc?.md
```

## `*` glob

```Bash
# prints all files/folders in the current folder
echo *

# removes all the files in the current directory
rm *
```

**NOTE**: Neither of the above mentioned wilcards match `/`. When matching a file name, the slash character must always be matched explicitly.

## `[]` glob

```Bash
# any number of individual characters
# match any file/folder inside /usr/bin starting with either
# e or g or p followed by any number of characters
ls /usr/bin/[egp]*

# range example. range also matches a single character only with a range of values
ls /usr/bin/[a-z]*

# negation. Matches files/folders beginning with any characters(not just alphabets) other than from e-l.
ls /usr/bin/[^e-l]*

# special characters like itself in the pattern [] requires escaping
ls /usr/bin/*[\[\]]
```

## `shopt` builtin

`shopt` shell builtin is used to set or unset the following glob options.

## `nocaseglob` option

If the shell option `nocaseglob` is enabled, the match is performed without regard to the case of alphabetic characters.

## `failglob` option

* If the failglob shell option is set, and no matches are found, an error message is printed and the command is not executed.

## `nullglob` option

when a glob doesnot match any of the filenames, glob matches itself (i.e) glob expands to itself. But if nullglob shell option is enabled, **the glob incase of no match expands to null instead of itself.**

```Bash
for file in *.txt
do
  echo "$file"
done

# when no files match *.txt found, still *.txt itself is printed.
# problematic in conditions, loops where we check if atleast one file exists.
```

**nullglob** can be enabled/set using the shell option `shopt -s nullglob`

**nullglob** can be disabled/unset using the shell option `shopt -u nullglob`

## `dotglob` option

If this shell option is set, bash includes the files starting with **.** in the results of pathname expansion.

```Bash
# enabling dotglob
shopt -s dotglob

# disabling dotglob
shopt -u dotglob
```

> The `GLOBIGNORE` shell variable may be used to restrict the set of file names matching a pattern. If `GLOBIGNORE` is set, each matching file name that also matches one of the patterns in `GLOBIGNORE` is removed from the list of matches. The file names `.` and `..` are always ignored, even when `GLOBIGNORE` is set. However, setting `GLOBIGNORE` has the effect of enabling the dotglob shell option, so all other file names beginning with a `"."` will match. To get the old behavior of ignoring file names beginning with a `"."`, make `".*"` one of the patterns in `GLOBIGNORE`. The dotglob option is disabled when `GLOBIGNORE` is unset. [File name expansion](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_04.html)

## Extended globs using `extglob` option

Extended globs allow for pattern matching, while normal globs allow for matching individual characters.

```Bash
# enabling extglob
shopt -s extglob

# disabling dotglob
shopt -u extglob
```

Extended glob matching patterns

* `?(list)` - matches zero or one occurence of the patterns in the same string
* `*(list)` - matches zero or many occurence of the patterns in the same string
* `+(list)` - matches atleast one occurence of the patterns in the same string
* `@(list)` - matches exactly one occurence of the patterns in the same string
* `!(list)` - matches anything other than the patterns mentioned in the same string

```Bash
$ ls
abbc  abc  ac
$ echo a*(b)c
abbc abc ac
$ echo a+(b)c
abbc abc
$ echo a?(b)c
abc ac
$ echo a@(b)c
abc

# list all directories starting with lowercase alphabets and containing
# atleast one "l" in the string and ends with either "s" or "e"
echo [[:lower:]]*+(l)*@(s|e)
```

* `**` - Feature known as **globstar**. Matches all files and zero or more directories and subdirectories. If followed by a `/` it matches only directories and subdirectories. **To work that way it must be the only thing inside the path part e.g. `/myapp/**.js` will not work that way.**

> The ** symbol you're asking about is known as the "globstar". In most unix pattern matching, the * can only represent one directory level. The globstar allows you to specifiy an unknown number of in-between directories. [meaning of `**`](https://stackoverflow.com/questions/21834939/can-someone-explain-what-this-means-js-when-trying-to-fetch-the-src-files-i)

* `{}` - Brace expansion. `**/*.{a,b}` will be expanded to `**/*.a` and `**/*.b`. `**/*.{a..c}` will be expanded to `**/*.a`, `**/*.b` and `**/*.c`. The final result is the union of checking all the expanded patterns.

To play with globs we can use [globster](https://globster.xyz/)

---

## References

* [Filename expansion](https://www.gnu.org/software/bash/manual/html_node/Filename-Expansion.html)
* [Bash Guide by Joseph Deveau](https://www.amazon.in/BASH-Guide-Joseph-DeVeau-ebook/dp/B01F8AZ1LE/ref=sr_1_4?keywords=bash&qid=1564983319&s=digital-text&sr=1-4)
* [nullglob](https://www.cyberciti.biz/faq/bash-shell-check-for-any-mp3-files-in-directory/)
* [Extended globs](https://www.linuxjournal.com/content/bash-extended-globbing)
