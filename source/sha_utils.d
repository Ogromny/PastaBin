module sha_utils;

private import std.digest.sha;

public string secret_salt = "od(!^L2CXd$^Bj2N#is#yZ5TM3UssJ7q";

auto // ubyte[32] || ubyte[64]
toSHA256 (string content)
{
    return sha256Of (content);
}
