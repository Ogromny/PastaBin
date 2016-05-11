module app;

import vibe.d;

import mustache_utils;
import dcrypto_utils;
import sha_utils;
import mongo_utils;
import string_utils;

enum
{
    URL           = "pastabin.pw",
    NGINX_IS_USE  = false,
    HTML_STATUS   = "text/html;charset=UTF-8",
    PLAIN_STATUS  = "text/plain;charset=UTF-8",
}

shared static
this ()
{
    URLRouter router = new URLRouter;
    router.registerWebInterface (new WebInterface);

    if (!NGINX_IS_USE)
     {
         router.get ("*", serveStaticFiles ("./public/"));
     }

    HTTPServerSettings settings = new HTTPServerSettings;
    settings.bindAddresses      = ["127.0.0.1"];
    settings.hostName           = "pastabin.pw";
    settings.port               = 8080;
    settings.errorPageHandler   = toDelegate(&errorPageHandler);

    initMustache ("views/", "html");
    initPastabin_db_message ();

    listenHTTP (settings, router);
}

void
errorPageHandler (HTTPServerRequest request, HTTPServerResponse response, HTTPServerErrorInfo error)
{
    Context ctx = new Context;
    ctx ["page-title"]   = "Error: " ~ to!string (error.code);
    ctx ["code"]         = error.code;
    ctx ["debugMessage"] = error.debugMessage;
    ctx ["message"]      = error.message;

    string html = global_mustache.render ("error", ctx);

    response.writeBody (html, error.code, HTML_STATUS);
}

void
renderTemplate (HTTPServerResponse response, string file, Context ctx)
{
    string title;

    switch (file)
     {
         case "index"  : title = "Welcome!"; break;
         case "about"  : title = "About us"; break;
         case "api"    : title = "API"     ; break;
         case "contact": title = "Contact" ; break;
         case "roadmap": title = "Roadmap" ; break;
         default:                            break;
     }

    if (title != string.init)
     {
         ctx ["page-title"] = title;
     }

    string html = global_mustache.render (file, ctx);

    response.writeBody (html, 200, HTML_STATUS);
}

class WebInterface
{
    public:

        @method (HTTPMethod.GET) @path ("/") void
        index (HTTPServerResponse response)
        {
            renderTemplate (response, "index", new Context);
        }

        @method (HTTPMethod.GET) @path ("/about") void
        about (HTTPServerResponse response)
        {
            renderTemplate (response, "about", new Context);
        }

        @method (HTTPMethod.GET) @path ("/api") void
        api (HTTPServerResponse response)
        {
            renderTemplate (response, "api", new Context);
        }

        @method (HTTPMethod.GET) @path ("/contact") void
        contact (HTTPServerResponse response)
        {
            renderTemplate (response, "contact", new Context);
        }

        @method (HTTPMethod.GET) @path ("/roadmap") void
        roadmap (HTTPServerResponse response)
        {
            renderTemplate (response, "roadmap", new Context);
        }

        @method (HTTPMethod.POST) @path ("/encrypt") void
        encrypt (string paste_title, string paste_content, string paste_pass = string.init)
        {
            string title    = paste_title;
            string password = toHexString(toSHA256 (paste_pass ~ secret_salt));
            // string content  = dcrypto_utils.encrypt(paste_content, password, secret_salt);
            string content  = paste_content;

            Bson message        = Bson.emptyObject;
            message ["_id"]     = BsonObjectID.generate ();
            message ["title"]   = title;
            message ["content"] = content;

            add (message);

            redirect ("/p/" ~ delFirstLastChar (message["_id"].toString) ~ "/" ~ password ~ "/");
        }

        @method (HTTPMethod.GET) @path ("/p/:id/:pass/") void
        decrypt (HTTPServerResponse response, string _id, string _pass)
        {
            Json paste = findMessage (_id);

            string title   = paste ["title"].toString;
            string content = paste ["content"].toString;

            title   = title.delFirstLastChar.fixNewLineEscapedChar.fixEscapedChar;
            content = content.delFirstLastChar.fixNewLineEscapedChar.fixEscapedChar;

            Context ctx = new Context;
            ctx ["page-title"]    = "Decrypt" ~ title;
            ctx ["paste-id"]      = _id;
            ctx ["paste-title"]   = title;
            ctx ["paste-content"] = content;
            ctx ["paste-pass"]    = _pass;

            renderTemplate(response, "decrypt", ctx);
        }

        @method (HTTPMethod.GET) @path ("/raw/:id/:pass/") void
        raw (HTTPServerResponse response, string _id, string _pass)
        {
            Json paste = findMessage (_id);

            string content = paste ["content"].toString;
            content = content.delFirstLastChar.fixNewLineEscapedChar.fixEscapedChar;

            response.writeBody (content, 200, PLAIN_STATUS);
        }
}
