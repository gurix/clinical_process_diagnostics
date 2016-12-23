// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require bootstrap-slider
//= require chartist.min
//= require_tree .

// Style the track of a range input with a different lower and an upper color. Fixed missing -ms-fill-upper and -ms-fill-lower on webkit and firefox
$(document).ready(function(){
  var r = document.querySelectorAll('input[type=range]'), 
    prefs = ['webkit-slider-runnable', 'moz-range'], 
    styles = [], 
    l = prefs.length,
    n = r.length;

  var getTrackStyleStr = function(el, j) {
    var str = '', 
        min = el.min || 0, 
        perc = (el.max) ? ~~(100*(el.value - min)/(el.max - min)) : el.value, 
        val = perc + '%',
        id = el.id;
    for(var i = 0; i < l; i++) {
      str += '#' + id + '::-' + prefs[i] + '-track{ background: linear-gradient(90deg, #5cbdb1 ' + val + ', #DDD ' + val + ');} ';
    }
    return str;
  };

  var setDragStyleStr = function(evt) {
    var trackStyle = getTrackStyleStr(evt.target, this + 1);  
    styles[this].textContent = trackStyle;
  };

  for(var i = 0; i < n; i++) {
    var s = document.createElement('style');
    document.body.appendChild(s);
    styles.push(s);  
    r[i].addEventListener('input', setDragStyleStr.bind(i), false);
  }
});