# Linux Operating System

## `man` command

- `man man` to learn about the various options.

```Bash
# to display one line manual page descriptions
man -f ls # whatis ls

# search the keyword in the short manual page descriptions
man -k "<keyword>"
```

## `ls` command

Examples with commonly used options.

```Bash
# list all including . and ..
# l - long listing with owners
ls -hal

# list only the directories under current directory
ls -ldh ./*/

# one entry per line with slash added to directory
ls -1p

# without group owner
ls -hag

# directories first excluding . and .. with owners
# with folders and files sorted by size
ls -hAlS --group-directories-first

# to reverse add the -r option
ls -hAlSr --group-directories-first

# sort the listing by time
ls -halt --group-directories-first

# exclude matching from listing
# exclude the hidden items
ls -halt --group-directories-first --ignore=.*

# recursive listing of directory contents
ls -hAlR --group-directories-first --ignore=.*

# to show the details of files pointed by the symbolic link use L
ls -hAlL "/usr/local/bin"
```

## `mkdir` command

```bash
# -p make parent directories as required
mkdir [-m chmod_perm] [-p] "directory_name"
```

## `rmdir` command

```bash
# all dirs in the path are deleted.
# This will delete all those directories that are empty
rmdir [-p] "dir_path"

# to delete nonempty directories use
rm  -fr "dir_path"
```

## `file` command

Helps in identifying the type of file.

```bash
file "file_name_with_ext"

# look in to the type of files inside compressed files
file -Z abc.zip

# output mime type strings like text/x-shellscript
file -i hello.sh
```

## `touch` command

```bash
# dont create the file
touch -c "filename.ext"

# change the modification time
touch -m "filename.ext"

# copy the times from the reference file to the actual file
touch -r "ref_file.ext" "actual_file.ext"
```

## `cp` command

```bash
# interactive copy
cp -i a/file.txt b/file.txt

# force copy
cp -f a/file.txt b/file.txt

# recursive copy all contents of a folder
cp -r src_dir target_dir

# preserve mode owner timestamps and not to overwrite if file
# already existing in the target directory
cp -np a/file.txt b/file.txt

# make symbolic links(soft link) instead of copying
# we need to use absolute paths
cp -sv /home/user/pictures/a.png /home/user/photos/a.png

# recursive replication of a directory structure
# This will replicate src_dir hierarchy (with all soft links) inside the target_dir
cp -rsv src_dir target_dir
```

## `mv` command

When conflicting options are provided the last one parsed is always honored.

- `mv -fi` - same as `mv -i`
- `mv -if` - same as `mv -f`

Useful options `mv -i`, `mv -f`, `mv -n`, `mv -fb --suffix=.bkp src_file dest_file`

## Working with file contents

### `head`

```bash
# first 1KB(1024 bytes) of a file
head --bytes=1K file.txt

# first n lines of a file
head -n 20 somefile.txt
```

### `tail`

```bash
tail --bytes=1K some_file.txt

tail -n 30 some_file.txt
```

### `cat`

- Display entire contents of a file to STDOUT.

```bash
# display with line numbers
# -T show tabs
cat -nT some_file.txt

# can read contents from stdin as well
cat -n <some_file.txt

# read from here string and redirect to a file
cat <<<"hello world" > dummy.txt

# concatenate multiple file contents to single file
cat file1.txt file2.txt > merged.txt

# whatever we type to stdin gets written to the file
cat > capture_out.txt
```

### `more`

```bash
more -n 10 some_file.txt

# starts displaying file contents from the string match
more +/hello some_file.txt
```

### `less`

```bash
less -n 10 some_file.txt

# less starts with the first occurence of the word less in the file
less --pattern=less notes.md
```

Once in `less` mode we can type `/pattern` to search forward the pattern in the file and `?pattern` to search backward and `&pattern` to display the lines that match the pattern.

Basically we can do so much more finding and searching using the `less` command.

## Filesystem structure

- `/bin` link to `/usr/bin`
- `/boot`
- `/dev` - devices directory. Physical devices are mounted under this directory.
- `/etc` - configuration files
- `/home` - user's home directory
- `/lib`, `/lib32`, `/lib64` and `/libx32` - libraries
- `/media` - for hard disks, USB mounting
- `/mnt` - mount shared drive
- `/opt` - optional software
- `/proc` - processes directory to store process IDs.
- `/root` - home directory of root user.
- `/run` - automounting drives under this directory
- `/sbin` - system binaries
- `/snap` - snap packages
- `/srv` -
- `/sys` -
- `/tmp` - temporary data
- `/usr` - common packages to be shared between users
- `/var` - variable data like `/var/log`

## System information

- `uptime` - how long the system is running
- `free -h` or `free -m` in megabytes
- `ps -A` or `ps -e`
- `df -ah` filesystem usage and `du -h` file space usage
- `fdisk -l`
- `lsblk` - lists special block devices
- `top` and install `htop` using `sudo apt install -y htop`

## Networking

- `man ifconfig`. If `ifconfig` is not available install it using `sudo apt install -y net-tools`

```bash
ifconfig -a
ifconfig -s
```

- `ip` command is an advanced alternative to `ifconfig`

## `apt` Package manager

```bash
sudo apt update
sudo apt list --upgradable
sudo apt upgrade

# search for the package in the available repositories
# search for unzip package in the repositories
sudo apt search "unzip"

sudo apt install -y "package name"

sudo apt remove -y "unzip"
```

---

## References

- [Linux Operating System - Crash Course for Beginners][1]
- [cp command](https://www.lostsaloon.com/technology/how-to-create-a-symbolic-link-in-linux/)
- [mv command](https://www.computerhope.com/unix/umv.htm#backup-files)

[1]: https://www.youtube.com/watch?v=ROjZy1WbCIA
