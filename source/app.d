module app;

/* std */
import std.digest.sha;

/* vibe */
import vibe.d;
import vibe.db.mongo.mongo;
import vibe.data.bson;
import vibe.templ.parsertools;
import vibe.http.router;
import vibe.http.server;
import vibe.web.web;

/* external .d's */
import Encrypt;
import utils;

enum secretKey = "PastaBin";
MongoCollection pastabin_message;

class WebInterface {
	private {
		// Here we can store session vars.
	}

	@path("/")
	void index() {
		render!("index.dt");
	}

	@path("/about")
	void about() {
		render!("about.dt");
	}

	@path("/api")
	void api() {
		render!("api.dt");
	}

	@path("/contact")
	void contact() {
		render!("contact.dt");
	}

	// POST /encrypt
	@method(HTTPMethod.POST) @path("/encrypt")
	void postEncrypt(string paste_title, string paste_password, string paste_content)
	{
		string title    = paste_title;
		string password = toHexString(sha256Of(paste_password ~ secretKey));
		string content  = encrypt_string(paste_content, password);

		auto sha1   = new SHA1Digest();
		string hash = toLower(toHexString(sha1.digest(content ~ secretKey ~ password)));
		hash = hash[1 .. 8];

		/* Bson(["hash": Bson(hash), "content": Bson(content)]) */
		Bson message = Bson.emptyObject;
		message["hash"]    = hash;
		message["title"]   = title;
		message["content"] = content;

		pastabin_message.insert(message);

		//render!("encrypt.dt", password, hash);
		redirect("/" ~ hash);
	}

	@method(HTTPMethod.GET) @path("/:hash")
	void decrypt(string _hash)
	{
		string pass = "";
		Json paste = pastabin_message
			.findOne(["hash": _hash], ["_id": 0, "hash": 0])
			.toJson();

		string title   = escape_escaped(paste["title"].toString());
		string content = decrypt_string(paste["content"].toString(), pass);

		title   = sanitizeEscaping(title[1 .. $-1]);
		content = sanitizeEscaping(content[1 .. $-1]);
		//content = escape_escaped(content);

		render!("decrypt.dt", title, content);
	}
}

shared static this()
{
	pastabin_message = connectMongoDB("127.0.0.1").getCollection("pastabin.message");

	auto router = new URLRouter;
	router.registerWebInterface(new WebInterface);
	router.get("*", serveStaticFiles("public"));

	auto settings             = new HTTPServerSettings;
	settings.sessionStore     = new MemorySessionStore;
	settings.errorPageHandler = toDelegate(&errorHandler);
	settings.bindAddresses    = ["::1", "127.0.0.1"];
	settings.port             = 8080;
	listenHTTP(settings, router);
}

void errorHandler (HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error) {
	res.render!("error.dt", req, error);
}
