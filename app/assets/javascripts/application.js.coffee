#= require jquery
#= require bootstrap-sprockets
#= require jquery_ujs
#= require bootstrap-slider
#= require chartist.min
#= require_tree .

$ ->
  new App.TrackStyler
  new App.FormErrorsAccessibilizer $('form')
  
  