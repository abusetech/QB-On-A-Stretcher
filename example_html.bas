'The following two lines tell QB64 to output to STDOUT
$SCREENHIDE
$CONSOLE
_DEST _CONSOLE

'Include the following line BEFORE the main program code.
'This file sets up several important variables
'$INCLUDE: 'qbonas.bi'

'Set up a dictionary to hold values that will be inserted into the page
DIM page_variables(3) AS DictElement
'Return value for dictionary insertion. Not checked in this example.
DIM dict_ret AS INTEGER

'This directory holds the html templates variables are inserted into
'the syntax is jinja-like and takes the form {{variable_name}}
'text inserted into the page is escaped by default. If you need to insert
'HTML into the page, you can use the form {{~variable_name}} which will
'skip special character replacement.
CONST TEMPLATE_DIR = "./example_templates/"


'Get the page title from query string, ie <url>/?title=page%20title
dict_ret = DictAppend(page_variables(), "title", DictValue(cgi_query_dict(), "title"))
dict_ret = DictAppend(page_variables(), "text", "Test")

'CGIRoute() matches directories using wildcards (*)
'Path information from the server is taken from the PATH_INFO
'environment variable
'It also automatically deals with trailing slashes
IF CGIRoute("/1*") THEN
    'Set the content type
    CALL SetDefaultHeaders
    'Send the headers
    CALL SendHeaders
    'Render the template and insert our variables into it
    CALL RenderTemplateInline(TEMPLATE_DIR + "test_template.html", page_variables())
ELSE
    'It is a good idea to have a default in case the path doesn't match any routes.
    'In this case, you would probably want to set the Status header to 404
    'CALL SetHeader("Status","404")
    CALL SetDefaultHeaders
    CALL SendHeaders
    CALL RenderTemplateInline(TEMPLATE_DIR + "test_template2.html", page_variables())
END IF

SYSTEM 0
'$INCLUDE: 'qbonas.dt'
'$INCLUDE: 'qbonas.bm'
