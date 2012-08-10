<?php

include '../../_common.php';

no_access_if_not_allowed('catalog/manage');

if (empty($_GET['id'])) bad_request();

$query = <<<SQL
SELECT p.*, c.name AS categoryName
FROM catalog_products p
INNER JOIN catalog_categories c ON c.id=p.category
WHERE p.id=?
LIMIT 1
SQL;

$oldProduct = fetch_one($query, array(1 => $_GET['id']));

if (empty($oldProduct)) bad_request();

$errors  = array();
$referer = get_referer('catalog/'); 

if (is('put'))
{
  $product = empty($_POST['product']) ? array() : $_POST['product'];

  if (is_empty($product['name']))
    $errors[] = 'Nazwa produktu jest wymagana';

  if (!empty($errors))
    goto VIEW;

  try
  {
    $product['category'] = $oldProduct->category;
    
    exec_update('catalog_products', $product, 'id=' . $oldProduct->id);

    log_info("Dodano produkt <{$product['name']}> do katalogu.");

    if (is_ajax())
      output_json(array(
        'success' => true,
        'data'    => array(
          'id'       => $oldProduct->id,
          'category' => $oldProduct->category,
          'name'     => $product['name']
        )
      ));

    set_flash("Produkt został zmodyfikowany pomyślnie.");

    go_to($referer);
  }
  catch (PDOException $x)
  {
    if ($x->getCode() == 23000)
      $errors[] = 'Nazwa produktu musi być unikalna.';
    else
      $errors[] = $x->getMessage();
  }
}
else
{
  $product = (array)$oldProduct;
}

VIEW:

if (!empty($errors))
  output_json(array('status' => false, 'errors' => $errors));

?>

<? decorate('Modyfikowanie produktu z katalogu') ?>

<div class="block">
  <div class="block-header">
    <h1 class="block-name">Modyfikowanie produktu</h1>
  </div>
  <div class="block-body">
    <form id="editProductForm" method="post" action="<?= url_for("catalog/products/edit.php?id={$oldProduct->id}") ?>">
      <input name="_method" type="hidden" value="PUT">
      <input name="referer" type="hidden" value="<?= $referer ?>">
      <? display_errors($errors) ?>
      <ol class="form-fields">
        <li>
          <?= label('editProductCategory', 'Kategoria') ?>
          <p id="editProductCategory"><?= e($oldProduct->categoryName) ?></p>
        <li>
          <?= label('editProductName', 'Nazwa*') ?>
          <input id="editProductName" name="product[name]" type="text" value="<?= e($product['name']) ?>" maxlength="100">
        <li>
          <?= label('editProductDescription', 'Opis') ?>
          <textarea id="editProductDescription" name="product[description]" class="markdown"><?= e($product['description']) ?></textarea>
        <li>
          <?= label('editProductType', 'Typ') ?>
          <input id="editProductType" name="product[type]" type="text" value="<?= e($product['type']) ?>" maxlength="100">
        <li>
          <?= label('editProductManufacturer', 'Marka') ?>
          <input id="editProductManufacturer" name="product[manufacturer]" type="text" value="<?= e($product['manufacturer']) ?>" maxlength="100">
        <li>
          <input id="editProductPublic" name="product[public]" type="checkbox" value="1" <?= checked_if($product['public']) ?>>
          <?= label('editProductPublic', 'Publiczny') ?>
        <li>
          <ol class="form-actions">
            <li><input type="submit" value="Modyfikuj produkt">
            <li><a class="cancel" href="<?= $referer ?>">Anuluj</a>
          </ol>
      </ol>
    </form>
  </div>
</div>