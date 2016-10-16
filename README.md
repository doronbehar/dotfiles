# My dotfiles
> Many people have a repo like this, but this is mine.

* I use `zsh` but I can work with bash and not feel the difference at all.
* I use `Neovim` but I'm flexible with Vim.
* I use `powerline` the python powerline from https://github.com/powerline/powerline. I use it in the shell **but not in Vim/Neovim**. From some reason it takes a shit load of my CPU.
* I don't use 'Oh-My-zsh' -- I just don't like it because I'm not sure it's stable as the python based powerline I do use.

## scripts and functions:
### `setup`
`p` is aliased to `. setup` which is located in `~/.bin/` and it does the following:
* It brings you to a predefined directory of a project or a repository.
* If you have a makefile in that directory, any variables in that file will be sourced to the shell.

##### Usage
You need to use/create a bookmarks file in `.config/ranger/bookmarks` which looks like that:
```
v:/home/doron/repos/dotfiles/.config/nvim
O:/opt
a:/home/doron/repos/dotfiles/.config/awesome
x:/home/doron/repos/dotfiles/.tmux
```
Now, if you type **`p <letter>`** you will jump to a directory defined in the bookmarks file.

### `capscr`
Used for the window manager [awesome](https://github.com/Doron-Behar/awesome-files/blob/46012e655b3cb62cce8568eeaac20de41b527f08/rc.lua#L513) to capture the screen contents and save it to `~/pictures/screenshots`.
- Dependent on `import` from `imagemagick`.
##### Usage
As you can see in my [Awesome-files](https://github.com/Doron-Behar/awesome-files) located in [`.config/`](https://github.com/Doron-Behar/dotfiles/tree/master/.config), You can use different arguments to `capscr` in order to choose from capturing a certain area with the mouse vs capturing the whole window of the current application and the whole screen.
* `capscr all` - used to capture the whole screen, include both monitors.
* `capscr window` - used to capture the window of the current application.
* `capscr frame` - used to capture a certain area with the mouse.

##### Credits
I created the script with help from an [Archinux wiki](https://wiki.archlinux.org/index.php/taking_a_screenshot#ImageMagick.2FGraphicsMagick) and a question in one of the stackexchange sites I can't find the link to.

### `load`
Used to reload the shell source files. It accepts the arguments `zsh` or `bash` and it sources the proper files according to it. If you add the script to you `~/.bin/` directory, you need to add
`alias load='. ~/.bin/load'` as well because otherwise the script won't work.

### `rm-view`
This one is very useful for `Vim`/`NeoVim` users.

I use the [`restore_view.vim`](https://github.com/Doron-Behar/restore-view.vim) plugin. Sometimes, something is broken or damaged in the view settings of that directory. You might want to remove the view settings from the `viewdir` and reset these settings. You can manually `cd` into the `viewdir`, find the file and delete it but **rm-view** does that for you. It takes as an argument the file you want to remove it's view settings and deletes the correct file.

### `mpc-toggle-mute`
A simple script to mute the MPD server you are connecting to with `mpc` in the script. Essentially the script toggles the volume between zero and the previously used volume.

### `show-term-colors`
Very useful python script to tell the terminal to show the 256 available colors. Taken from [https://bbs.archlinux.org/viewtopic.php?id=101509](https://bbs.archlinux.org/viewtopic.php?id=101509)

### `memory-usage` and `cpu-usage`
Scripts that use `awk` to calculate the amount of RAM/CPU used by a certain program is using. The 1st and last argument is the name of the program you will perform the test.

### `show-active-sink`
Script used for showing the active sink for PulseAudio.

### `toggle-sinks`
Script for toggling PulseAudio sinks.

### `gi`
gitignore generator from using "gitigore.io".

### `screencast`
Script to start a screen cast in the background using `ffmpeg -f x11grab`.

### `path`
Small script to show the $PATH environment variable with $'\n' instead of ':' and therefor more readable.

### `online`
Inspired by a [stack overflow answer](http://stackoverflow.com/a/14939373/4935114). A simple script that returns true or false if the computer is currently online.
