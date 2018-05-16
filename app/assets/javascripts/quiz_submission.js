$(document).ready(function(){

  $("#btnQuiz").click(function() {
    var weight = $('#txtWeight').val();
    localStorage.setItem('weight', weight);

    var height = ($('#ddlHeightFeet').val() * 12) + (+$('#ddlHeightInches').val());
    localStorage.setItem('height', height);

    var action_url =  `/api/v1/stats/table?weight=${weight}&height=${height}`;

    $("#dvAnswerStats").fadeOut();
    $('#quizAlert').hide('fade');

    $.ajax(action_url)
      .done(result =>{
        if (result.status === "SUCCESS"){
          setupQuizReport(result.data);
        } else{
          $('#quizAlert').show('fade');
        }
      })
      .fail (() =>{
          $('#quizAlert').show('fade');
      })
  });  


  $("#btnCloseQuizAlert").click(function() {
    $('#quizAlert').hide('fade');
  
  });

  function setupQuizReport(stats){
    var pet = stats.preferedPet;
    if (pet){
      localStorage.setItem('pet', pet);
      $("#dvAnswerStats").fadeIn();

      $(".lblPet").text(pet);
      $("#imgPet").attr("src",`/assets/${pet}.jpeg`);

      var confidence = (pet === 'cat' ?  stats.catFanConfidence : stats.dogFanConfidence);
      var similarConfidence = (pet === 'cat' ?  stats.similarMetricsConfidence.catFanConfidence 
        : stats.similarMetricsConfidence.dogFanConfidence);

      $("#lblConfidence").text(Math.ceil(confidence*100));
      $("#lblSimilarConfidence").text(Math.ceil(similarConfidence*100));
    } else{
      $('quizAlert').show('fade');
    }
  }
});