module Message;

private import vibe.data.bson;

struct Message {
    string _hash;
    string _content;

    // @disabled this() {
    //     _hash = string.init;
    //     _content = string.init;
    // }

    string hash() const @safe @property {
        return _hash;
    }

    void hash(string new_hash) @safe @property {
        _hash = new_hash;
    }

    string content() const @safe @property {
        return _content;
    }

    void content(string new_content) @safe @property {
        _content = new_content;
    }

    Bson toBson() const @trusted {
        return Bson(["hash": Bson(hash()), "content": Bson(content())]);
    }
}
