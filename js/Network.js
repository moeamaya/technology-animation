var Network = function(){
  var self = Object.create(Network.prototype);

  var OFFSET = 32; // in pixels, inner-offset from vpc box
  var SPACING = 16; // spacing between network lines

  var $networkContainer;

  var httpLines = [];
  var sshLines = [];
  var allLines = [];

  var $vpc = $(".customer-vpc");
  var vpcPosition = $vpc.offset();
  var vpcTop = Math.floor(vpcPosition.top);
  var vpcLeft = Math.floor(vpcPosition.left) + (OFFSET/2);
  var vpcWidth = $vpc.outerWidth() - OFFSET;

  var numLines = Math.ceil(vpcWidth / SPACING);
  var halfLines = Math.ceil(numLines * 0.7);



  var regenerateNetwork = function() {
    destroyNetwork();

    vpcPosition = $vpc.offset();
    vpcTop = Math.floor(vpcPosition.top);
    vpcLeft = Math.floor(vpcPosition.left) + (OFFSET/2);
    vpcWidth = $vpc.outerWidth() - OFFSET;

    numLines = Math.ceil(vpcWidth / SPACING);
    halfLines = Math.ceil(numLines * 0.7);

    $networkContainer
      .css({
        height: vpcTop + "px",
        width: vpcWidth,
        left: vpcLeft + "px"
      });

    self.generateLines();
  };


  var destroyNetwork = function(){
    for (var i = 0; i < allLines.length; i++){
      allLines[i].getDOMObject().remove();
      delete allLines[i];
    };
    httpLines = [];
    sshLines = [];
    allLines = [];
  };



  $(window).resize(function(){
    regenerateNetwork();
  });


  // -------------------------------
  // Public methods
  // -------------------------------


  self.generateNetwork = function(){
    $networkContainer = $("<div class='network-container'>")
      .css({
        height: vpcTop + "px",
        width: vpcWidth,
        left: vpcLeft + "px"
      });

    $("body").append($networkContainer);
  };


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




