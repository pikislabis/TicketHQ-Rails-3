// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$('div.flashes').live('click', function(e) {
  $(this).fadeOut();
});

$('#statuses_default').live('click', function (){
	$('#status_block').hide();
});

$('#statuses_custom').live('click', function (){
	$('#status_block').show();
});

$('.remove_status').live('click', function(e){
  e.preventDefault();
  $(this).parents('.status').remove();
});

$('.toggle_closed_tickets').live('click', function(e){
	e.preventDefault();
	$('tr.closed').toggle();
});