animNetwork = function(){


  var buildScene = function(){
    animate({
      el: ".fixed-panel",

      easing: "easeOutCirc",
      opacity: [0.1, 1],
      duration: 800,
      delay: 200
    });

    animate({
      el: ".network-container",

      easing: "easeOutCirc",
      opacity: [0.1, 1],
      duration: 800,
      delay: 200
    });


    animate({
      el: ".left, .right",

      easing: "easeOutCirc",
      opacity: [0, 1],
      duration: 800,
      delay: 800
    });

    animate({
      el: ".load-balancer, .app, .bastion, .database",

      easing: "easeOutCirc",
      opacity: [0, 1],
      duration: 800,
      delay: 1800
    });


    setTimeout(function(){
      $(".public .http").css("color", "rgba(255, 255, 255, 1)");

      $(".docker").removeClass("active");
      $(".load-balancer").addClass("active");
    }, 2400);
  };

  setTimeout(function(){
    network.runHttp();
  }, 1800)


  buildScene();
};