flexComment = ($el) ->
  $this = $el
  $expand = $this.find('.expand').filter(':first')
  $collapsables = $this.find(".sub-comments")
  $expand.on 'click', (e) ->
    toggle($expand, $collapsables)
    return
  return

toggle = ($exp, $col) ->
  $col.slideToggle(200)
  if $exp.text() == "[-] " then $exp.text('[+] ') else $exp.text('[-] ')
  return

ready = ->
  $li = $('li')
  $li.each (i) ->
    flexComment($(this))
    return

  $(document).ajaxStart ->
    $('.fa-spinner').show()
    return

  $(document).ajaxStop ->
    $('.fa-spinner').hide()
    return

  $('.delete').on 'click', '.intent', (event) ->
    event.preventDefault();
    $(this).next().show();
    $(this).hide();
    return

  $('.delete').on 'click', '.cancel', (event) ->
    event.preventDefault();
    $(this).closest(".confirmation").hide();
    console.log($(this));
    $(this).closest(".delete").find(".intent").show();
    return

  return
$(document).on 'turbolinks:load', ready
