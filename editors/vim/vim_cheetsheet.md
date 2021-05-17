# Vim editor cheatsheet

Enter command mode by pressing `esc` key and edit mode by pressing `i` when in command mode.

## Basics

### Cursor movement

In command mode,

* `h j k l` -> left, down, up and right (in order)
* w - next word starting
* b - previous word starting
* e - next word ending
* ge - previous word ending
* 0 - start of the line
* $ - end of the line

### Editing text

Toggle insert and command mode

* `i` - enter insert/edit mode before the cursor
* `a` - Enter edit mode after the cursor
* `I` - Enter insert mode in the beginning of the line
* `A` - Enter insert mode at the end of the line
* `esc` - enter command mode
* `:w` - save
* `:wq` - save and exit
* `:q` - exit
* `:q!` - discard the changes and exit

### Clipboard operations

Delete character, line

* `d` - deletes from the cursor to the movement location. If you press `d` and move up, the line where the cursor was when the `d` was pressed and the line above it will be deleted. If the direction is left/right, adjacent characters will be deleted, if the direction is up/down, adjacent lines will be deleted.
* `d$` - Deletes from the cursor to the end of the line (mixing delete and cursor movement)
* `dd` - delete line and copies to the clipboard as well.
* `c` - delete selection and enter insert mode (useful in changing a word/phrase)
* `cc` - delete line and start in insert mode

Undo, redo

* `u` - undo
* `ctrl + r` - redo

Cut, copy and paste

* `x` - cut character pointed by the cursor
* `X` - cut previous character to the cursor
* `dd` - Deletes and copies the line as well (cut operation)
* `y` - copy from cursor to the movement location
* `yy` - copy current line
* `p` - paste after the cursor
* `P` - paste before the cursor

Indentation(works in visual mode)

* `>` - indent one level
* `<` - unindent one level

Visual mode. To enter the visual mode, I have to press `v` every time after executing a command. Visual mode help in selecting chunks of text.

* `v` - enter visual mode. Select a word/phrase or a single line
* `V` - linewise visual mode. Useful to select multiple lines
* `Ctrl + V` - block visual mode

### Find and replace

Search

* `/pattern` - Search for pattern
* `?pattern` - Search backward for pattern
* `n` - Repeat search in same direction
* `N` - Repeat search in opposite direction

First type the pattern and press `Enter` to confirm the pattern. `Esc` to escape from the pattern if you have changed your mind. If you press `Enter`, then pressing `n` or `N` will search in the forward and backward direction respectively.

Search options

* `:set ignorecase` - case insensitive
* `:set smartcase`  - use case if any caps used
* `:set incsearch`  - show match as search proceeds
* `:set hlsearch`   - search highlighting

Search and Replace

* `:%s/search_for_this/replace_with_this/g` - Replace all old with new throughout file (`gn` is better though)
* `:%s/search_for_this/replace_with_this/gc` - Replace all old with new throughout file with confirmations

[Vim regular expressions](http://vimregex.com/)

---

## References

* [Vim cheatsheet](https://vimsheet.com/)
