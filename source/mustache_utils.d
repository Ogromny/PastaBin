module mustache_utils;

public import mustache;

alias MustacheEngine!string Mustache;
alias MustacheEngine!string.Context Context;

public Mustache global_mustache;

void
initMustache (string path, string extension)
{
    global_mustache.path = path;
    global_mustache.ext  = extension;
}
