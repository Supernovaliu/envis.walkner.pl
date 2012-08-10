<? header('Content-Type: text/javascript; charset=UTF-8') ?>
<? include __DIR__ . '/../_common_url.php' ?>
function render(template, data)
{
	var el = null;

	if (template.selector != undefined)
	{
		el       = template;
		template = el.html();
	}

	for (var key in data)
	{
		template = template.replace(new RegExp('\\$\\{' + key + '\\}', 'g'), data[key]);
	}

	if (el != null)
	{
		el.html(template);

		template = el;
	}

	return template;
}
function center(el, innerEl)
{
	if (!innerEl) innerEl = el;

	el
		.css('top', ($(document).height() - innerEl.outerHeight()) / 2)
		.css('left', ($(document).width() - innerEl.outerWidth()) / 2);
}
function modal(selector, options)
{
	return $(selector).modal($.extend({
		overlayCss: {
			backgroundColor: '#000',
			cursor: 'wait'
		},
		containerCss: {
			textAlign: 'left',
			width: '500px'
		}},
		options ? options : {}
	));
}
function startWaiting()
{
	$('body').addClass('wait');
}
function stopWaiting()
{
	$('body').removeClass('wait');
}

$(function()
{
  var menuWidth = 0;

  $('#menu li').each(function()
  {
    menuWidth += $(this).outerWidth();
  });

  var windowEl = $(window);
  var bodyEl   = $('body');

  function resizeMenu()
  {
    var hdWidth = windowEl.width();

    if (hdWidth - 50 > menuWidth)
    {
      bodyEl.removeClass('sos');

      return;
    }
    else if (bodyEl.hasClass('sos'))
    {
      return;
    }

    bodyEl.addClass('sos');
  }

  resizeMenu();

  windowEl.resize(resizeMenu);

  $('div.message.closable').each(function()
  {
    var close = $('<span class=close title=zamknij>x</span>').click(function()
    {
      $(this).closest('div.message').fadeOut(function() { $(this).remove(); });
    });

    $(this).prepend(close);
  });

  var flashMessage = document.getElementById('flashMessage');

  if (flashMessage)
  {
    flashMessage = $(flashMessage);

    setTimeout(function() { flashMessage.fadeOut(function() { flashMessage.remove(); }); }, 10000);
  }

  var resizablesLoaded = false;

  $.makeAutoResizable = function()
  {
    var resizables = $('textarea.resizable');

    if (resizables.length)
    {
      if (!resizablesLoaded)
      {
        $('<link>').attr({rel: 'stylesheet', href: '<?= url_for_media('jquery-plugins/autoresize/0.1/jquery.autoresize.min.css') ?>'}).appendTo('head');

        $.getScript("<?= url_for_media('jquery-plugins/autoresize/0.1/jquery.autoresize.min.js') ?>", function()
        {
          resizables.each(function()
          {
            if (this.autoResizable) return;

            this.autoResizable = true;

            $(this).autoResize({extraSpace: 22});
          });

          delete resizables;
        });

        resizablesLoaded = true;
      }
      else
      {
        resizables.each(function() { $(this).autoResize({extraSpace: 22}); });

        delete resizables;
      }
    }
  };

  $.makeAutoResizable();

  if ($.modal)
  {
    $.extend($.modal.defaults, {
      overlayCss: {
        backgroundColor: '#000',
        cursor: 'wait'
      },
      containerCss: {
        textAlign: 'left',
        width: '500px'
      }
    });
  }
  
  $.fn.makeClickable = function()
  {
    $('td.clickable a', this).click(function() { return false; });
    
    this.delegate('td.clickable', 'mouseup', function(e)
    {
      var href = $(this).find('a').attr('href');
      
      if (!$(this).find('a')[0])
      {
        return false;
      }

      switch (e.button)
      {
        case 0:
          window.location.href = href;
          break;

        case 1:
          window.open(href);
          break;

        default:
          return true;
      }

      return false;
    });
  };
});