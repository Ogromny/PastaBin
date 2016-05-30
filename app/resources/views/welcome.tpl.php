{% extends:'partials.layout' %}
{% block:title %}Welcome - __PARENT__{% endblock %}

{% block:content %}
  <section>
    <div id="section">
      <div id="inputs">
        <input tabindex="1" type="text" id="paste-title" name="paste_title" placeholder="Title of the paste...">
        <input tabindex="2" type="password" id="paste-pass" name="paste_pass" placeholder="Password...">
      </div>
      <div id="buttons">
        <button tabindex="3" type="submit" onclick="submit_encrypt();">Paste!</button>
      </div>
    </div>
  </section>
  <main>
    <div id="main">
      <textarea autofocus="autofocus" tabindex="0" id="paste-content" name="paste_content" placeholder="Write an awesome paste here..."></textarea>
    </div>
  </main>
  <script src="https://raw.githubusercontent.com/mdp/gibberish-aes/master/src/gibberish-aes.js"></script>
  <script src="https://raw.githubusercontent.com/Caligatio/jsSHA/master/src/sha256.js"></script>
  <script type="text/javascript">
    var salt = "a8860739a4ec5051b657000990424038744daacee4f93080891cef6bf7ce6735";

    function submit_encrypt() {
      var title = document.getElementById('paste-title').value;
      var password = Sha256Of(document.getElementById('paste-pass').value + salt);
      var content = GibberishAES.enc(document.getElementById('paste-content').value, password);

      post('/encrypt', {paste_title: title, paste_pass: password, paste_content: content});
    }

    /* RPZ DLANG */
    function Sha256Of(texte) {
      var shaObj = new jsSHA("SHA-256", "TEXT");
      shaObj.update(texte);
      return shaObj.getHash("HEX");
    }

    function post(path, params) {
      var form = document.createElement("form");
      form.setAttribute("method", "post");
      form.setAttribute("action", "/encrypt");

      for(var key in params) {
        if(params.hasOwnProperty(key)) {
          var hiddenField = document.createElement("input");
          hiddenField.setAttribute("type", "hidden");
          hiddenField.setAttribute("name", key);
          hiddenField.setAttribute("value", params[key]);

          form.appendChild(hiddenField);
        }
      }

      document.body.appendChild(form);
      form.submit();
    }
  </script>
{% endblock %}
