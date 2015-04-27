Layer
=====

A command-line tool to convert HTML pages to backgrounds for the gnome terminal.

Installation
------------

```bash
git clone https://github.com/dp28/layer.git
cd gswitch
sudo make
```

Usage
-----
Running `layer` renders an HTML page at the specified URL to a specified PNG file, then sets this PNG as the background for the terminal. The PNG is rendered to be the size of the terminal when `layer` is run.

`layer` with no options uses the defaults specified in ~/.layer/config/layer_config.yml.

Options:

-u, --url <url>                  URL of HTML page to use as background.
                                 [default:
                                 file:///home/jimmy/.layer/config/example.html]

-i, --image <path>               Location to save new background image
                                 to. [default:
                                 /home/jimmy/.layer/background.png]

-p, --profile <profile_name>     Terminal profile to change background
                                 of. [default: Default]

-c, --pixels_per_column <number> How many pixels wide one terminal column
                                 is. [default: 9]

-r, --pixels_per_row <number>    How many pixels high one terminal row
                                 is. [default: 18]

-a, --allow_scroll               Allow the background image to scroll
                                 (may break positioning of the
                                 background). [default: false]

-f, --file <path>                The file to write HTML changes to
                                 [default:
                                 /home/jimmy/.layer/config/background.html]

-s, --selector <css>             The selector to write/append changes to
                                 [default: body]

-w, --write <html>               Content to write to the HTML before
                                 rendering [default: ]

-a, --append <html>              Content to append to the HTML before
                                 rendering [default: ]

-h, --help                       Print help message

Dependencies
------------

* Phantomjs
* Ruby
* Gnome and gconftool-2