$(document).ready(function(){

  $("#btnCorrect").click(function() {
    postConfirmation(true);
  });  
  $("#btnIncorrect").click(function() {
    postConfirmation(false)
  });  

  function postConfirmation(correctPet){
    // save w, h, pet from old query
    var weight = localStorage.getItem('weight');
    var height = localStorage.getItem('height');
    var pet = correctPet? localStorage.getItem('pet') : 'catdog'.replace(pet, '') ;

    var action_url =  `/api/v1/stats/confirm`;

    $.ajax({
        method: "POST",
        url: action_url,
        data: { weight: weight, height: height, pet: pet }
      })
      .done(result =>{
        
        if (result.status === "SUCCESS"){
          showConfirmationSuccess();
          $("#btnCorrect").fadeOut();
          $("#btnIncorrect").fadeOut();

        } else{
          showConfirmationError();
        }
      })
      .fail (() =>{
        showConfirmationError();
      })
  }

  function showConfirmationSuccess(){
    var quiz_error = `<strong>Thanks for helping out!</strong> Recommendations saved!`;
    $.flash.show(quiz_error, 'alert-info');
  }

  function showConfirmationError(){
    var quiz_error = `<strong>Sorry!</strong> We couldn't get save your recommendations.`;
    $.flash.show(quiz_error, 'alert-danger');
  }


});