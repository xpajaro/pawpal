$(document).ready(function(){

  loadChart('weightChart');

  function loadChart(chartName, labels, data, color){
    var ctx = $(`#${chartName}`);

    var myChart = new Chart(ctx, {
      type: 'line',
      data: {
          labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
          datasets: [{
                label: '# of cat lovers',
                borderColor: '#ff6384',
                backgroundColor: 'rgba(0,0,0,0)',
                data: [12, 19, 3, 50, 2, 3],
                borderWidth: 1
            },{
              label: '# of dog lovers',
              borderColor: '#0000ff',
              backgroundColor: 'rgba(0,0,0,0)',
              data: [2, 19, 23, 8, 12, 63],
              borderWidth: 1
          }
        ]
      },
      options: {
        scaleShowVerticalLines: false,
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }],
            xAxes : [{
                gridLines : {
                    display : false
                }
            }]
        }
      }
    });
  }
});