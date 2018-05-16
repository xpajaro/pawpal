$(document).ready(function(){

  var alertCss;

  $.flash = {
    show: function(info, cssClass='alert-info'){
      if (info){
        $('#alertContent').html(info);

        $('.alert').addClass(cssClass);
        alertCss = cssClass;
        
        $('.alert').show('fade');
      }
    },

    hide: function(){
      $('.alert').removeClass(alertCss);
      alertCss = '';

      $('.alert').hide('fade');
    }
  }



  $("#btnCloseAlert").click(function() {
    $('.alert').hide('fade');
  
  });
});