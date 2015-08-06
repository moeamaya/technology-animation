var Network = function(){
  var self = Object.create(Network.prototype);

  var OFFSET = 40; // in pixels, inner-offset from vpc box
  var SPACING = 26; // 20px spacing between network lines

  var httpLines = [];
  var sshLines = [];
  var allLines = [];

  var $vpc = $(".customer-vpc");
  var vpcPosition = $vpc.offset();
  var vpcTop = Math.floor(vpcPosition.top);
  var vpcLeft = Math.floor(vpcPosition.left) + (OFFSET/2);
  var vpcWidth = $vpc.outerWidth() - OFFSET;

  var numLines = Math.floor(vpcWidth / SPACING);
  var halfLines = numLines / 2;


  var $networkContainer = $("<div class='network-container'>")
    .css({
      height: vpcTop + "px",
      width: vpcWidth,
      left: vpcLeft + "px"
    });

  $("body").append($networkContainer);



  // -------------------------------
  // Public methods
  // -------------------------------


  self.generateLines = function(){
    for (var i = 0; i < numLines; i++) {
      var yPos = i * SPACING;

      if (i < halfLines){
        var lineObj = new NetworkLine(yPos, "left");
        httpLines.push(lineObj);
      } else {
        var lineObj = new NetworkLine(yPos, "right");
        sshLines.push(lineObj);
      }

      allLines = httpLines.concat(sshLines);
      var line = lineObj.getDOMObject();
      $networkContainer.append(line);
    };
  };


  self.runHttp = function(){
    for (var i = 0; i < httpLines.length; i++){
      if (i % 2 == 0){
        httpLines[i].startActivity();
      }
    };
  };


  self.runSSH = function(){
    for (var i = 0; i < sshLines.length; i++){
      if (i != 0 && i % 2 == 0){
        sshLines[i].startActivity();
      }
    };
  };

  self.runHalf = function(){
    for (var i = 0; i < allLines.length; i++){
      if (i % 2 == 0){
        allLines[i].startActivity();
      }
    };
  }


  self.runHalf2 = function(){
    for (var i = 0; i < allLines.length; i++){
      if (i % 2 != 0){
        allLines[i].startActivity();
      }
    };
  };


  self.stop = function(){
    for (var i = 0; i < allLines.length; i++){
      allLines[i].stopActivity();
    };
  };


  return self;
}




var NetworkLine = function(yPos, klass){
  var self = Object.create(NetworkLine.prototype);

  var start = null;
  var startTime = Helpers.randomTime(0, 3);

  //
  var $dot;
  var $active;
  var $line;
  var animating;

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
    showActive();
    runActivity();
  };


  self.stopActivity = function(){
    destroyActivity();
  };


  init();
  return self;
};


