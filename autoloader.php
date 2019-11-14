<?php
/**
 * Unreal Studio
 * Project: UnrealLicensing
 * User: jhollsoliver
 * Date: 03/06/15
 * Time: 16:38
 */

/**
 * Configuration Includes
 */

require_once 'config.php';
require_once 'cryptoconfig.php';

if (!isset($BaseURL)) {
    header("Location: install/");
}

/**
 * Library Includes
 */
require_once 'libs/RevAlgo.php';
require_once 'libs/Gauntlet.php';
require_once 'libs/Tools.php';
require_once 'libs/FilterClass.php';
require_once 'libs/totp.class.php';
require_once 'libs/sqAES.php';
require_once 'libs/SignatureHandler.php';
require_once 'libs/PML_Obfuscator.core.php';
require_once 'libs/AESHelper.php';
define('basepath', dirname(__FILE__) . '/libs');
require_once 'libs/phpseclib/Crypt/RSA.php';
require_once 'libs/IssueLicenseCertificateHandler.php';
require_once 'libs/LicenseCertificateHandler.php';
require_once 'libs/PHPMailer-master/PHPMailerAutoload.php';
require_once 'libs/log.php';
require_once 'libs/GAuth.php';
//require_once 'libs/PHPMailer-master/class.smtp.php';

/**
 * Library Object Initialization
 */

$LogHandler = new PML_Log(dirname(__FILE__) . '/logs');
$AES        = new AESHelper();
$RSA        = new Crypt_RSA();

$LicenseCertChecker = new LicenseCertificateHandler($RSA, $AES);
$LicenseCertChecker->LoadPublicKey($RSAKeyPair['public']);

$LicenseCertificateIssuer = new IssueLicenseCertificateHandler($RSA, $AES);
$LicenseCertificateIssuer->LoadPrivateKey($RSAKeyPair['private']);

$Gauntlet = new Gauntlet();
$RevAlgo  = new RevAlgo($RevAlgoCfg['key'], $RevAlgoCfg['sep']);
$Tools    = new Tools();
$TOTP     = new TOTP();
@$DatabaseHandler = new mysqli($Database['host'], $Database['user'], $Database['pass'], $Database['data']);
if ($DatabaseHandler->connect_errno > 0) {
    die($DatabaseHandler->error);
}
$TOTP->setSecretKey($RevAlgoCfg['key']);
$TOTP->setDigitsNumber(16);
$TOTP->setExpirationTime(240);
$Tools->RegisterClass('DbHandler', $DatabaseHandler);
$Tools->RegisterClass('TOTP', $TOTP);

/**
 * Constants Declaration
 */
define('BASE_URL', $BaseURL);
define('ASSETS_URL', $BaseURL . '/assets');
unset($BaseURL);
define('PRODUCT_NAME', 'PHPMyLicense');
define('PRODUCT_VERSION', '3.4.81');
define('SYSTEMPATH', dirname(__FILE__));
define('PHPMYLICENSE_API', 'https://api.phpmylicense.us/v1');
define('PHPMYLICENSE_UPDATESERVICE', 'https://updates.phpmylicense.us');
$query    = $DatabaseHandler->query("SELECT purchasecode, configurations FROM settings");
$settings = $query->fetch_array();
$data     = json_decode($settings['configurations']);
define('PRODUCT_UPDATECHANNEL', $data->updatechannel);
$purchasecode = $settings['purchasecode'];

/**
 * Security Initialization
 */

$SignatureHandler = new SignatureHandler();
$SignatureHandler->LoadExternalClass('Rsa', $RSA);

/**
 * Session Declaration
 */

session_start();


/**
 * License Verification
 */

$bp = array(
    '/ajax/index.php',
    '/api/index.php'
);
if (!in_array($_SERVER['SCRIPT_NAME'], $bp)) {
    //$response      = @file_get_contents(PHPMYLICENSE_API . '/envato/verifypurchase?purchasecode=' . $purchasecode);
    $response      = true;
    $response_json = json_decode($response, true);
    $SignatureHandler->prepareRSAPreProcessor();
    //if ($SignatureHandler->ValidateJsonSignature($response_json) == false) {
    if ($response_json == false) {
        die('<b>Error! </b>PHPMyLicense can\'t verify if the API Response is authentic. Get in touch with us.<br><br>Error ID: 2974ae<br>Operation ID: ' . substr(md5(rand(0, 999)), 0, 11));
    }
    
    if ($response_json == false) {
        die('<b>Error! </b>Your Purchase Code appears to be invalid or banned. Get in touch with us.<br><br>Error ID: 65d194c<br>Operation ID: ' . substr(md5(rand(0, 999)), 0, 11));
    }
    $f = json_decode(base64_decode(file_get_contents(__DIR__ . '/offline.dat')), true);
    if ($response === false) {
        if (file_exists(__DIR__ . '/offline.dat')) {
            $SignatureHandler->prepareRSAPreProcessor();
            $v = $SignatureHandler->ValidateJsonSignature($f);
            if (!$v) {
                die('<b>Error! </b>PHPMyLicense tried to validate your purchase via Offline Activation, but it seems to be invalid. Please connect to the Internet to be validated..<br><br>Error ID: a430f2b<br>Operation ID: ' . substr(md5(rand(0, 999)), 0, 11));
            }
            
            $now = time();
            if ($f['expiry'] < $now) {
                die('<b>Error! </b>PHPMyLicense tried to validate your purchase via Offline Activation, but it seems to be expired, it means you are too long off the network. Please connect to the Internet to be validated..<br><br>Error ID: c883432<br>Operation ID: ' . substr(md5(rand(0, 999)), 0, 11));
            }
            
            if ($f['purchasecode'] != $purchasecode) {
                die('<b>Error! </b>PHPMyLicense tried to validate your purchase via Offline Activation, but the purchase code seems not to be the same of your PML installation. Are you trying to null PML? If you want a copy, get in touch with us, maybe we can give you a free license!<br><br>Error ID: 3bbc5f3<br>Operation ID: ' . substr(md5(rand(0, 999)), 0, 11));
            }
            if ($f['host'] != $_SERVER['SERVER_ADDR'] && $_SERVER['SERVER_ADDR'] != '127.0.0.1') {
                die('<b>Error! </b>PHPMyLicense tried to validate your purchase via Offline Activation, but the machine you are trying to run this PML installation is not the same that generated the Offline Activation. Are you trying to null PML? If you want a copy, get in touch with us, maybe we can give you a free license!<br><br>Error ID: 16f0a8c<br>Operation ID: ' . substr(md5(rand(0, 999)), 0, 11));
            }
            
            
        } else {
            die('<b>Error! </b>PHPMyLicense tried to validate your License with Offline Methods and failed. Please try again in few seconds.<br><br>Error ID: 8b7432d<br>Operation ID: ' . substr(md5(rand(0, 999)), 0, 11));
        }
        
    } else {
        $SignatureHandler->prepareRSAPreProcessor();
        $v = $SignatureHandler->ValidateJsonSignature($f);
        if ($f['expiry'] < time() || $v == true) {
            $response = @file_get_contents(PHPMYLICENSE_API . '/envato/getofflinekey?purchasecode=' . $purchasecode);
            $response = @json_decode($response, true);
            if ($response['valid'] == true) {
                file_put_contents(__DIR__ . '/offline.dat', $response['activationfile']);
            }
        }
    }
    
}
