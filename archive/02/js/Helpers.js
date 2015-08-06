var Helpers = {
  staggerType: function(char, $src, delay){
    setTimeout(function(){
      $src.append(char)
    }, delay);
  },

  // appends a string to a jQuery objects
  // in a randomized typing like fashion
  typeConsole: function(str, $src){
    var max = 80;
    var min = 0;

    for(var i = 0; i < str.length; i++){
      var delay = Math.floor(Math.random() * (max - min)) + min + (i * max);
      this.staggerType(str[i], $src, delay)
    };
  },

  // input a min and max range in seconds ie (1, 10)
  // returns a random time value in milliseconds
  randomTime: function(min, max){
    return ( Math.random() * (max - min) + min ) * 1000;
  }

};