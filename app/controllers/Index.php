<?php
namespace app\controllers;

use mako\http\routing\Controller;
use mako\http\routing\URLBuilder;
use mako\view\ViewFactory;

class Index extends Controller {
	public function welcome(ViewFactory $view) {
		return $view->create('welcome');
	}

	public function about(ViewFactory $view) {
		return $view->create('about');
	}

	public function api(ViewFactory $view) {
		return $view->create('api');
	}

	public function contact(ViewFactory $view) {
		return $view->create('contact');
	}

	public function roadmap(ViewFactory $view) {
		return $view->create('roadmap');
	}
}
