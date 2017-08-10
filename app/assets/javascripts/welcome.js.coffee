ready = ->

  clearNotice = ->
    # $('.alert-info').animate { opacity: '0' }, 3500
    $('.alert-info').fadeOut()
    return

  $ ->
    setTimeout clearNotice, 1000
    return

  $('.flexslider').flexslider
    animation: 'slide'
    animationLoop: false
    itemWidth: 50
    itemMargin: 5
    minItems: 2
    maxItems: 3

  return

$(document).on 'turbolinks:load', ready
