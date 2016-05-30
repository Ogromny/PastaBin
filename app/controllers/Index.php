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

	public function encrypt(ViewFactory $view) {
		$title     = $this->request->post('paste_title', false);
		$password  = $this->request->post('paste_pass', false);
		$content   = $this->request->post('paste_content', false);

		if (!$title OR !$password OR !$content) {
			// Replace with an error
			return "Invalid argument";
		}

		return $title . "\n" . $password . "\n" . $content;

		/**
		 * INSERT IN BDD
		 */

		/**
		 * REDIRECT TO THE DECYRPTED PAGE
		 */
	}
}
