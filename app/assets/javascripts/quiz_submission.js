$(document).ready(function(){

  $("#btnQuiz").click(function() {
    var weight = $('#txtWeight').val();
    localStorage.setItem('weight', weight);
    if (!weight || weight < 8 || weight > 500){
      return;
    }

    var height = ($('#ddlHeightFeet').val() * 12) + (+$('#ddlHeightInches').val());
    localStorage.setItem('height', height);

    var action_url =  `/api/v1/stats/table?weight=${weight}&height=${height}`;

    $("#dvAnswerStats").fadeOut();
    $.flash.hide();

    $.ajax(action_url)
      .done(result =>{
        if (result.status === "SUCCESS"){
          setupQuizReport(result.data);
        } else{
          showQuizError();
        }
      })
      .fail (() =>{
        showQuizError();
      })
  });  


  function setupQuizReport(stats){
    var pet = stats.preferedPet;
    if (pet){
      localStorage.setItem('pet', pet);
      $("#dvAnswerStats").fadeIn();

      $(".lblPet").text(pet);
      $("#imgPet").attr("src",`/assets/${pet}.jpeg`);

      shareConfidence(stats);
    } else{
      showQuizError();
    }
  }

  function shareConfidence(stats) {
    var pet = stats.preferedPet;

    var confidence = (pet === 'cat' ?  stats.catFanConfidence : stats.dogFanConfidence);
    var similarConfidence = (pet === 'cat' ?  stats.similarMetricsConfidence.catFanConfidence 
      : stats.similarMetricsConfidence.dogFanConfidence);

    $("#lblConfidence").text(Math.ceil(confidence*100));
    $("#lblSimilarConfidence").text(Math.ceil(similarConfidence*100));
  }

  function showQuizError(){
    var quiz_error = `<strong>Oops!</strong> We couldn't find your spirit animal.`;
    $.flash.show(quiz_error, 'alert-danger');
  }


});