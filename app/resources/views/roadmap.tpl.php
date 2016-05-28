{% extends:'partials.layout' %}
{% block:title %}Roadmap - __PARENT__{% endblock %}

{% block:content %}
<section>
  <div id="section">
    <div id="title">
      <h1>What we want to do for PastaBin</h1>
    </div>
    <div id="buttons">
      <a href="https://github.com/Ogromny/PastaBin/issues/new">Suggest an addition</a>
    </div>
  </div>
</section>
<main>
  <div id="main" class="page">
    <h2>PastaBin Roadmap</h2>
    <h2 id="v0-1-0-alpha"> v0.1.0 (alpha)</h2>
    <ul>
    <li><p>[x] Having a working website.
    </p>
    </li>
    </ul>
    <h2 id="v0-2-0-beta"> v0.2.0 (beta)</h2>
    <ul>
    <li>[x] Do a nice design and integrate it.
    </li>
    <li>[x] Add misc pages such as <code class="prettyprint">about</code>, <code class="prettyprint">api</code>, <code class="prettyprint">contact</code>.
    </li>
    <li>[x] Rewrite <code class="prettyprint">app.d</code> using vibe.WebInterface.
    </li>
    <li>[x] Rework the responsiveness focusing on content size, not device size.
    </li>
    </ul>
    <h2 id="v0-3-0-beta-2"> v0.3.0 (beta-2)</h2>
    <ul>
    <li>[&nbsp;&nbsp;] Public pastes (no passwords) for the average user.
    </li>
    <li>[&nbsp;&nbsp;] Add, review and hard-test encryption algorithm.  <br/>
    </li>
    <li>[&nbsp;&nbsp;] Zero-knoweldge encryption would be a must.
    </li>
    <li>[&nbsp;&nbsp;] API system:
    <ul>
    <li>[&nbsp;&nbsp;] Auth by token for doing operations that need to write the db ;
    </li>
    <li>[&nbsp;&nbsp;] Public API for getting Pastes and their meta-data.
    </li>
    </ul>
    </li>
    </ul>
    <h2 id="v0-4-0-pre-launch"> v0.4.0 (pre-launch)</h2>
    <ul>
    <li>[&nbsp;&nbsp;] Support for syntax highlighting, done server-side. No JS needed.
    </li>
    <li>[&nbsp;&nbsp;] Support for expiration date:
    <ul>
    <li>[&nbsp;&nbsp;] 10 min ;
    </li>
    <li>[&nbsp;&nbsp;] 1 day ;
    </li>
    <li>[&nbsp;&nbsp;] 1 week ;
    </li>
    <li>[&nbsp;&nbsp;] 1 month ;
    </li>
    <li>[&nbsp;&nbsp;] 6 months ;
    </li>
    <li>[&nbsp;&nbsp;] 1 year ;
    </li>
    <li>[&nbsp;&nbsp;] indefinitly.
    </li>
    </ul>
    </li>
    <li>[&nbsp;&nbsp;] Support for link shortening (ie. <code class="prettyprint">pasta.pw/id</code>).
    </li>
    </ul>
    <h2 id="v0-5-0-first-big-update"> v0.5.0 (first big update)</h2>
    <ul>
    <li>[&nbsp;&nbsp;] Member area:
    <ul>
    <li>[&nbsp;&nbsp;] Social integrations (github, google, facebook) ;
    </li>
    <li>[&nbsp;&nbsp;] Import/export pastes from/to GitHub Gist ;
    </li>
    <li>[&nbsp;&nbsp;] Display the pastes list of the authenticated user.
    </li>
    </ul>
    </li>
    <li>[&nbsp;&nbsp;] Support for paste visibility:
    <ul>
    <li>[&nbsp;&nbsp;] Public ;
    </li>
    <li>[&nbsp;&nbsp;] Secret (access allowed only via link) ;
    </li>
    <li>[&nbsp;&nbsp;] Private (no access except authorized accounts).
    </li>
    </ul>
    </li>
    <li>[&nbsp;&nbsp;] Ability to backup/restore pastes  <br/>
    <ul>
    <li>[&nbsp;&nbsp;] Defining an import/export format ;
    </li>
    <li>[&nbsp;&nbsp;] Export ;
    </li>
    <li>[&nbsp;&nbsp;] Import.
    </li>
    </ul>
    </li>
    </ul>
    <h2 id="v0-6-0-cross-compatibility"> v0.6.0 (cross-compatibility)</h2>
    <ul>
    <li>Tools to share a paste without using the website:
    <ul>
    <li>CLI Tools (terminal):
    <ul>
    <li>[&nbsp;&nbsp;] GNU/Linux ;
    </li>
    <li>[&nbsp;&nbsp;] Apple OSX ;.
    </li>
    <li>[&nbsp;&nbsp;] Windows.
    </li>
    </ul>
    </li>
    <li>GUI Tools:
    <ul>
    <li>[&nbsp;&nbsp;] GNU/Linux ;
    </li>
    <li>[&nbsp;&nbsp;] Android ;
    </li>
    <li>[&nbsp;&nbsp;] Apple OSX ;
    </li>
    <li>[&nbsp;&nbsp;] Apple iOS ;
    </li>
    <li>[&nbsp;&nbsp;] Windows ;
    </li>
    <li>[&nbsp;&nbsp;] Windows Phone.
    </li>
    </ul>
    </li>
    </ul>
    </li>
    </ul>
  </div>
</main>
{% endblock %}
