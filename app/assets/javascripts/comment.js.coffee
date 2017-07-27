
ready = ->
  $li = $('li')
  $li.each (i) ->
    $expand = $(this).find('.expand').filter(':first')
    $collapsables = $(this).find(".sub-comments")
    # if ( $collapsables.children().length == 0 ) then $expand.empty()
    $expand.click (e) ->
      $collapsables.slideToggle(200)
      if $expand.text() == "[-] " then $expand.text('[+] ') else $expand.text('[-] ')
      return
    return

  $(document).ajaxStart ->
    $('.fa-spinner').show()
    return
  # hide spinner on AJAX stop
  $(document).ajaxStop ->
    $('.fa-spinner').hide()
    return

  return
$(document).on 'turbolinks:load', ready
