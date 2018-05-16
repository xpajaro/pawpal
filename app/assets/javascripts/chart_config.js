$(document).ready(function(){

  $.loadChart = function(chartName, labels, catFans, dogFans){
    var ctx = $(`#${chartName}`);


    var myChart = new Chart(ctx, {
      type: 'line',
      data: {
          labels: labels,
          datasets: [{
                label: '# of cat lovers',
                borderColor: '#ff6384',
                backgroundColor: 'rgba(0,0,0,0)',
                data: catFans,
                borderWidth: 1
            },{
              label: '# of dog lovers',
              borderColor: '#0000ff',
              backgroundColor: 'rgba(0,0,0,0)',
              data: dogFans,
              borderWidth: 1
          }
        ]
      },
      options: {
        scaleShowVerticalLines: false,
        scales: {
            yAxes: [{
                ticks: {
                  beginAtZero:true,
                  stepSize: 20
                }
            }],
            xAxes : [{
                gridLines : {
                  display : false
                },
                ticks: {
                  stepSize: 20,
                  maxTicksLimit:20
                }
            }]
        }
      }
    });
  }

});