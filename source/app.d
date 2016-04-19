module app;

/* std */
import std.regex;
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
import encrypt;
import utils;

enum secretKey = "PastaBin";
MongoCollection pastabin_message;
string base_uri = "https://pastabin.pw";

class WebInterface {
	private {
		// Here we can store session vars.
	}

	@method(HTTPMethod.GET) @path("/")
	void index() {
		bool useScroll = false;
		render!("index.dt", useScroll);
	}

	@method(HTTPMethod.GET) @path("/about")
	void about() {
		bool useScroll = true;
		render!("about.dt", useScroll);
	}

	@method(HTTPMethod.GET) @path("/api")
	void api() {
		bool useScroll = true;
		render!("api.dt", useScroll);
	}

	@method(HTTPMethod.GET) @path("/contact")
	void contact() {
		bool useScroll = true;
		render!("contact.dt", useScroll);
	}

	@method(HTTPMethod.POST) @path("/encrypt")
	void postEncrypt(string paste_title, string paste_content, string paste_password = "")
	{
		string title    = paste_title;
		string password = toHexString(sha256Of(paste_password ~ secretKey));
		string content  = encrypt_string(paste_content, password);

		/* BSON message */
		Bson message = Bson.emptyObject;
		message["_id"]     = BsonObjectID.generate();
		message["title"]   = title;
		message["content"] = content;

		pastabin_message.insert(message);

		string id = message["_id"].toString();
		id        = id[1 .. $-1]; /* supprime les "" */

		redirect(base_uri ~ "/p/" ~ id ~ "/" ~ password ~ "/");
	}

	@method(HTTPMethod.GET) @path("/p/:id/:pass/")
	void decrypt(string _id, string _pass)
	{
		Json paste  = pastabin_message.findOne(["_id": BsonObjectID.fromString(_id)]).toJson();

		string title   = paste["title"].toString();
		string content = decrypt_string(paste["content"].toString(), _pass);

		title   = title[1 .. $-1];
		content = content[1 .. $-1];
		content = content.replaceAll(r"\\r\\n".regex, std.ascii.newline);
		content = content.replaceAll(r"\\(.)".regex, "$1");

		bool useScroll = false;
		render!("decrypt.dt", title, content, useScroll);
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
	settings.bindAddresses    = ["::1", "127.0.0.1", "pastabin.pw"];
	settings.port             = 8080;
	listenHTTP(settings, router);
}

void errorHandler (HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error) {
	bool useScroll = true;
	res.render!("error.dt", req, error, useScroll);
}
