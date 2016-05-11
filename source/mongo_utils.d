module mongo_utils;

private import vibe.db.mongo.mongo;

private MongoCollection pastabin_db_message;

void
initPastabin_db_message ()
{
    pastabin_db_message = connectMongoDB ("127.0.0.1").
                          getCollection ("pastabin.pastabin_message");
}

void
add (Bson content)
{
    pastabin_db_message.insert (content);
}

Json
findMessage (string id)
{
    return pastabin_db_message.findOne (["_id": BsonObjectID.fromString (id)]).toJson;
}
