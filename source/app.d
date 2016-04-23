module app;

/* std */
import std.regex;
import std.digest.sha;
import std.stdio;

/* vibe */
import vibe.d;
import vibe.db.mongo.mongo;
import vibe.data.bson;
import vibe.templ.parsertools;
import vibe.http.router;
import vibe.http.server;
import vibe.web.web;

/* dcrypto */
import dcrypto.evp;

/* Mustache template engine */
import mustache;
alias MustacheEngine!(string) Mustache;

enum secretKey = "od(!^L2CXd$^Bj2N#is#yZ5TM3UssJ7q";
MongoCollection pastabin_message;
string base_uri = "https://pastabin.pw";

class WebInterface {
	private {
		// Here we can store session vars.
	}

	private void renderTemplate(HTTPServerResponse res, string file, Mustache.Context ctx) {
		Mustache mustache;
		mustache.path = "views/";
		mustache.ext  = "html";

		auto html = mustache.render(file, ctx);
		res.writeBody(html, 200, "text/html;charset=UTF-8");
	}

	@method(HTTPMethod.GET) @path("/")
	void index(HTTPServerResponse res) {
		auto ctx = new Mustache.Context;
		ctx["page-title"] = "Welcome!";
		renderTemplate(res, "index", ctx);
	}

	@method(HTTPMethod.GET) @path("/about")
	void about(HTTPServerResponse res) {
		auto ctx = new Mustache.Context;
		ctx["page-title"] = "About us";
		renderTemplate(res, "about", ctx);
	}

	@method(HTTPMethod.GET) @path("/api")
	void api(HTTPServerResponse res) {
		auto ctx = new Mustache.Context;
		ctx["page-title"] = "API";
		renderTemplate(res, "api", ctx);
	}

	@method(HTTPMethod.GET) @path("/contact")
	void contact(HTTPServerResponse res) {
		auto ctx = new Mustache.Context;
		ctx["page-title"] = "Contact us";
		renderTemplate(res, "contact", ctx);
	}

	@method(HTTPMethod.GET) @path("/roadmap")
	void roadmap(HTTPServerResponse res) {
		auto ctx = new Mustache.Context;
		ctx["page-title"] = "Roadmap";
		renderTemplate(res, "roadmap", ctx);
	}

	@method(HTTPMethod.POST) @path("/encrypt")
	void postEncrypt(string paste_title, string paste_content, string paste_pass = "")
	{
		/* init var */
		string title    = paste_title;
		string password = toHexString(sha256Of(paste_pass ~ secretKey));
		string content  = paste_content;

		/* Encrypt AES 256 */
		auto key = keyFromSecret(password, secretKey);
		EVPEncryptor encryptor = new EVPEncryptor(key);
		content = encryptor.encrypt(content);

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
	void decrypt(HTTPServerResponse res, string _id, string _pass)
	{
		Json paste  = pastabin_message.findOne(["_id": BsonObjectID.fromString(_id)]).toJson();

		/* init var */
		string title   = paste["title"].toString();
		string content = paste["content"].toString();
		string password = _pass;

		/* Decrypt AES 256 */
		auto key = keyFromSecret(password, secretSalt);
		EVPDecryptor decryptor = new EVPDecryptor(key);
		content = decryptor.decrypt(content);

		/**
		* HACK: Fix escaped char.
		* TODO: Find a better way to do this.
		**/
		import std.ascii; // newline
		title   = title[1 .. $-1]; // rm "..."
		content = content[1 .. $-1]; // rm "..."
		content = content.replaceAll(r"\\r\\n".regex, newline); // mv \r\n newline
		content = content.replaceAll(r"\\t".regex, "\t"); // unescape escaped char

		auto ctx = new Mustache.Context;
		ctx["page-title"] = "Decrypt « " ~ title ~ " »";
		ctx["paste-title"] = title;
		ctx["paste-content"] = content;

		renderTemplate(res, "decrypt", ctx);
		//render!("decrypt.dt", title, content, useScroll);
	}
}

shared static this()
{
	pastabin_message = connectMongoDB("127.0.0.1").getCollection("pastabin.message");

	auto router = new URLRouter;
	router.registerWebInterface(new WebInterface);
	/**
	* Uncomment the following line in local.
	* In production assets are stored at https://cdn.pastabin.pw/(styles|images)
	**/
	//router.get("*", serveStaticFiles("public"));

	auto settings             = new HTTPServerSettings;
	settings.sessionStore     = new MemorySessionStore;
	settings.errorPageHandler = toDelegate(&errorHandler);
	settings.bindAddresses    = ["::1", "127.0.0.1", "pastabin.pw"];
	settings.port             = 8080;
	listenHTTP(settings, router);
}

void errorHandler (HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error) {
	Mustache mustache;
	mustache.path = "views/";
	mustache.ext  = "html";

	auto ctx = new Mustache.Context;
	ctx["page-title"] = to!string(error.code) ~ ": " ~ error.message;
	ctx["code"] = error.code;
	ctx["debugMessage"] = error.debugMessage;
	ctx["message"] = error.message;

	auto html = mustache.render("error", ctx);
	res.writeBody(html, error.code, "text/html;charset=UTF-8");
}
