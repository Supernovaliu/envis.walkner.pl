<?php

include_once __DIR__ . '/_common.php';

bad_request_if(empty($_GET['id']) || !is_numeric($_GET['id']));

$allowedFormats = array(
  'html' => 'text/html',
  'pdf' => 'application/pdf',
);
$format = isset($_GET['format']) && isset($allowedFormats[$_GET['format']]) ? $_GET['format'] : 'html';

$offerFile = make_offer_file($_GET['id'], $format);

if (file_exists($offerFile) && (!isset($_GET['force']) || $_GET['force'] !== '1'))
{
  header(sprintf('Content-Type: %s', $allowedFormats[$format]));
  header(sprintf('Content-Length: %s', filesize($offerFile)));
  readfile($offerFile);
  exit;
}

$offer = fetch_and_prepare_offer_for_printing($_GET['id']);

not_found_if(empty($offer));

$en = !empty($_GET['lang']) && $_GET['lang'] === 'en';

include_once __DIR__ . '/print/full.php';
