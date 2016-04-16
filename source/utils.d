module utils;

private import std.regex;

string escape_escaped(in string input)
{
    return replaceAll(input, r"\\r\\n".regex, "\r\n").replaceAll(r"\\(.)".regex, "$1");
}
