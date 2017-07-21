# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


clearNotice = ->
  $('.alert-info').animate { opacity: '0' }, 1500
  return

$ ->
  setTimeout clearNotice, 1000

do ->
  # store the slider in a local variable
  $window = $(window)
  flexslider = vars: {}
  # tiny helper function to add breakpoints

  getGridSize = ->
    if window.innerWidth < 600 then 2 else if window.innerWidth < 900 then 3 else 4

  $ ->
    SyntaxHighlighter.all()
    return
  $window.load ->
    $('.flexslider').flexslider
      animation: 'slide'
      animationLoop: false
      itemWidth: 210
      itemMargin: 5
      minItems: getGridSize()
      maxItems: getGridSize()
    return
  # check grid size on resize event
  $window.resize ->
    gridSize = getGridSize()
    flexslider.vars.minItems = gridSize
    flexslider.vars.maxItems = gridSize
    return
  return
