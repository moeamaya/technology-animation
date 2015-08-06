var deployAnim = function() {


  var spinMe = function(obj){
    $(obj).addClass("rotate");
  };
  var spinMeRev = function(obj){
    $(obj).addClass("rotate-rev");
  };

  var show = function (elements) {
    elements.forEach(function(el) { el.style.display = "inline-block"; });
  };



  var init = function(){
    animate({
      el: "#deploy .console",

      translateY: [40, 0],
      duration: 1200
    });

    // STEP 1
    setTimeout(function(){
      $("#deploy .console").css("box-shadow", "0 1px 6px rgba(0, 0, 0, 0.9)");

      $(".aws").css({
        "background": "background: rgba(256, 256, 256, 0.2);",
        "color": "#ddd"
      });
    }, 100);

    // STEP 2
    setTimeout(function(){
      var $src = $(".b1-text");
      Helpers.typeConsole("aptible apps:create test-app", $src);
    }, 500);

    // STEP 2.5
    setTimeout(function(){
      $(".b1-text").append("<br />")
      $(".b1-text").append("&nbsp; <span class='blue'>remote:<span> (8ミ | INFO: Authorizing... ")
    }, 3200)

    deploy = false;

    // STEP 3
    animate({
      el: ".load-text",

      opacity: 1,
      easing: "easeOutCubic",
      translateY: [10, 0],
      duration: 400,
      delay: 4600
    });
    animate({
      el: ".load1",

      opacity: 1,
      scaleY: [0.8, 1.0],
      scaleX: [0.8, 1.0],
      duration: 1200,
      delay: 3800
    });

    animate({
      el: ".load2",

      opacity: 1,
      scaleY: [0.8, 1.0],
      scaleX: [0.8, 1.0],
      duration: 1200,
      delay: 3700,

      complete: spinMe
    });

    animate({
      el: ".load3",

      opacity: 1,
      scaleY: [0.7, 1.0],
      scaleX: [0.7, 1.0],
      duration: 1200,
      delay: 3800,

      complete: spinMeRev
    });

    // STEP 4
    setTimeout(function(){
      $(".b1-text").append("<br />")
      $(".b1-text").append("&nbsp; <span class='blue'>remote:<span> (8ミ | INFO: Creating app... ")
    }, 5000);


    // STEP 5
    setTimeout(function(){
      $(".load1").addClass("loaded").css({
        transform: "scaleX(1.0) scaleY(1.0)",
      });

      $(".aptible-cloud").addClass("gray");
      $(".load2, .load3").fadeOut(400);
    }, 6000);


    // STEP 6
    setTimeout(function(){
      $(".load-text").fadeOut(400);
      $(".load1-text").fadeIn(1200);
    }, 7000);


    setTimeout(function(){
      animate({
        el: ".public",

        opacity: [0, 1],
        translateY: [20, 0],
        duration: 800,
        easing: "easeOutBack"
      });

      animate({
        el: ".private",

        opacity: [0, 1],
        translateY: [20, 0],
        duration: 800,
        delay: 300,
        easing: "easeOutBack"
      });


    }, 7800);


    setTimeout(function(){
      $(".vpc").addClass("gray");
      $(".load1").addClass("gray");
    }, 8400)

    setTimeout(function(){
      animate({
        el: ".symbol",

        opacity: [0.3, 1],
        translateY: [8, 0],
        duration: 400,
        easing: "easeOutBack"
      });

      animate({
        el: ".logging",

        opacity: [0, 1],
        translateY: [4, 0],
        duration: 800,
        delay: 500,
        easing: "easeOutQuart"
      });
    }, 9800)


    setTimeout(function(){
      animate({
        el: ".logging",

        opacity: [1, 0],
        translateY: [0, -20],
        duration: 400,
        easing: "easeOutQuart"
      });

      animate({
        el: ".compliant",

        opacity: [0, 1],
        translateY: [4, 0],
        duration: 800,
        delay: 300,
        easing: "easeOutQuart"
      });
    }, 11200)

    setTimeout(function(){
      $(".load1").addClass("blue");
    }, 11600)


    setTimeout(function(){
      animate({
        el: "#deploy .console",

        translateY: [10, 0],
        duration: 1200
      });
    }, 13400)

    setTimeout(function(){
      $(".b1-text").append("<br />");
      $(".b1-text").append("&nbsp; <span class='blue'> remote: (8ミ | INFO: test-app created successfully.<span>");
      $(".b1-text").append("<br />$ ");
    }, 14000);
  };


  // Animatrix
  init();
}