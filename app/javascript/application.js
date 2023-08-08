// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"

$(document).ready(function() {
  $('#confirmLogout').on('click', function(e) {
    e.preventDefault();
    var deleteUrl = $(this).attr('href');
    var csrfToken = $('meta[name="csrf-token"]').attr('content');
    console.log(deleteUrl, csrfToken)
    $.ajax({
      url: deleteUrl,
      type: 'DELETE',
      headers: {
        'X-CSRF-Token': csrfToken
      },
      success: function (result) {
          location.reload();
      }
    });
  });
})