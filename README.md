# My dotfiles
> Many people have a repo like this, but this is mine.

* I use `zsh` but I can work with bash and not feel the difference at all.
* I use `Neovim` but I'm flexible with Vim.
* I use `powerline` the python powerline from https://github.com/powerline/powerline. I use it in the shell **but not in Vim/Neovim**. From some reason it takes a shit load of my CPU.
* I don't use 'Oh-My-zsh' -- I just don't like it because I'm not sure it's stable as the python based powerline I do use.

## scripts and functions:
### `p` (function)
`p` synonymies for 'project', Does the following:
* Reads `.config/ranger/bookmarks`.
* Brings you to the directory specified by the bookmarks.
* If you have a makefile in that directory, any variables in that file will be sourced to the shell.

##### Usage
You need to use/create a bookmarks file in `.config/ranger/bookmarks` which will looks like that:
```
v:/home/doron/repos/dotfiles/.config/nvim
O:/opt
a:/home/doron/repos/dotfiles/.config/awesome
x:/home/doron/repos/dotfiles/.tmux
```

### `m`
Bookmarks writer for `.config/ranger/bookmarks`. Reads $PWD and adds the character which is added as an argument to the bookmarks file.

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
A simple script to mute the MPD server you are connecting to with `mpc` in the script. Essentially the script toggles the volume between zero and the previously used volume.

### `show-term-colors`
Very useful python script to tell the terminal to show the 256 available colors. Taken from [https://bbs.archlinux.org/viewtopic.php?id=101509](https://bbs.archlinux.org/viewtopic.php?id=101509)

### `mu` and `cu`
Synonymies for memory-usage and cpu-usage, These use `awk` to calculate the amount of RAM/CPU used by a certain program is using. The 1st and last argument is the name of the program you will perform the test.

### `toggle-sinks`
Script for toggling PulseAudio sinks.

### `gi`
gitignore generator from using "gitigore.io".

### `screencast`
Script to start a screen cast in the background using `ffmpeg -f x11grab`.

### `path`
Small script which shows your `$PATH` with $'\n' substituted with ':' and thus makes the variable's content more readable on the shell.

### `online`
Inspired by a [stack overflow answer](http://stackoverflow.com/a/14939373/4935114). A simple script that returns true or false if the computer is currently online.

### `xfile`
Shows the type of file according to `file` of the executable found in `$PATH` which is given as argument.
