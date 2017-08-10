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

validateUploadedFileType = ($el) ->
  $this = $el
  size = $this[0].files[0].size
  result = true
  $this.parent().find(".image.help-block").remove()
  fileExtension = [
    'jpeg'
    'jpg'
    'png'
    'gif'
  ]
  if $.inArray($this.val().split('.').pop().toLowerCase(), fileExtension) == -1
    $this.val('')
    result = false
    $('<span />',
      'class': "image help-block").text('Chỉ hỗ trợ các loại: ' + fileExtension.join(', ')).appendTo($this.parent())
  else if size > 2097152
    $this.val('')
    result = false
    $('<span />',
      'class': "image help-block").text('Tệp không được lớn hơn: '+ 2097152/1048576 + " MB").appendTo($this.parent())
    return
  return result


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
      image_preview = $(this).closest('fieldset').find('#previewImage')
      image_preview.empty()
      reader = new FileReader
      if validateUploadedFileType($(this))
        reader.onload = (e) ->
          $('<img />',
            'src': e.target.result
            'class': 'thumb-image').appendTo image_preview
          return
        image_preview.show()
        reader.readAsDataURL $(this)[0].files[0]
      return
    else
      alert 'This browser does not support FileReader.'
    return

  $("form#new_poll").on 'click', ->
    optNumber = $(".option-fields").length
    console.log(optNumber)
    if optNumber <= 2 && optNumber >= 0
      $(".add_fields").show()
      $(".remove_fields").hide()
    else if optNumber > 2 && optNumber < 5
      $(".add_fields").show()
      $(".remove_fields").show()
    else if optNumber >= 5
      $(".add_fields").hide()
      $(".remove_fields").show()
      return
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
