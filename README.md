# Layer

A command-line tool to change the GNOME terminal background from Jade templates
and JSON data.

## Simple example

With the Jade template:
````jade
html
  head
    style.
      body {
        background: black;
        color: white;
      }

      h1 {
        float: right;
      }
  body
    h1 Hello, #{test}
````

and JSON:
````json
{
  "test": "layer"
}
````

renders the output:

![layer-render](https://cloud.githubusercontent.com/assets/2752129/10805169/b7bc23e0-7dc3-11e5-8c7f-89b43b9c743d.png)

## Why
Layer makes it possible to programmatically change the terminal background as a
way of providing information without disrupting your workflow. For example, it
can be used:
* To notify you that a long-running script has finished (*see the provided
'notifications' template*)
* As an in-your-face todo list (*see the provided 'todo' template*)
* As a reference for keyboard shortcuts that you do not yet know

## Installation

Provide code examples and explanations of how to get the project.

## Usage
`layer <command> [options]`
### Commands
#### new
**Arguments:** `-t`/`--template`, `-d`/`--template-data`, `-j`/`--template-jade`

Stores a named reference to the Jade and JSON files specifed. The created
template reference can be set as the default template using the **config**
command.

#### render
**Arguments:** `-t`/`--template`, `-d`/`--template-data`, `-j`/`--template-jade`,
`--profile`, `--allow-scroll`, `--image-file`, `--column-width`, `--row-height`

Render a template to the terminal background. The exact Jade and JSON files can
be specified, as can the location for the background image to be saved.

In addition, some terminal properties can be specifed or set: the GNOME profile
whose background to change, whether the image scrolls when the terminal scrolls
and the mapping between row/column sizes and pixels (to ensure the image is
scaled to fit the terminal correctly).
#### write
**Arguments:** `-k` /`--key`, `-v`/`--value`, `-t`/`--template`

Write some JSON or a string to a particular key within an object in the data
for a template, then render that template. For example, with the template data:
````json
{
    "test": {}
}
````
`layer write -k test.child -v success` updates the template to:
````json
{
    "test": {
        "child": "success"
    }
}
````
#### append
**Arguments:** `-k` /`--key`, `-v`/`--value`, `-t`/`--template`

Similar to **write**, but appends values rather than replacing them.
#### read
**Arguments:** `-k` /`--key`, `-t`/`--template`

Print a value from within a template to the console. For example, with the
template data:
````json
{
    "test": [1, 2, 3]
}
````
`layer read -k test[0]` prints `1` to the console.
#### remove
**Arguments:** `-k` /`--key`, `-t`/`--template`

Delete the value of a key within a template's data. If the key is an index into
an array, the array is reduced in size.
#### list
List the names of all saved templates.
#### show
**Arguments:** `-t`/`--template`

Print a template and its data to the console.
#### delete
**Arguments:** `-t`/`--template`

Deletes a reference to a named Jade template and JSON data file. This does not
remove the files themselves.
#### config
**Arguments:** The same as **render**

Shows the stored default settings for layer, or updates them if a setting name
and value are passed.

## License

MIT