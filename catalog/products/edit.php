<?php

include_once __DIR__ . '/../_common.php';

no_access_if_not_allowed('catalog/manage');

bad_request_if(empty($_GET['id']));

$query = <<<SQL
SELECT
  p.*,
  c.name AS categoryName
FROM catalog_products p
INNER JOIN catalog_categories c ON c.id=p.category
WHERE p.id=?
LIMIT 1
SQL;

$oldProduct = fetch_one($query, array(1 => $_GET['id']));

bad_request_if(empty($oldProduct));

$errors = array();
$referer = get_referer('catalog/'); 

if (is('put'))
{
  $product = $_POST['product'] + array('markings' => array());

  if (is_empty($product['category']))
  {
    $errors[] = 'Kategoria produktu jest wymagana.';
  }
  else
  {
    $category = fetch_one('SELECT id, name FROM catalog_categories WHERE id=?', array(1 => $product['category']));

    if (empty($category))
    {
      $errors[] = 'Wybrana kategoria nie istnieje.';
    }
  }

  if (is_empty($product['name']))
    $errors[] = 'Nazwa produktu jest wymagana.';

  if (!empty($errors))
    goto VIEW;

  if (!empty($product['markings']) && is_array($product['markings']))
  {
    $product['markings'] = implode(',', $product['markings']);
  }

  if (empty($product['public']))
  {
    $product['public'] = 0;
  }

  try
  {
    $product['updatedAt'] = time();

    if (empty($product['nr']))
    {
      $product['nr'] = catalog_generate_product_nr($product + array('id' => $oldProduct->id));
    }

    exec_update('catalog_products', $product, "id={$oldProduct->id}");

    log_info("Zmodyfikowano produkt <{$product['name']}>.");

    set_flash("Produkt <{$product['name']}> został zmodyfikowany pomyślnie.");

    catalog_set_categories_cache();

    go_to("/catalog/?category={$product['category']}&product={$oldProduct->id}");
  }
  catch (PDOException $x)
  {
    $errors[] = $x->getMessage();
  }
}
else
{
  $category = (object)array(
    'id' => $oldProduct->id,
    'name' => $oldProduct->categoryName
  );
  $product = (array)$oldProduct;
}

VIEW:

if (empty($category))
{
  $category = (object)array('id' => 0, 'name' => '');
}

$categoryPath = catalog_get_category_path($category->id);
$markings = catalog_get_product_markings();
$kinds = catalog_get_product_kinds();
$manufacturers = catalog_get_manufacturers();

if (!is_array($product['markings']))
{
  $product['markings'] = explode(',', (string)$product['markings']);
}

?>

<? begin_slot('head') ?>
<link rel="stylesheet" href="<?= url_for("/catalog/products/_static_/form.css") ?>">
<? append_slot() ?>

<? begin_slot('js') ?>
<script>
var CATALOG_SEARCH_CATEGORIES_URL = '<?= url_for("/catalog/categories/fetch.php") ?>';
</script>
<script src="<?= url_for("/catalog/products/_static_/form.js") ?>"></script>
<? append_slot() ?>

<? decorate('Modyfikowanie produktu - Katalog produktów') ?>

<div class="block">
  <div class="block-header">
    <h1 class="block-name">Modyfikowanie produktu</h1>
  </div>
  <div class="block-body">
    <form id="editProductForm" method="post" action="<?= url_for("catalog/products/edit.php?id={$oldProduct->id}") ?>">
      <input name="_method" type="hidden" value="PUT">
      <input name="referer" type="hidden" value="<?= $referer ?>">
      <? display_errors($errors) ?>
      <? include_once __DIR__ . '/_form.php' ?>
    </form>
  </div>
</div>
