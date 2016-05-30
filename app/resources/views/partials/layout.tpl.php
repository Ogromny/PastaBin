<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="author" content="Ogromny <ogromny@openmailbox.org>">
	<meta name="author" content="SkyzohKey <skyzohkey@protonmail.com>">
	<meta name="designer" content="SkyzohKey <skyzohkey@protonmail.com>">
	<meta name="github" content="https://github.com/Ogromny/PastaBin">
	<meta name="status-page" content="https://status.pastabin.pw">
	<meta name="subject" content="PastaBin is a free text sharing website. It's main goal is to defeat Pastebin.com">
	<meta name="description" content="PastaBin aims to be a secure, modern and fully-featured Pastebin replacement. We designed it to be secure, simple and elegant.">
	<meta name="classification" content="Introducing PastaBin, an encrypted way to share. PastaBin aims to be an encrypted, modern and fully-featured Pastebin replacement. It has been designed with the following things in mind: Encryption, Simplicity and Elegant. PastaBin is free software. That's free as in freedom, as well as in price. This means PastaBin is yours — to use, modify, and share — because PastaBin is developed by and for the users.">
	<meta name="keywords" content="pastabin, paste, text, share, free, open-source, pastebin">
	<meta name="language" content="English">
	<meta name="publisher" content="Blackstorm Prod.">
	<meta name="distribution" content="Global">
	<meta name="robots" content="INDEX,FOLLOW">

    <title>{{block:title}}PastaBin{{endblock}}</title>

    <link rel="stylesheet" href="/assets/css/pastabin.css">
    <!--<link rel="stylesheet" href="https://cdn.pastabin.pw/styles/style.min.css">-->
  </head>
  <body>
    <div id="wrapper">
      <header>
        <div id="header">
          <a id="logo" href="/">PastaBin</a>
          <nav id="menu">
            <ul>
              <li><a href="/about">About</a></li>
              <li><a href="/api">API</a></li>
              <li><a href="/contact">Contact</a></li>
            </ul>
          </nav>
        </div>
      </header>
	  {{block:content}}{{endblock}}

	  <footer>
		<div id="footer">
		  <div id="copyright">
			&copy; PastaBin 2016 - All rights reserved.
		  </div>
		  <nav id="links">
			<ul>
			  <li>Page rendered in {{ round(microtime(true) - MAKO_START, 4) }} seconds</li>
			  <li><a href="/roadmap">Roadmap</a></li>
			  <li><a href="https://github.com/Ogromny/PastaBin/">GitHub</a></li>
			  <li><a href="/contact">Contact</a></li>
          </ul>
		  </nav>
		</div>
	  </footer>
	</div>
  </body>
</html>
