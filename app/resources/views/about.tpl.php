{% extends:'partials.layout' %}
{% block:title %}About __PARENT__{% endblock %}

{% block:content %}
<section>
  <div id="section">
    <div id="title">
      <h1>About PastaBin</h1>
    </div>
    <div id="buttons">
      <a href="https://github.com/Ogromny/PastaBin">GitHub</a>
    </div>
  </div>
</section>
<main>
  <row id="main" class="page">
    <column cols="2">
      <figure>
        <a href="https://github.com/Ogromny/PastaBin">
  			  <img src="/assets/images/Octocat.png" width="150" height="150" alt="We strongly believe in the power of Open-Source!"/>
  			</a>
  			<figcaption>We strongly believe in the power of Open-Source!</figcaption>
  		</figure>
    </column>
    <column>
      <row>
    		<column cols="6">
          <h2>Introducing PastaBin</h2>
          PastaBin aims to be an encrypted, modern and fully-featured Pastebin replacement.<br>It has been designed with the following things in mind: Encryption, Simplicity and Elegancy.
        </column>
    		<column cols="6">
          <h2>Free software</h2>
          PastaBin is free software. That's <a href="https://www.gnu.org/philosophy/free-sw.html">free as in freedom</a>, as well as in price. This means PastaBin is yours — to use, modify, and share — because PastaBin is developed by and for the users.
        </column>
      </row>
  		<hr/>
  		<h2>How does it works?</h2>
  		<p>When you send a paste, PastaBin encrypts it using the password you have given. Then it store the paste id and <strong>encrypted</strong> text of your paste. Their is no password stored in database. When you try to decrypt a paste, PastaBin will check if it's able to decrypt it and return you the decrypted text or an error message it wasn't able to decrypt with the specified password.</p>
  		<p>We could have called this process encryption-over-the-fly, but it would sound too <strong>amazing</strong>.</p>
  		<hr/>
  		<h2>Technologies behind PastaBin</h2>
  		<p>We didn't want to make another PasteBin PHP clone, so we decided to write it in <a href="https://dlang.org">D</a>. The reason for choosing <strong>D</strong> to code this webapp is that it's a nice programming language, running pretty fast, handling MongoDB very well, permiting us to do rapid prototypes and because that's a cool language!</p>
  		<p>Of course, we don't only use D but also ; MongoDB for encrypted data storage, Vibe.D as a webserver and OpenSSL for doing encryption things!</p>
    </column>
  </row>
</main>
{% endblock %}
