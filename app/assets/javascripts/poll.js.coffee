removeOption = ($el) ->
  $this = $el
  $hidden = $this.prev('input[type=hidden]')
  $optionFields = $this.closest('.option-fields')

  $hidden.prev('input[type=hidden]').val('1')
  $optionFields.closest('.option-fields').remove()
  event.preventDefault()
  return

addOption = ($el) ->
  $this = $el
  $data = $this.data('fields')
  time = new Date().getTime()
  regexp = new RegExp($this.data('id'), 'g')

  $this.before($data.replace(regexp, time))
  $('.form-control').enableClientSideValidations()
  event.preventDefault()
  return


ready = ->
  $('form').on 'click', '.remove_fields', (event) ->
    removeOption($(this))
    event.preventDefault()
    return

  $('form').on 'click', '.add_fields', (event) ->
    addOption($(this))
    return

  $("form").on 'change', "[type=file]", ->
    if typeof FileReader != 'undefined'
      image_holder = $(this).closest('fieldset').find('#previewImage')
      image_holder.empty()
      reader = new FileReader
      reader.onload = (e) ->
        $('<img />',
          'src': e.target.result
          'class': 'thumb-image').appendTo image_holder
        console.log($(this))
        return

      image_holder.show()
      reader.readAsDataURL $(this)[0].files[0]
    else
      alert 'This browser does not support FileReader.'
    return

  # $("a.fancybox").fancybox()
  #   openEffect	: 'none'
	# 	closeEffect	: 'none'
  #   # closeBtn: false
  #   # helpers:
  #   #   title: type: 'inside'
  #   #   buttons: {}
  #   # return
  return

$(document).on 'turbolinks:load', ready
