<?php

// Public font-end routes group.
$routes->group(['namespace' => 'app\controllers'], function($routes)
{
	$routes->get('/', 'Index::welcome', 'home');
	$routes->get('/about', 'Index::about', 'about');
	$routes->get('/api', 'Index::api', 'api-docs');
	$routes->get('/contact', 'Index::contact', 'contact');
	$routes->get('/roadmap', 'Index::roadmap', 'roadmap');
	$routes->post('/encrypt', 'Index::encrypt', 'encrypt');
});
