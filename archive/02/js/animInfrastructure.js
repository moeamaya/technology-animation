var animInfrastructure = function() {
  var spinMe = function(obj) {
    $(obj).addClass("rotate");
  };
  var spinMeRev = function(obj){
    $(obj).addClass("rotate-rev");
  };

  var show = function(elements) {
    elements.forEach(function(el) { el.style.display = "block"; });
  };

  var animateScene = function(){

    animate({
      el: ".fixed-panel",

      easing: "easeOutQuad",
      opacity: [0,1],
      translateY: [80, 0],
      duration: 300,
      delay: 600
    });

    animate({
      el: "#infrastructure .copy",

      easing: "easeOutQuad",
      opacity: [0, 1],
      duration: 800
    });


    // STEP 1 - zoom fade in the loading circles
    setTimeout(function(){
      animate({
        el: ".customer-vpc-dots",

        opacity: 1,
        scaleY: [0.8, 1.0],
        scaleX: [0.8, 1.0],
        duration: 1200,
        delay: 100,
      });

      animate({
        el: ".loading-circle-1",

        opacity: 1,
        scaleY: [0.8, 1.0],
        scaleX: [0.8, 1.0],
        duration: 1200,
        delay: 200,

        complete: spinMeRev
      });

      animate({
        el: ".loading-circle-2",

        opacity: 1,
        scaleY: [0.8, 1.0],
        scaleX: [0.8, 1.0],
        duration: 1200,
        delay: 300,

        complete: spinMe
      });

      animate({
        el: ".loading-text",

        opacity: 1,
        easing: "easeOutCubic",
        translateY: [10, 0],
        duration: 400,
        delay: 800
      });


    }, 1200);


    // STEP 2 - Full size customer vpc
    setTimeout(function(){
      $(".loading-circle-1").fadeOut();
      $(".loading-circle-2").fadeOut();
      $(".loading-text").fadeOut();

      $(".customer-vpc-dots").removeClass("rotate").addClass("loaded");
      $(".customer-vpc").addClass("loaded");
    }, 3200);

    // STEP 3 - VPC Ready
    setTimeout(function(){
      animate({
        el: ".loaded-text",

        duration: 100,
        begin: show,
      });

      animate({
        el: ".loaded-text .bars",

        opacity: [0, 1],
        easing: "easeOutCubic",
        duration: 800
      });

    }, 4200);

    // STEP 3 - VPC Ready
    setTimeout(function(){
      animate({
        el: ".loaded-text .text",

        opacity: [0, 1],
        easing: "easeOutCubic",
        duration: 800
      });
    }, 4400);
  };


  // fade out the labels
  setTimeout(function(){
    $(".aws span.title").css("color", "rgba(255,255,255,0.1)");
    $(".aptible-cloud span.title").css("color", "rgba(255,255,255,0.1)");
  }, 4600);


  // Set the Networking Lines
  setTimeout(function(){
    network = Network();
    network.generateLines();
  }, 5000);


  animateScene();
};