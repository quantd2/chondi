ready = ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.option-fields').remove()
    event.preventDefault()
    return

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    $('.form-control').enableClientSideValidations()
    event.preventDefault()
    return

  $('.reply').on 'click', '.add_comment', (event) ->
    $reply = $(this).closest(".reply")
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields'))#.replace(regexp, time))
    $(this).hide()
    # $reply.find('.form-control').enableClientSideValidations()
    event.preventDefault()
    return

  $('.reply').on 'click', '.cancel', (event) ->
    # $(this).prev('input[type=hidden]').val('1')
    console.log($(this).closest('.reply').find('form'))
    # $(this).closest('.reply').find('.add_comment').show()
    $(this).closest('.reply').find('.add_comment').show()
    $(this).closest('.reply').find('form').remove()

    event.preventDefault()
    return

  return

$(document).on 'turbolinks:load', ready
