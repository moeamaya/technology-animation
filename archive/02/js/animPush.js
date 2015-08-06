animPush = function(){
  var $src = $(".b1-text");
  $src.append("<br>$ ")

  animate({
    el: ".fixed-panel",

    easing: "easeOutCirc",
    opacity: [1, 0.1],
    duration: 600
  });


  animate({
    el: ".network-container",

    easing: "easeOutCirc",
    opacity: [1, 0.1],
    duration: 600
  });



  animate({
    el: ".console",

    easing: "easeOutCirc",
    opacity: [0, 1],
    translateY: [300, 0],
    duration: 800,

    // delay: 100
  });

  setTimeout(function(){
    Helpers.typeConsole("git push aptible master", $src);
  }, 1400);



};