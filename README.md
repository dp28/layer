Layer
=====

A command-line tool to convert HTML pages to backgrounds for the gnome terminal.

Installation
------------

```bash
git clone https://github.com/dp28/layer.git
cd layer
make
```

Usage
-----
Running `layer` or `layer render` renders an HTML page at the specified URL to a specified PNG file, then sets this PNG as the background for the terminal. The PNG is rendered to be the size of the terminal when `layer` is run.

Using `layer write` or `layer append`, in combination with -s, allows you to selectively replace or append to parts of the HTML before rendering it. The HTML is saved with these changes.

`layer` with no options uses the defaults specified in ~/.layer/config/layer_config.yml.

Subcommands:

* `render`            (default)
* `write   <content>`
* `append  <content>`
* `help    [command]`

All subcommand options:

-u, --url <url>                  URL of HTML page to use as background.
                                 [default:
                                 file:///home/<user>/.layer/config/example.html]

-i, --image <path>               Location to save new background image
                                 to. [default:
                                 /home/<user>/.layer/background.png]

-p, --profile <profile_name>     Terminal profile to change background
                                 of. [default: Default]

-c, --pixels_per_column <number> How many pixels wide one terminal column
                                 is. [default: 9]

-r, --pixels_per_row <number>    How many pixels high one terminal row
                                 is. [default: 18]

-a, --allow_scroll               Allow the background image to scroll
                                 (may break positioning of the
                                 background). [default: false]

`write`/`append` options:

-s, --selector <css>             The selector to write/append changes to.
                                 Required

-f, --file <path>                The file to write HTML changes to
                                 [default:
                                 /home/<user>/.layer/config/background.html]

Example uses
------------
See the examples/ directory in ~/.layer after installation for an example background and several scripts that modify it.

Dependencies
------------

* Phantomjs
* Ruby
* Gnome and gconftool-2