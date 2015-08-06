animNetwork = function(){


  setTimeout(function(){
    $(".public .http").removeClass("faded");
    $(".load-balancer").removeClass("faded");
  }, 300);


  setTimeout(function(){
    network.runHttp();
  }, 300)

};