animIntro = function(){
  animate({
    el: ".console",

    easing: "easeOutCirc",
    opacity: [0, 1],
    translateY: [1000, 0],
    duration: 1500,
    delay: 100
  });


  animate({
    el: ".intro-header",

    easing: "easeOutQuad",
    opacity: [0, 1],
    duration: 1500,
    delay: 1600
  });


  animate({
    el: ".intro-text",

    easing: "easeOutQuad",
    opacity: [0, 1],
    duration: 1500,
    delay: 1900
  });


  animate({
    el: ".primary-header",

    easing: "easeOutQuad",
    opacity: [0, 1],
    duration: 1000,
    delay: 2300
  });

  setTimeout(function(){
    var $src = $(".b1-text");
    Helpers.typeConsole("aptible apps:create test-app", $src);
  }, 2400);
};