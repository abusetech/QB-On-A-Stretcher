# QB-on-a-Stretcher
A RESTful web application framework written in a language that long predates the web


## About

I started this project as a programming challenge to create a web application framework from the ground up in a vintage programming language. This project was created in a similar vein to [COBOL-on-wheelchair](https://github.com/azac/cobol-on-wheelchair), which is itself a humorous take on [Ruby on Rails.](https://rubyonrails.org/)

It isn't *really* intended to be used in production, and exists as something of a demonstration of what is possible in a QBasic-compatible language. Despite this, it is shockingly performant and retains much of the core functionality of a RESTful web application framework.

This project is built using [QB64](https://qb64.com/), a language that aims to be QBasic compatible while running on modern operating systems. It is designed to produce binaries that can be run as [CGI](https://httpd.apache.org/docs/2.4/howto/cgi.html) applications.

## Features

* Easy to use templater that streams pages in line by line to avoid running out of conventional memory
* RESTful page router with pattern matching
* A map like object implementation and a collection of useful string manipulation functions
* A small suite of unit tests, also written in QBasic!

## Limitations

As this project is written in a vintage programming language that predates a few important features now common in modern programming languages, this framework comes with a few limitations. Cheifly, the handling of POST requests is untested under Linux and currently not possible under Windows. Currently, there is no built-in way of reading data from stdin on Windows in QB64, which makes handling POST requests impossible on these operating systems without an external library.

As QB64 is a modern implementation of QBasic that runs Clang under the hood, it would be possible to circumvent some of these limitations. However, doing so would require the use of language facilities that would make the code incompatible with the original QBasic and I feel that wouldn't be within the spirit of the project.

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
See example_html.bas for a CGI example. If you want to try this example using a real web server, you will need to change `TEMPLATE_DIR` to the absolute path to the example_templates directory and copy the executable created from example_html.bas to the cgi-bin directory of your web server.

