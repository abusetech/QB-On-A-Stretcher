# QB-on-a-Stretcher
A barely serviceable RESTful web application framework for a language that probably shouldn't be on the web

## Limitations
This framework is still very much a work in progress. It is likely to be buggy, broken and unreliable. The handling of POST requests is currently untested under Linux and not possible under Windows. Currently, there is no built-in way of reading data from stdin on Windows in QB64, which makes handling POST requests impossible on these operating systems without an external library.

## Usage
Copy the files into your project directory.

Add the following lines to the beginning of your program:

```
$SCREENHIDE
$CONSOLE
_DEST _CONSOLE
'$INCLUDE: 'qbonas.bi'
```

Add the following line after your main program code, but before any FUNCTIONS or SUBS in your program:

`'$INCLUDE: 'qbonas.dt'`

Add the following line to the end of your program:

`'$INCLUDE: 'qbonas.bm'`

Documentation is as of yet unwritten, but the comments in the library (*.bm) files explain much of the functionality.

* qbonas.bi contains dictionaries (maps) for the CGI query string and HTTP response headers
* dict.bm is a dictionary/map implementation using arrays of a custom type
* string.bm contains many string manipulation and search functions
* encoding.bm contains functions for percent encoding, decoding and special character escaping
* templater.bm contains one function for substituting variables into an HTML template

## Examples
See example_html.bas for a CGI example. If you want to try this example using a real web server, you will need to change `TEMPLATE_DIR` to the absolute path to the example_templates directory.

