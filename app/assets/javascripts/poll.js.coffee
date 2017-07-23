ready = ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.col-sm-3').remove()
    event.preventDefault()
    return

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    $('.form-control').enableClientSideValidations()
    event.preventDefault()
    return

  return
  # preview = $('.upload-preview img')
  # $('.file').change (event) ->
  #   input = $(event.currentTarget)
  #   file = input[0].files[0]
  #   reader = new FileReader
  #
  #   reader.onload = (e) ->
  #     image_base64 = e.target.result
  #     preview.attr 'src', image_base64
  #
  #   reader.readAsDataURL file

$(document).ready ready
$(document).on 'turbolinks:load', ready
