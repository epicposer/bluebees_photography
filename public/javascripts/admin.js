// Function for easily submitting forms with ajax.
// The action being submitted to should return javascript (I.e. create.js.erb / update.js.erb)
// Just add a selector to the page like $("new_comment").submitWithAjax();
jQuery.fn.submitWithAjax = function() {
	this.submit(function() {
		$.post($(this).attr("action"), $(this).serialize(), null, "script");
		return false;
	});
}

// makes sure our ajax requests actually look like ajax requests to the server
jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$(document).ready(function() {

  var auth_token = $("meta[name=csrf-token]").attr("content")
  
	// validate all forms
	$("form").validationEngine();
	
	$("a[rel='colorbox']").colorbox();
	$("a[rel='colorbox-frame']").colorbox({iframe:true, innerWidth:660, innerHeight:600});
	
	$('a.delete').live('click', function(event) {
		if ( confirm("Are you sure you want to delete this record?") ) {
		  var delete_link = this;
			$.post(this.href, {_method:"delete", authenticity_token:auth_token}, function(data) {
			  // remove the first parent list item or table row we find (assumes the delete link was in a table or a list)
  			$(delete_link).parents('li, tr').first().fadeOut('fast', function() {$(this).remove()});
				// inform the user of status via gritter (growl)
        $.gritter.add({
      		title: data.title,
      		text: data.message,
      		image: '/images/icons/notice.png',
      		time: 3000
      	});
   	  }, "json");
		}
		return false;
	});
	
	$('a.delete-no-conf').live('click', function(event) {
	  var delete_link = this;
		$.post(this.href, {_method:"delete", authenticity_token:auth_token}, function(data) {
			// not going to message the user, gets cluttered
			// remove the first parent list item or table row we find (assumes the delete link was in a table or a list)
			$(delete_link).parents('li, tr').first().fadeOut('fast', function() {$(this).remove()});
		}, "json");
		return false;
	});
	
});