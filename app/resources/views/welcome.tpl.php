{% extends:'partials.layout' %}
{% block:title %}Welcome - __PARENT__{% endblock %}

{% block:content %}
<form class="encrypt" method="post" action="/encrypt">
  <section>
    <div id="section">
      <div id="inputs">
        <input tabindex="1" type="text" name="paste_title" placeholder="Title of the paste...">
        <input tabindex="2" type="password" name="paste_pass" placeholder="Password...">
      </div>
      <div id="buttons">
        <button tabindex="3" type="submit">Paste!</button>
      </div>
    </div>
  </section>
  <main>
    <div id="main">
      <textarea autofocus="autofocus" tabindex="0" id="paste-content" name="paste_content" placeholder="Write an awesome paste here..."></textarea>
    </div>
  </main>
</form>
{% endblock %}
