module string_utils;

private import std.string;
private import std.regex;
private import std.ascii;

string
delFirstLastChar (string str)
{
    return str[1 .. $-1];
}

string
fixEscapedChar (string str)
{
    return str.replaceAll (r"\\(.)".regex, "$1");
}

string
fixNewLineEscapedChar (string str)
{
    return str.replaceAll (r"\\r\\n".regex, newline);
}
