<?php
namespace pastabin\controllers\docs;

use mako\http\routing\Controller;
use mako\http\routing\URLBuilder;
use mako\view\ViewFactory;

class Documentation extends Controller {
	public function index (ViewFactory $view) {
		return $view->create('api');
	}
}
