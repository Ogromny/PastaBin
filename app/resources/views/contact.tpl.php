{% extends:'partials.layout' %}
{% block:title %}Contact us - __PARENT__{% endblock %}

{% block:content %}
<section>
  <div id="section">
    <div id="title">
      <h1>Contact us</h1>
    </div>
    <div id="buttons">
      <a href="mailto:contact@pastabin.pw">via Mail</a>
      <a href="https://github.com/Ogromny/PastaBin/issues">via GitHub</a>
    </div>
  </div>
</section>
<main>
  <div id="main" class="page">
    <h2>Get in touch with us</h2>
	<p class="br"><b>Note</b>: We're using Tox as our main chat software. You can learn more about Tox by <a href="https://tox.chat">clicking here</a>.</p>
	<p>You can report us bugs, abuse, or anything else using our mail address or via our respective ToxIDs. The ToxID listed ontop is the one of the developer that's online pretty much everytime, but you can also contact the others developers without any fear.</p>
	<h3 class="text-centered">PastaBin Developers</h3>
	<div id="staff-wrapper">
		<row id="staff">
			<column cols="4">
				<div>
					<img src="https://avatars1.githubusercontent.com/u/10464831?v=3&amp;s=48" width="48" height="48" class="left"/>
					<div class="right">
						<h2 class="name"><a href="https://github.com/Ogromny">Ogromny</a></h2>
						<p class="bio">PastaBin is gonna defeat Pastebin.</p>
					</div>
				</div>
				<a href="tox:10EC72CA34FB138A6246B48DA8A616D008400F95D61201EB3DD70502601C682098CA00A65543" class="tox">Contact Ogromny using Tox</a>
			</column>
			<column cols="4">
				<div>
					<img src="https://avatars3.githubusercontent.com/u/8523159?v=3&amp;s=48" width="48" height="48" class="left"/>
					<div class="right">
						<h2 class="name"><a href="https://github.com/SkyzohKey">SkyzohKey</a></h2>
						<p class="bio">Doing some black magic to get beautiful things.</p>
					</div>
				</div>
				<a href="tox:DFB4958A86122ACF81BB852DBC767DB8A3A7281A8EDBC83121B30C294E29586970B731949415" class="tox">Contact SkyzohKey using Tox</a>
			</column>
		</row>
	</div>
	<hr/>
	<row>
		<column cols="2">
			<figure>
				<a href="https://github.com/Ogromny/PastaBin/issues">
					<img src="/assets/images/Octocat-hero.png" width="150" height="150" alt="Report an issue an become a super-hero!"/>
				</a>
				<figcaption>Report an issue an become a super-hero!</figcaption>
			</figure>
		</column>
		<column cols="10">
			<h2>Report an issue</h2>
			<p>If you think you have found an issue and you have 30 seconds to report it to us, you're a super-hero! In order to report a bug, simply go to our <a href="https://github.com/Ogromny/PastaBin/issues">issue tracker</a>. You can <b>create a new issue</b> or comment on an issue already opened.</p>
			<h3>Rules when reporting an issue</h3>
			<ul>
				<li>Be adventurous. Check if a similar issue already have been reported before creating yours.</li>
				<li>Be polite. Politeness is always appreciated, rude peoples are most of the time ignored.</li>
				<li>Be patient. Once you're issue is reported, we have to find what is causing it, fixing it, testing the fix and push.</li>
			</ul>
		</column>
	</row>
  </div>
</main>
{% endblock %}
