$SCREENHIDE
$CONSOLE
_DEST _CONSOLE


PRINT "Content-type: text/plain"
PRINT
PRINT "Unit Tests"
'$INCLUDE: 'qbonas.bi'


'dict.bm
DIM new_dict(10) AS DictElement

ret% = DictFreeIndex(new_dict())
CALL TestResult("DictFreeIndex() 1", STR$(ret%), STR$(0))

ret% = DictAppend(new_dict(), "test", "val")
CALL TestResult("DictAppend() 1", STR$(ret%), STR$(0))

ret% = DictFreeIndex(new_dict())
CALL TestResult("DictFreeIndex() 2", STR$(ret%), STR$(1))

ret% = DictAppend(new_dict(), "test2", "val2")
CALL TestResult("DictAppend() 2", STR$(ret%), STR$(0))

index& = DictIndex(new_dict(), "test")
CALL TestResult("DictIndex() 1", STR$(index&), STR$(0))

value$ = DictValue(new_dict(), "test")
CALL TestResult("DictValue() 1", value$, "val")



'string.bm

ret% = ContainsChar("test strang", "a")
CALL TestResult("ContainsChar 1", STR$(ret%), STR$(-1))

ret% = ContainsChar("test string", "a")
CALL TestResult("ContainsChar 2", STR$(ret%), STR$(0))

ret% = ContainsChar("test string", "abcd")
CALL TestResult("ContainsChar 3", STR$(ret%), STR$(0))

ret% = WildcardMatch("testing", "test*")
CALL TestResult("WildcardMatch 1", STR$(ret%), STR$(-1))

ret% = WildcardMatch("testing", "test")
CALL TestResult("WildcardMatch 2", STR$(ret%), STR$(0))

ret% = WildcardMatch("testing", "te*ng")
CALL TestResult("WildcardMatch 3", STR$(ret%), STR$(-1))

ret% = WildcardMatch("testing", "t*")
CALL TestResult("WildcardMatch 4", STR$(ret%), STR$(-1))

ret% = WildcardMatch("testing", "*ting")
CALL TestResult("WildcardMatch 5", STR$(ret%), STR$(-1))

ret% = WildcardMatch("testing", "*tinn")
CALL TestResult("WildcardMatch 6", STR$(ret%), STR$(0))

ret% = CountSubstrings("a,b,b,b", ",")
CALL TestResult("CountSubstrings 1", STR$(ret%), STR$(3))

ret% = CountSubstrings("abbb", ",")
CALL TestResult("CountSubstrings 1", STR$(ret%), STR$(0))

ret% = StringCompare("test", "test")
CALL TestResult("StringCompare 1", STR$(ret%), STR$(-1))

ret% = StringCompare("tests", "test")
CALL TestResult("StringCompare 2", STR$(ret%), STR$(0))

ret% = StringCompare("tests", "")
CALL TestResult("StringCompare 3", STR$(ret%), STR$(0))

ret% = StringCompare("t", "t")
CALL TestResult("StringCompare 4", STR$(ret%), STR$(-1))

ret% = StringStartsWith("!test string", "!")
CALL TestResult("StringStartsWith 1", STR$(ret%), STR$(-1))

ret% = StringStartsWith("!test string", "!tes")
CALL TestResult("StringStartsWith 2", STR$(ret%), STR$(-1))

ret% = StringStartsWith("!test string", "~tes")
CALL TestResult("StringStartsWith 3", STR$(ret%), STR$(0))

ret% = StringIsInteger("0121209")
CALL TestResult("StringIsInteger 1", STR$(ret%), STR$(-1))

ret% = StringIsInteger("0x121209")
CALL TestResult("StringIsInteger 2", STR$(ret%), STR$(0))

ret% = StringIsInteger("a121209")
CALL TestResult("StringIsInteger 3", STR$(ret%), STR$(0))

ret% = StringIsInteger("121209a")
CALL TestResult("StringIsInteger 4", STR$(ret%), STR$(0))

