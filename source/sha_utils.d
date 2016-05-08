module sha_utils;

private import std.digest.sha;

public string secret_salt = "od(!^L2CXd$^Bj2N#is#yZ5TM3UssJ7q";

string
toSHA256 (string content)
{
    string sha_256 = toHexString (sha256Of (content));

    return sha_256;
}
