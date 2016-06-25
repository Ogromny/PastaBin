<?php
namespace pastabin\controllers\paste;

use mako\http\routing\Controller;
use mako\http\routing\URLBuilder;
use mako\view\ViewFactory;

class Paste extends Controller {
	public function new (ViewFactory $view) {}
	public function post_new (ViewFactory $view) {
		$title     = $this->request->post('paste_title', false);
		$password  = $this->request->post('paste_pass', false);
		$content   = $this->request->post('paste_content', false);
	}

	public function display (ViewFactory $view) {}
	public function raw (ViewFactory $view) {}
	public function edit (ViewFactory $view) {}
	public function delete (ViewFactory $view) {}
}
