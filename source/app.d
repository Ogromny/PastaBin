module app;

import vibe.d;

import mustache_utils;
import dcrypto_utils;
import sha_utils;
import mongo_utils;

enum
{
    NGINX_IS_USE = false,
    HTML_STATUS  = "text/html;charset=UTF-8",
    URL          = "pastabin.pw",
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

    final switch (file)
     {
         case "index"  : title = "Welcome!"; break;
         case "about"  : title = "About us"; break;
         case "api"    : title = "API"     ; break;
         case "contact": title = "Contact" ; break;
         case "roadmap": title = "Roadmap" ; break;
         case "decrypt":                   ; break;
     }

    ctx ["page-title"] = title;

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
            // string password = toSHA256 (paste_pass ~ secret_salt);
            string password = toHexString (sha256Of (paste_pass ~ secret_salt));
            string content  = dcrypto_utils.encrypt(paste_content, password, secret_salt);

            Bson message        = Bson.emptyObject;
            message ["_id"]     = BsonObjectID.generate ();
            message ["title"]   = title;
            message ["content"] = content;

            add (message);

            redirect (URL ~ "/p/" ~ message.toString ~ "/" ~ password ~ "/");
        }

        @method (HTTPMethod.GET) @path ("/p/:id/:pass/") void
        decrypt (HTTPServerResponse response, string _id, string _pass)
        {
            Json paste = findMessage (_id);

            string title = paste ["title"].toString;
            string password = _pass;
            string content = dcrypto_utils.decrypt (paste ["content"].toString, password, secret_salt);

            /* fix bug escaped char */

            Context ctx = new Context;
            ctx ["paste-title"]   = "Decrypt" ~ _id;
            ctx ["paste-id"]      = _id;
            ctx ["paste-pass"]    = _pass;
            ctx ["paste-content"] = content;

            renderTemplate(response, "decrypt", ctx);
        }
}
