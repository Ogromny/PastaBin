module dcrypto_utils;

private import dcrypto.evp;

string
encrypt (string content, string password, string salt)
{
    auto key = keyFromSecret (password, salt);
    EVPEncryptor encryptor = new EVPEncryptor (key);

    return encryptor.encrypt (content);
}

string
decrypt (string content, string password, string salt)
{
    auto key = keyFromSecret (password, salt);
    EVPDecryptor decryptor = new EVPDecryptor (key);

    return decryptor.decrypt(content);
}
