$(document).ready(function(){

  $("#btnQuiz").click(function() {
    var weight = $('#txtWeight').val();
    var height = ($('#ddlHeightFeet').val() * 12) + (+$('#ddlHeightInches').val());
    var action_url =  `/api/v1/stats/table?weight=${weight}&height=${height}`;

    $.ajax(action_url)
     .done(result =>{
      console.log(result)
      if (result.status === "SUCCESS"){
        setupQuizReport(result.data);
      }
     })
  });  

  function setupQuizReport(stats){
    var pet = stats.preferedPet;
    if (pet){
      $(".lblPet").text(pet);
      $("#imgPet").attr("src",`/assets/${pet}.jpeg`);

      var confidence = (pet === 'cat' ?  stats.catFanConfidence : stats.dogFanConfidence);
      var similarConfidence = (pet === 'cat' ?  stats.similarMetricsConfidence.catFanConfidence 
        : stats.similarMetricsConfidence.dogFanConfidence);

      $("#lblConfidence").text(Math.ceil(confidence*100));
      $("#lblSimilarConfidence").text(Math.ceil(similarConfidence*100));
    }
  }
});