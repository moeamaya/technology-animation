var Helpers = {


  // input a min and max range in seconds ie (1, 10)
  // returns a random time value in milliseconds
  randomTime: function(min, max){
    return ( Math.random() * (max - min) + min ) * 1000;
  }

};
