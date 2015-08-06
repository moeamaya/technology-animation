var Helpers = {
  staggerType: function(char, $src, delay){
    setTimeout(function(){
      $src.append(char)
    }, delay);
  },

  typeConsole: function(str, $src){
    var max = 80;
    var min = 0;

    for(var i = 0; i < str.length; i++){
      var delay = Math.floor(Math.random() * (max - min)) + min + (i * max);
      this.staggerType(str[i], $src, delay)
    };
  }

};