<?php
require_once 'Mike42/Escpos/CapabilityProfile.php';
require_once 'Mike42/Escpos/PrintConnectors/WindowsPrintConnector.php';
require_once 'Mike42/Escpos/Printer.php';

use Mike42\Escpos\Printer;
use Mike42\Escpos\PrintConnectors\WindowsPrintConnector;
use Mike42\Escpos\CapabilityProfile;

$profile = CapabilityProfile::load("simple");
$connector = new WindowsPrintConnector("wintec");
$printer = new Printer($connector, $profile);

$printer -> text("Hello World!\n\n\n\n\n");
$printer -> cut();
$printer->pulse();
$printer -> close();
echo "Sukses";