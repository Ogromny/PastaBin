/* vibe */
import vibe.d;
import vibe.db.mongo.mongo;
import vibe.data.bson;
/* std */
import std.digest.sha;
/* extern .d */
import Encrypt;
import utils;

/* for creating password */
enum secretKey = "PastaBin";
/* for manipulate the collecitons */
MongoCollection pastabin_message;

/**
 * Create:
 * password -> Sha256 of password and secretKey
 * content  -> encrypted content with password
 * hash     -> Sha256 of content
 * Insert in BDD content and hash
 * Return template encrypt.dt
 * ------------------------------
 * @param  HTTPServerRequest  req           Request object
 * @param  HTTPServerResponse res           Response object
 * @return void
 */
void encrypt(HTTPServerRequest req, HTTPServerResponse res)
{
	string title    = req.form["paste_title"];
	string password = toHexString(sha256Of(req.form["paste_password"] ~ secretKey));
	string content  = encrypt_string(req.form["paste_content"], password);
	string hash     = toHexString(sha256Of(content));

	/* Bson(["hash": Bson(hash), "content": Bson(content)]) */
	Bson message = Bson.emptyObject;
	message["hash"]    = hash;
	message["title"]   = title;
	message["content"] = content;

	pastabin_message.insert(message);

	res.render!("encrypt.dt", req, password, hash);
}

/**
 * Create:
 * password -> Sha256 of password passed throw req and secretKey
 * hash     -> hash passed throw req
 * content  -> find content in BDD and decrypt it with password
 * Return template decrypt.dt
 * ------------------------------
 * @param  HTTPServerRequest  req           Request object
 * @param  HTTPServerResponse res           Response object
 * @return void
 */
void decrypt(HTTPServerRequest req, HTTPServerResponse res)
{
	string password = toHexString(sha256Of(req.params["password"] ~ secretKey));
	string hash     = req.params["hash"];
	
	Json paste = pastabin_message
		.findOne(["hash": hash], ["_id": 0, "hash": 0])
		.toJson();

	string title    = paste["title"].toString();
	string content  = decrypt_string(paste["content"].toString(), password);

	content = content[1 .. $-1];
	content = escape_escaped(content);

	res.render!("decrypt.dt", req, title, content);
}

shared static this()
{
	URLRouter router = new URLRouter;
	router.get("/", staticTemplate!"index.dt");
	router.post("/encrypt", &encrypt);
	router.get("/decrypt/:hash/:password/", &decrypt);
	router.get("*", serveStaticFiles("public"));

	HTTPServerSettings settings = new HTTPServerSettings;
	settings.errorPageHandler   = toDelegate((HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error) => res.render!("error.dt", req, error));
	settings.bindAddresses      = ["127.0.0.1"];
	settings.port               = 8080;

	pastabin_message = connectMongoDB("127.0.0.1").getCollection("pastabin.message");

	listenHTTP(settings, router);
}
