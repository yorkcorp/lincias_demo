<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Database configuration for LicenseBox
 *
 * LicenseBox v1.2
 *
 * teamcodemonks@gmail.com
 * https://www.techdynamics.org
 *
 */

$active_group = 'default';
$query_builder = TRUE;

// localhost : MySQL hostname
// inui_license : The name of the database for LicenseBox
// inui_license : MySQL database username
// B4til2hap1! : MySQL database password
$db['default'] = array(
	'dsn'	=> 'mysql:host=localhost;dbname=inui_licensetest',
	'hostname' => 'localhost',
	'username' => 'root',
	'password' => '',
	'database' => 'inui_licensetest',
	'dbdriver' => 'pdo',
	'dbprefix' => '',
	'pconnect' => FALSE,
	'db_debug' => (ENVIRONMENT !== 'development'),
	'cache_on' => FALSE,
	'cachedir' => '',
	'char_set' => 'utf8',
	'dbcollat' => 'utf8_general_ci',
	'swap_pre' => '',
	'encrypt' => FALSE,
	'compress' => FALSE,
	'stricton' => FALSE,
	'failover' => array(),
	'save_queries' => TRUE
);

/* All done! */
