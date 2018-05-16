$(document).ready(function(){

  var weightChartCallback  = createCallBack('weightChart');
  getChartData('weight', weightChartCallback);

  var heightChartCallback  = createCallBack('heightChart');
  getChartData('height', heightChartCallback);


  // when we get chart records from server, we have to parse them for the line chart
  function createCallBack(chartName){
    return (data) => {
      var labels=[], dogFans=[], catFans=[];
      if (data){
        $("#dvGraphs").show();

        labels = data.map(record => record.value).sort((a, b) => a - b);
        
        dogFans = data.map(record => record.noOfDogFans);
        catFans = data.map(record => record.noOfCatFans);

        $.loadChart(chartName, labels, dogFans, catFans);
      } else{
        showGetChartDataError();
      }
    }
  }

  // this is the service that gets charts and triggers supplied callback to laod load a chart
  function getChartData(endpoint, callback){
    var action_url =  `/api/v1/stats/${endpoint}`;

    $.ajax(action_url)
    .done(result =>{
      if (result.status === "SUCCESS"){
        console.log(result)
        callback(result.data);
      } else{
        showGetChartDataError();
      }
    })
    .fail (() =>{
      showGetChartDataError();
    })
  }

  function showGetChartDataError(){
    var error = `<strong>Oops!</strong> There was a problem loading chart data`;
    $.flash.show(error, 'alert-danger');
  }

});