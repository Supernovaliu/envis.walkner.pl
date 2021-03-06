<?php

include_once __DIR__ . '/../_common.php';

bad_request_if(empty($_POST['id']) || empty($_POST['latitude']) || empty($_POST['longitude']));

no_access_if_not(is_allowed_to('factory/edit'), has_access_to_factory($_POST['id']));

$factory = fetch_one('SELECT name FROM factories WHERE id=?', array(1 => $_POST['id']));

not_found_if(empty($factory));

$bindings = array(1 => (float)$_POST['latitude'], (float)$_POST['longitude'], (int)$_POST['id']);

try
{
  exec_stmt('UPDATE factories SET latitude=?, longitude=? WHERE id=?', $bindings);

  log_info('Zmieniono położenie fabryki <%s>.', $factory->name);

  output_json(array('status' => true));
}
catch (PDOException $x)
{
  output_json(array('status' => false, 'error' => $x->getMessage()));
}

?>
