var workAnim = function() {


  var init = function(){

    // STEP 1
    setTimeout(function(){
      $("#work .console").css("box-shadow", "0 1px 6px rgba(0, 0, 0, 0.9)");
    }, 100);


    // STEP 2
    setTimeout(function(){
      animate({
        el: "#work .python",

        opacity: [0, 0.5],
        translateY: [30, 0],
        duration: 800,
        easing: "easeOutQuart"
      });

      animate({
        el: "#work .ruby",

        opacity: [0, 0.5],
        translateY: [30, 0],
        duration: 800,
        delay: 300,
        easing: "easeOutQuart"
      });

      animate({
        el: "#work .node",

        opacity: [0, 0.5],
        translateY: [30, 0],
        duration: 800,
        delay: 600,
        easing: "easeOutQuart"
      });
    }, 500);

    setTimeout(function(){
      animate({
        el: "#work .console",

        translateY: [40, 0],
        duration: 1200
      });
    }, 1800);


    // STEP 2
    setTimeout(function(){
      var $src = $(".b2-text");
      Helpers.typeConsole("rails new", $src);
    }, 2800);


    setTimeout(function(){
      animate({
        el: "#work .ruby",

        opacity: [0.5, 1],
        translateY: [10, 0],
        duration: 1000,
        // easing: "easeOutQuart"
      });

      animate({
        el: "#work .python",

        opacity: [0.5, 0.1],
        // translateY: [0, 20],
        duration: 800,
        delay: 300,
        easing: "easeOutQuart"
      });

      animate({
        el: "#work .node",

        opacity: [0.5, 0.1],
        // translateY: [0, 20],
        duration: 800,
        delay: 500,
        easing: "easeOutQuart"
      });
    }, 4000);


    setTimeout(function(){
      animate({
        el: "#work .web",

        translateY: [0, -100],
        duration: 800,
        easing: "easeOutQuart"
      });
    }, 5500)



    setTimeout(function(){
      animate({
        el: "#work .postgres",

        opacity: [0, 0.5],
        translateY: [20, 0],
        duration: 800,
        easing: "easeOutQuart"
      });

      animate({
        el: "#work .mysql",

        opacity: [0, 0.5],
        translateY: [20, 0],
        duration: 800,
        delay: 300,
        easing: "easeOutQuart"
      });

      animate({
        el: "#work .mongodb",

        opacity: [0, 0.5],
        translateY: [20, 0],
        duration: 800,
        delay: 500,
        easing: "easeOutQuart"
      });
    }, 6000);


    setTimeout(function(){
      var $src = $(".b2-text");
      $src.append("<br />$");
      $src.append(" ");
      Helpers.typeConsole("createdb test-app-dev", $src);
    }, 8000);


    setTimeout(function(){
      animate({
        el: "#work .postgres",

        opacity: [0.5, 1],
        translateY: [20, 0],
        duration: 800,
        // easing: "easeOutQuart"
      });

      animate({
        el: "#work .mysql",

        opacity: [0.5, 0.1],
        // translateY: [20, 0],
        duration: 800,
        delay: 300,
        easing: "easeOutQuart"
      });

      animate({
        el: "#work .mongodb",

        opacity: [0.5, 0.1],
        // translateY: [20, 0],
        duration: 800,
        delay: 500,
        easing: "easeOutQuart"
      });
    }, 10000);




    setTimeout(function(){
      var $src = $(".b2-text");
      $src.append("<br />$");
      $src.append(" ");
      Helpers.typeConsole("git add -am 'first commit' ", $src);
    }, 12600);


    setTimeout(function(){
      var $src = $(".b2-text");
      $src.append("<br />$");
      $src.append(" ");
      Helpers.typeConsole("git push aptible master", $src);
    }, 15000);

  }


  // Animatrix
  init();
};