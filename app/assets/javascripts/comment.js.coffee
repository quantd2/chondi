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

  return
$(document).on 'turbolinks:load', ready
