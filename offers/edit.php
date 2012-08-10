<?php

include_once './_common.php';

no_access_if_not_allowed('offers/edit');

if (empty($_GET['id'])) bad_request();

$referer = get_referer("offers/view.php?id={$_GET['id']}");

if (!is('post') || empty($_POST['offer'])) go_to($referer);

$oldOffer = fetch_one('SELECT id, number, closedAt FROM offers WHERE id=? LIMIT 1', array(1 => $_GET['id']));

if (empty($oldOffer) || !empty($oldOffer->closedAt)) not_found();

$offer = $_POST['offer'];
$items = empty($_POST['item']) ? array() : $_POST['item'];

$conn = get_conn();

try
{
  $conn->beginTransaction();

  $fields   = array('title', 'supplier', 'supplierContact', 'client', 'clientContact', 'intro', 'outro');
  $bindings = array();

  foreach ($fields as $field)
  {
    if (array_key_exists($field, $offer))
    {
      $bindings[$field] = $offer[$field];
    }
  }

  exec_update('offers', $bindings, "id={$oldOffer->id}");
  exec_stmt('DELETE FROM offer_items WHERE offer=?', array(1 => $oldOffer->id));

  foreach ($items as $item)
  {
    $item['offer'] = $oldOffer->id;
    
    exec_insert('offer_items', $item);
  }

  $conn->commit();

  set_flash(sprintf('Oferta <%s> została zaktualizowana pomyślnie.', $oldOffer->number));
}
catch (Exception $x)
{
  set_flash($x->getMessage(), 'error');
}

go_to($referer);