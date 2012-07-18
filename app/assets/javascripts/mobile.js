//= require jquery
//= require jquery_ujs
//= require jqtouch/jqtouch.min
//= require jqtouch/jquery.1.3.2.min
//= require_self

$('select#q_project_id_eq').live('change', function(e){
	project_id = $(this).val();
	$.ajax({
    url: "/tickets/dynamic_statuses",
    data: {project_id: project_id},
		success: function(data){
    	$("#q_status_id_eq").replaceWith(data);
    }
  });
});