test_str$ = "<i>lol</i>"
CALL StringReplace(test_str$, ">", "")
CALL TestResult("StringReplace 1", test_str$, "<ilol</i")

test_str$ = "<i>lol</i>"
CALL StringReplace(test_str$, "<", "")
CALL TestResult("StringReplace 2", test_str$, "i>lol/i>")

test_str$ = "hhhhlol"
CALL HTMLEscape(test_str$)
CALL TestResult("HTMLEscape 1", test_str$, "hhhhlol")

test_str$ = "<i>lol"
CALL HTMLEscape(test_str$)
CALL TestResult("HTMLEscape 2", test_str$, "&lt;i&gt;lol")


'encoding.bm

encoded$ = URLEncodeChars("!\;[")
CALL TestResult("URLEncodeChars 1", encoded$, "%21%5C%3B%5B")

encoded$ = URLEncodeChars("!")
CALL TestResult("URLEncodeChars 2", encoded$, "%21")

encoded$ = URLEncodeString("http://example.com")
CALL TestResult("URLEncodeString 1", encoded$, "http%3A%2F%2Fexample.com")

ret% = CountSubstrings("test strang", "t")
CALL TestResult("CountSubstrings 1", STR$(ret%), STR$(3))

ret% = CountSubstrings("test strang", "o")
CALL TestResult("CountSubstrings 2", STR$(ret%), STR$(0))

ret% = CountSubstrings("", "o")
CALL TestResult("CountSubstrings 3", STR$(ret%), STR$(0))

encoded$ = URLDecodeString("http%3A%2F%2Fexample.com")
CALL TestResult("URLDecodeString 1", encoded$, "http://example.com")


'environ.bm

DIM query_dict(15) AS DictElement

qd_meta.maxsize = UBOUND(query_dict)

key$ = ""
val$ = ""
CALL ParseKVPair("key&val", key$, val$, "&")
CALL TestResult("ParseKVPair 1 key", key$, "key")
CALL TestResult("ParseKVPair 1 val", val$, "val")

key$ = ""
val$ = ""
CALL ParseKVPair("&val", key$, val$, "&")
CALL TestResult("ParseKVPair 2 key", key$, "")
CALL TestResult("ParseKVPair 2 val", val$, "val")

key$ = ""
val$ = ""
CALL ParseKVPair("key", key$, val$, "&")
CALL TestResult("ParseKVPair 3 key", key$, "key")
CALL TestResult("ParseKVPair 3 val", val$, "")

count% = ParseQueryString("key1=vasl1&key2=val2&key3", query_dict())


PRINT DATE()
PRINT ENVIRON$("CONTENT_LENGTH")
PRINT ENVIRON$("QUERY_STRING")

count% = ParseQueryString(ENVIRON$("QUERY_STRING"), cgi_query_dict())



FOR i = LBOUND(cgi_query_dict) TO UBOUND(cgi_query_dict)
    PRINT cgi_query_dict(i).k + ": " + cgi_query_dict(i).v
NEXT

'CALL GetCGIEnvironment(cgi_environ_dict())
'PRINT DictValue(cgi_environ_dict(), "GATEWAY_INTERFACE")
'PRINT ENVIRON$("REMOTE_ADDR")
'PRINT ENVIRON$("CONTENT_LENGTH")
RESTORE lbl_cgi_environ_length
READ cgi_var_length%
RESTORE lbl_cgi_environ
DIM var_name AS STRING
FOR i = 0 TO cgi_var_length% - 1
    READ var_name
    PRINT var_name + ": ";
    PRINT ENVIRON$(var_name + CHR$(0))
NEXT

'$INCLUDE: 'qbonas.dt'

SUB TestResult (name$, outp$, expected$)
    IF outp$ = expected$ THEN
        PRINT "+Test: " + name$ + " PASS"
    ELSE
        PRINT "-Test: " + name$ + " FAIL"
        PRINT "-Output: " + outp$
        PRINT "-Expected: " + expected$
    END IF
END SUB


'$INCLUDE: 'qbonas.bm'

