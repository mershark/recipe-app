$(document).on('change', '#public-checkbox', function() {
  $('#public-status-submit').click(); 
});

$(document).on('ajax:success', '#recipe-form', function(event) {
  alert('Recipe updated successfully!'); 
});