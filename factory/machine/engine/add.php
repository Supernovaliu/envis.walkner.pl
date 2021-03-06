<?php

include_once __DIR__ . '/../../../_common.php';

bad_request_if(empty($_GET['machine']));

no_access_if_not(is_allowed_to('machine/device/add'), has_access_to_machine($_GET['machine']));

$machine = fetch_one(
  'SELECT m.id, m.name, m.factory, f.name AS factoryName FROM machines m INNER JOIN factories f ON f.id=m.factory WHERE m.id=?',
  array(1 => $_GET['machine'])
);

not_found_if(empty($machine));

$referer = get_referer('factory/machine/?id=' . $_GET['machine']);
$errors = array();

if (isset($_POST['engine']))
{
  if (!between(1, $_POST['engine']['id'], 64))
  {
    $errors[] = 'ID musi się składać z od 1 do 64 znaków alfanumerycznych oraz -, _.';
  }

  if (!between(1, $_POST['engine']['name'], 128))
  {
    $errors[] = 'Nazwa musi się składać z od 1 do 128 znaków.';
  }

  if (empty($errors))
  {
    $owner = is_numeric($_POST['engine']['owner']) && (int)$_POST['engine']['owner'] > 0
      ? (int)$_POST['engine']['owner']
      : null;

    $bindings = array(
      1 => $_POST['engine']['id'],
      $_POST['engine']['name'],
      $_GET['machine'],
      $owner
    );

    try
    {
      exec_stmt('INSERT INTO engines SET id=?, name=?, machine=?, owner=?', $bindings);

      log_info('Dodano urządzenie <%s>.', $_POST['engine']['name']);

      set_flash(sprintf('Urządzenie <%s> zostało dodane pomyślnie.', $_POST['engine']['name']));

      if (is_ajax())
      {
        output_json(array('status' => true,
                          'data' => array('id' => $bindings[1],
                                          'name' => $bindings[2])));
      }
      else
      {
        go_to($referer);
      }
    }
    catch (PDOException $x)
    {
      if ($x->getCode() == 26000)
      {
        not_found();
      }
      else
      {
        $errors[] = 'Podane ID jest już wykorzystane.';
      }
    }
  }

  if (is_ajax()) output_json(array('status' => false, 'errors' => render_errors($errors)));

  $name = e($_POST['engine']['name']);
  $id = e($_POST['engine']['id']);
  $owner = e($_POST['engine']['owner']);
  $ownerName = e($_POST['engine']['ownerName']);
}
else
{
  $name = '';
  $id = '';
  $owner = '0';
  $ownerName = '';
}

?>

<? begin_slot('js') ?>
<script type="text/javascript">
  $(function()
  {
    function fixAutocomplete(e, ui)
    {
      $(this).data('autocomplete').menu.element.css('width', $(this).width() + 'px');
    }

    $('#engine-owner-search').autocomplete({
      source: '<?= url_for('factory/fetch_people.php') ?>',
      minLength: 2,
      open: fixAutocomplete,
      select: function(e, ui)
      {
        this.value = ui.item ? ui.item.label : '';

        e.preventDefault();
      },
      change: function(e, ui)
      {
        this.value = ui.item ? ui.item.label : '';

        $('#engine-owner').val(ui.item ? ui.item.value : 0);
      }
    });
  });
</script>
<? append_slot() ?>

<? decorate('Dodawanie urządzenia do maszyny') ?>

<div class="block">
  <div class="block-header">
    <h1 class="block-name">Nowe urządzenie</h1>
  </div>
  <div class="block-body">
    <form method="post" action="<?= url_for('factory/machine/engine/add.php?machine=' . $machine->id) ?>">
      <input type="hidden" name="referer" value="<?= $referer ?>">
      <fieldset>
        <legend>Nowe urządzenie</legend>
        <? display_errors($errors) ?>
        <ol class="form-fields">
          <li>
            <label>Fabryka</label>
            <p><?= $machine->factoryName ?></p>
          <li>
            <label>Maszyna</label>
            <p><?= $machine->name ?></p>
          <li>
            <label for="engine-id">ID<span class="form-field-required" title="Wymagane">*</span></label>
            <input id="engine-id" name="engine[id]" type="text" maxlength="64" value="<?= $id ?>">
            <p class="form-field-help">Od 1 do 64 znaków alfanumerycznych oraz -, _.</p>
          <li>
            <label for="engine-name">Nazwa<span class="form-field-required" title="Wymagane">*</span></label>
            <input id="engine-name" name="engine[name]" type="text" maxlength="128" value="<?= $name ?>">
            <p class="form-field-help">Od 1 do 128 znaków.</p>
          <li>
            <label for="engine-owner-search">Domyślny właściciel:</label>
            <input id="engine-owner-search" name="engine[ownerName]" type="text" maxlength="128" value="<?= $ownerName ?>">
            <input id="engine-owner" name="engine[owner]" type="hidden" value="<?= $owner ?>">
          <li>
            <ol class="form-actions">
              <li><input type="submit" value="Dodaj urządzenie">
              <li><a href="<?= $referer ?>">Anuluj</a>
            </ol>
        </ol>
      </fieldset>
    </form>
  </div>
</div>
