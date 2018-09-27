<?php 

require_once("vendor/autoload.php");

use \Slim\Slim;
use \Hcode\Page;

$app = new Slim();

$app->config('debug', true);

$app->get('/', function() {
    
	// $teste = $_SERVER["DOCUMENT_ROOT"].DIRECTORY_SEPARATOR."views";
 //    var_dump($teste);
	$page = new Page();

	$page->setTpl("index");

});

$app->run();

 ?>