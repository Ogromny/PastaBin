<?php

// Front pages routes group.
$routes->group(['namespace' => 'pastabin\controllers\front'], function($routes)
{
	$routes->get('/', 'Front::welcome', 'home');
	$routes->get('/about', 'Front::about', 'about');
	$routes->get('/contact', 'Front::contact', 'contact');
	$routes->get('/roadmap', 'Front::roadmap', 'roadmap');
});

// API Documentation routes group.
$routes->group(['namespace' => 'pastabin\controllers\docs'], function($routes)
{
	$routes->get('/docs', 'Documentation::index', 'api-docs');
});

// Paste routes group.
$routes->group(['namespace' => 'pastabin\controllers\paste'], function($routes)
{
	$routes->get('/paste/new', 'Paste::new', 'new-paste');
	$routes->post('/paste/new', 'Paste::post_new');

	$routes->get('/paste/{id}', 'Paste::display', 'display-paste');
	$routes->get('/paste/{id}/raw', 'Paste::raw', 'raw-paste');
	$routes->get('/paste/{id}/edit', 'Paste::edit', 'edit-paste');
	$routes->get('/paste/{id}/delete', 'Paste::delete', 'delete-paste');
});
