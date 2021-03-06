<div id="catalog" class="block <?= $showProduct ? 'collapsed' : '' ?>">
  <ul class="block-header">
    <li>
      <h1 class="block-name">Produkty</h1>
    <? if ($canManageProducts): ?>
    <? if (empty($category)): ?>
    <li><?=  fff('Dodaj główną kategorię', 'folder_add', 'catalog/categories/add.php') ?>
    <? else: ?>
    <li><?= fff('Dodaj produkt', 'folder_page', "catalog/products/add.php?category={$category->id}") ?>
    <li><?= fff('Dodaj podkategorię', 'folder_add', "catalog/categories/add.php?parent={$category->id}") ?>
    <li><?= fff('Edytuj kategorię', 'folder_edit', "catalog/categories/edit.php?id={$category->id}") ?>
    <li><?= fff('Usuń kategorię', 'folder_delete', "catalog/categories/delete.php?id={$category->id}") ?>
    <? endif ?>
    <? endif ?>
  </ul>
  <div class="block-body">
    <? if (empty($products)): ?>
    <? if ($isRoot): ?>
    <p>Wybierz kategorię.</p>
    <? else: ?>
    <p>Brak produktów w wybranej kategorii.</p>
    <? if ($canManageProducts): ?>
    <ul class="actions">
      <li><?= fff_link('Dodaj podkategorię', 'folder_add', "catalog/categories/add.php?parent={$category->id}") ?></li>
      <li><?= fff_link('Dodaj produkt', 'folder_page', "catalog/products/add.php?category={$category->id}") ?></li>
    </ul>
    <? endif ?>
    <? endif ?>
    <? else: ?>
    <table>
      <thead>
        <tr>
          <th>Nazwa</th>
          <th>Typ</th>
          <th>Nr</th>
          <th class="actions">Akcje</th>
        </tr>
      </thead>
      <? if (!empty($pagedProducts)): ?>
      <tfoot>
        <tr>
          <td colspan="99" class="table-options">
            <?= $pagedProducts->render(url_for("catalog/?category={$categoryId}&product={$productId}")) ?>
          </td>
        </tr>
      </tfoot>
      <? endif ?>
      <? if (!empty($pagedProducts)): ?>
      <tbody id="products">
        <? foreach ($pagedProducts as $categoryProduct): ?>
        <tr>
          <td class="clickable"><a href="<?= url_for("catalog/?category={$categoryProduct->category}&product={$categoryProduct->id}&page={$pagedProducts->getPage()}") ?>"><?= e($categoryProduct->name) ?></a></td>
          <td><?= dash_if_empty($categoryProduct->type) ?></td>
          <td><?= dash_if_empty($categoryProduct->nr) ?></td>
          <td class="actions">
            <ul>
              <? if ($canManageProducts): ?>
              <li><?= fff('Pokaż produkt', 'page', "catalog/?product={$categoryProduct->id}") ?></li>
              <li><?= fff('Edytuj produkt', 'page_edit', "catalog/products/edit.php?id={$categoryProduct->id}") ?></li>
              <li><?= fff('Usuń produkt', 'page_delete', "catalog/products/delete.php?id={$categoryProduct->id}") ?></li>
              <? endif ?>
              <li><?= fff('Pokaż kartę katalogową', 'page_white', "catalog/products/card/?id={$categoryProduct->id}") ?></li>
            </ul>
          </td>
        </tr>
        <? endforeach ?>
      </tbody>
      <? endif ?>
    </table>
    <? endif ?>
  </div>
</div>
