var animGateway = function(){

  var animateScene = function(){

    $(".http, .ssh").addClass("faded");

    setTimeout(function(){
      $(".docker").addClass("faded");
    }, 100);

  }

  animateScene();
};