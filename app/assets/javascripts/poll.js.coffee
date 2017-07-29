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

addComment = ($el) ->
  $this = $el
  $data = $this.data('fields')

  $this.before($data)
  $this.hide()
  event.preventDefault()
  return

cancelComment = ($el) ->
  $this = $el
  $addComment = $this.closest('.reply').find('.add_comment')
  $commentForm = $this.closest('.reply').find('form')

  $addComment.show()
  $commentForm.remove()
  event.preventDefault()
  return

refreshStats = (item, index, $el) ->
  updatedStats = visualize_votes_for(item)
  $el(index).html(updatedStats);
  return


ready = ->
  $('form').on 'click', '.remove_fields', (event) ->
    removeOption($(this))
    event.preventDefault()
    return

  $('form').on 'click', '.add_fields', (event) ->
    addOption($(this))
    return

  $('.reply').on 'click', '.add_comment', (event) ->
    addComment($(this))
    return

  $('.reply').on 'click', '.cancel', (event) ->
    cancelComment($(this))
    return

  return

$(document).on 'turbolinks:load', ready
