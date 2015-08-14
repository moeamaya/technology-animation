

var NetworkLine = function(yPos, klass){
  var self = Object.create(NetworkLine.prototype);

  var start = null;
  var startTime = null;

  //
  var $dot;
  var $active;
  var $line;
  var animating;

  // input a min and max range in seconds ie (1, 10)
  // returns a random time value in milliseconds
  var randomTime = function(min, max){
    return ( Math.random() * (max - min) + min ) * 1000;
  };


  //
  var step =  function(timestamp){
    if(!start) start = timestamp;
    var progress = timestamp - start;

    var stepping = Math.min(progress/20, 96);

    $active.css("transform", "scaleY(" + stepping/100 + ")");
    $dot.css("top", stepping + "%");

    if (progress < 2000){
      animating = window.requestAnimationFrame(step);
    } else {
      resetActivity();
      animating = window.requestAnimationFrame(step);
    }
  };


  var init = function(){
    $line = $("<div class='network-line " + klass + "'>").css({
      left: yPos + "px"
    });
    startTime = randomTime(0, 3);
    createActive();
  };


  var createActive = function(){
    $active = $("<div class='active'>");
    $dot = $("<div class='dot'>");
    $line.append($active).append($dot);
  };


  var resetActivity = function(){
    $active.css("transform", "scaleY(0)");
    $dot.css("top", "0%");
    start = null;
  };


  //
  var runActivity = function(){
    showActive();

    setTimeout(function(){
      animating = window.requestAnimationFrame(step);
    }, startTime);
  };


  var destroyActivity = function(){
    hideActive();
    setTimeout(function(){
      window.cancelAnimationFrame(animating);
      animating = null;
      resetActivity();
    }, 600);
  };


  var showActive = function(){
    animate({
      el: $dot,
      easing: "easeOutCirc",
      opacity: [0, 1],
      duration: 600,
    });
    animate({
      el: $active,
      easing: "easeOutCirc",
      opacity: [0, 1],
      duration: 600,
    });
  };


  var hideActive = function(){
    animate({
      el: $dot,
      easing: "easeOutCirc",
      opacity: [1, 0],
      duration: 600,
    });
    animate({
      el: $active,
      easing: "easeOutCirc",
      opacity: [1, 0],
      duration: 600,
    });
  }


  // -------------------------------
  // Public methods
  // -------------------------------


  self.getDOMObject = function(){
    return $line;
  };


  self.startActivity = function(){
    runActivity();
  };


  self.stopActivity = function(){
    destroyActivity();
  };


  init();
  return self;
};
