import vibe.d;
import std.digest.md;
import vibe.data.bson;
import vibe.db.mongo.mongo;
import std.conv;

struct Message {
	string hash;
	string title;
	string content;
	string password;

	Bson toBson() {
		return Bson (
				["hash": Bson(this.hash),
				 "title": Bson(this.title),
				 "content": Bson(this.content),
				 "password": Bson(this.password)]
			);
	}
}

void errorPage(HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error)
{
	res.render!("error.dt", req, error);
}

void encrypt(HTTPServerRequest req, HTTPServerResponse res)
{
	Message message;
	message.hash     = toHexString(md5Of(req.form["message_title"] ~ req.form["message_content"] ~ req.form["message_password"]));
	message.title    = req.form["message_title"];
	message.content  = req.form["message_content"];
	message.password = req.form["message_password"];

	MongoCollection pastabin_message = connectMongoDB("127.0.0.1").getCollection("pastabin.message");

	// uniquifie le hash
	message.hash = toHexString(md5Of(message.hash ~ to!string(pastabin_message.count(""))));

	pastabin_message.insert(message.toBson());

	res.render!("encrypt.dt", req, message);
}

void decrypt(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody(req.params["hash"] ~ " :: " ~ req.params["password"]);
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
