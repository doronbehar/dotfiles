# My dotfiles

* I use `Neovim`.
* I use `zsh`.
* I don't use 'Oh-My-zsh' - It's too robust in my opinion.
* I have a 'powerlineish' prompt but I tried to make it's setup simple as possible - using the `autoload promptinit`
* I use `zsh-syntax-highlighting`.

## selected scripts and functions:
### `p` (function)
`p` is synonymies for 'project', the function does the following:
* Reads `.config/ranger/bookmarks`.
* Brings you to the directory specified by the bookmarks.
* If the directory is a git repository, you will see `git`'s `status`.
* If you have a `makefile` in that directory, any variables in that file will be sourced to the shell.

##### Usage
You need to use/create a bookmarks file in `.config/ranger/bookmarks` which will looks like that:
```
v:/home/doron/repos/dotfiles/.config/nvim
O:/opt
a:/home/doron/repos/dotfiles/.config/awesome
x:/home/doron/repos/dotfiles/.tmux
```
As for this bookmarks as an example, running `p v` for instance will bring you straight to Neovim's configuration directory.

### `m`
Bookmarks writer for `.config/ranger/bookmarks`. Reads $PWD and adds the character which is added as an argument to the bookmarks file - the companion of `p`.

### `capscr`
Used for the window manager [awesome](https://github.com/Doron-Behar/awesome-files/blob/46012e655b3cb62cce8568eeaac20de41b527f08/rc.lua#L513) to capture the screen contents and save it to `~/pictures/screenshots`.
- Depends on `import` from `imagemagick` packages.
##### Usage
As you can see in my [Awesome-files](https://github.com/Doron-Behar/awesome-files) located in [`.config/`](https://github.com/Doron-Behar/dotfiles/tree/master/.config), You can use different arguments to `capscr` in order to choose from capturing a certain area with the mouse vs capturing the whole window of the current application and the whole screen.
* `capscr all` - used to capture the whole screen, include both monitors.
* `capscr window` - used to capture the window of the current application.
* `capscr frame` - used to capture a certain area with the mouse.

##### Credits
I created the script with help from an [Archinux wiki](https://wiki.archlinux.org/index.php/taking_a_screenshot#ImageMagick.2FGraphicsMagick) and a question in one of the stackexchange sites I shamelessly can't find the link to..

### `mpc-toggle-mute`
A simple script to mute the output of an MPD server you are connected to. It uses `mpc` and essentially it toggles the volume between zero and the previously used volume while storing the previous value of the volume in a `/tmp` file.

### `show256term-colors`
Useful python script to show 256 colors in the terminal. Shamelessly copied from an [archlinux thread](https://bbs.archlinux.org/viewtopic.php?id=101509).

### `mu` and `cu`
Synonymies for memory-usage and cpu-usage, These use `awk` to calculate the amount of RAM/CPU used by a certain program is using. The first, last and only argument to these programs is the name of the program you will perform the test to.

### `toggle-sinks`
Script for cycling between PulseAudio sinks.

### `gi`
A `.gitignore` generator from using [gitigore.io](https://gitignore.io).

### `path`
Small script which shows your `$PATH` with a newline substituted with ':' thus it makes the variable's value more readable on the shell.

### `online`
Inspired by a [stack overflow answer](http://stackoverflow.com/a/14939373/4935114), is a simple script that returns true or false if the computer is currently online.

### `xfile`
Shows the type of file according to `file` of the executable found in `$PATH` which is given as argument.
