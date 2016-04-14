import vibe.d;
import vibe.db.mongo.mongo;
import std.digest.sha;
import Encrypt;
import Message;

enum secretKey = "PastaBin";

void errorPage(HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error)
{
	res.render!("error.dt", req, error);
}

void encrypt(HTTPServerRequest req, HTTPServerResponse res)
{
	Message message;

	string password = toHexString(sha256Of(req.form["message_password"] ~ secretKey));
	message.content(encrypt_string(req.form["message_content"], password));
	message.hash(toHexString(sha256Of(message.content())));

	MongoCollection pastabin_message = connectMongoDB("127.0.0.1").getCollection("pastabin.message");
	pastabin_message.insert(message.toBson());

	/*debug*/ std.stdio.writefln("DEBUG: encrypt() -> content => %s", message.content);

	res.render!("encrypt.dt", req, password, message);
}

void decrypt(HTTPServerRequest req, HTTPServerResponse res)
{
	Message message;

	string password = toHexString(sha256Of(req.params["password"] ~ secretKey));
	message.hash(req.params["hash"]);

	MongoCollection pastabin_message = connectMongoDB("127.0.0.1").getCollection("pastabin.message");
	auto content = pastabin_message.findOne(["hash": message.hash()], ["_id": 0, "hash": 0]).toJson();

	auto content_a = content["content"].toString();
	/*debug*/ std.stdio.writeln(content_a);

	message.content(decrypt_string(content_a, password));

	res.writeBody(req.params["hash"] ~ " :: " ~ req.params["password"] ~ "::" ~ message.content());
}

shared static this()
{
	URLRouter router = new URLRouter;
	router.get("/", staticTemplate!"index.dt");
	router.post("/encrypt", &encrypt);
	router.get("/decrypt/:hash/:password/", &decrypt);
	router.get("*", serveStaticFiles("public"));

	HTTPServerSettings settings = new HTTPServerSettings;
	settings.errorPageHandler = toDelegate(&errorPage);
	settings.bindAddresses = ["127.0.0.1"];
	settings.port = 8080;

	listenHTTP(settings, router);
}
