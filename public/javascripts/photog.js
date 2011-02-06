$(document).ready(function() {

  // validate all forms
  $("form").validationEngine();

  $("a[rel='colorbox']").colorbox();

  // delete via ajax
  $("a.delete, a.delete-no-conf").live('click', function(event) {
    clicked = $(this)
    // we don't want to confirm the deletion for delete-no-conf (bulk photo deletions)
    if ( clicked.hasClass('delete-no-conf') || confirm("Are you sure you want to remove this item?") ) {
      $.ajax({
        url: this.href,
        type: 'post',
        dataType: 'json',
        data: { '_method': 'delete' },
        success: function() {
          // remove the table row if there is one
          if (!clicked.parents('tr').remove()) {
            // remove the link if it wasn't in a table row
            clicked.remove();
          }
          // inform the user of status via gritter (growl)
          $.gritter.add({
            title: "Success",
            text: "Record was deleted.",
            image: '/images/icons/notice.png',
            time: 2000
          });
        }
      });
    }
    event.preventDefault();
  });

});