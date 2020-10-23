CONST cgi_header_max_length = 20
CONST METHOD_GET = 1
CONST METHOD_POST = 2
CONST METHOD_PUT = 3
CONST METHOD_PATCH = 4
CONST METHOD_DELETE = 5

DIM cgi_request_method AS INTEGER
DIM cgi_content_length AS LONG
DIM cgi_postdata AS STRING
DIM cgi_query_dict_length AS INTEGER

'Dictionary to hold the query string, this is poplated by calling ParseQueryString
DIM cgi_query_dict(CountSubstrings(ENVIRON$("QUERY_STRING"), "&")) AS DictElement
'Response headers dictionary
DIM SHARED response_header_dict(cgi_header_max_length) AS DictElement

'Read in any POSTDATA
'TODO: VAL has several different formats. Make sure this is 100% numeric.
'TODO: This should probably be limited to 32k
cgi_content_length = VAL(ENVIRON$("CONTENT_LENGTH"))
IF cgi_content_length > 0 AND StringIsInteger(ENVIRON$("CONTENT_LENGTH")) THEN
    cgi_postdata = GetStdin(cgi_content_length)
END IF

cgi_query_dict_length = ParseQueryString(ENVIRON$("QUERY_STRING"), cgi_query_dict())

'TODO: Request method
