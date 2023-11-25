$(document).on('change', '#public-checkbox', function() {
  $('#public-status-submit').click(); 
});

$(document).on('ajax:success', '#recipe-form', function(event) {
  alert('Recipe updated successfully!'); 
});

// modify

document.addEventListener("DOMContentLoaded", function() {
  $(".action-button").on("click", function(event) {
    event.preventDefault();
    var recipeId = $(this).data("recipe-id");
    var foodId = $(this).data("food-id");
    $(".modify-form").hide();
    $("#modify-form-" + recipeId + "-" + foodId).show();
  });

  $(document).on("submit", "form", function(event) {
    event.preventDefault();
    var form = $(this);

    $.ajax({
      type: form.attr("method"),
      url: form.attr("action"),
      data: form.serialize(),
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      success: function() {
        console.log("Ingredient updated successfully");
        $(".modify-form").hide();
        window.location.reload();
      },
      error: function(xhr, status, error) {
        console.error("Error:", error);
        alert("Failed to update ingredient. Please try again. Error: " + error);
      }
    });
  });
});
