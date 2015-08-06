var animGateway = function(){

  var animateScene = function(){
    animate({
      el: ".private",

      opacity: [0, 1],
      easing: "easeOutCubic",
      duration: 1000,
      delay: 100
    });


    setTimeout(function(){
      $(".private").addClass("loaded");
    }, 300);


    animate({
      el: ".public",

      opacity: [0, 1],
      easing: "easeOutCubic",
      duration: 1000,
      delay: 800
    });

    animate({
      el: ".public span",

      opacity: [0, 1],
      translateY: [10, 0],
      // easing: "easeOutCubic",
      duration: 1000,
      delay: 1600
    });

    animate({
      el: ".private span",

      opacity: [0, 1],
      translateY: [10, 0],
      // easing: "easeOutCubic",
      duration: 1000,
      delay: 2000
    });
  };

  animateScene();
};