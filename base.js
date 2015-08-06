
$('.slides').fullpage({
  'verticalCentered': false,
  'css3': true,
  'navigation': true,
  'navigationPosition': 'left',
  'navigationTooltips': ['Create', 'Infrastructure', 'Gateway', 'Push', 'Code', 'Database', 'Network', 'Scale'],

  'afterLoad': function(anchorLink, index){
    if (index == 1) {
      animIntro();
    }

    if (index == 2){
      animInfrastructure();
    }

    if (index == 3){
      animGateway();
    }

    if (index == 4){
      animPush();
    }

    if (index == 5){
      animNetwork();
    }

    if (index == 6){
      $(".docker").removeClass("active");
      $(".app").addClass("active");
    }

    if (index == 7){
      $(".docker").removeClass("active");
      network.runSSH();

      setTimeout(function(){
        $(".bastion").addClass("active");
        $(".public .ssh").css("color", "rgba(255, 255, 255, 1)");
      }, 400);
    }

    if (index == 8){
      $(".docker").removeClass("active");
      $(".database").addClass("active");
    }

    if (index == 9){
      network.runHalf();

      $(".docker").removeClass("active");
      $(".app").addClass("active");
      $(".database").addClass("active");

      setTimeout(function(){
        network.runHalf2();
      }, 3200)
    }

    if (index == 10){
      $(".public .http").css("color", "rgba(255, 255, 255, 1)");
      $(".public .ssh").css("color", "rgba(255, 255, 255, 1)");

      $(".aws span.title").css("color", "rgba(255,255,255,0.5)");
      $(".aptible-cloud span.title").css("color", "rgba(255,255,255,0.5)");

      $(".load-balancer").addClass("active");
      $(".bastion").addClass("active");
    }
  },

  'onLeave': function(index, nextIndex, direction){
    if (index == 1 && direction == "down") {
      animate({
        el: ".console",

        easing: "easeOutQuad",
        translateY: [0, 50],
        opacity: [1, 0],
        duration: 400
      });
    };

    if (index == 2 && direction == "down") {
      $("#infrastructure .copy").fadeOut(150);

      animate({
        el: ".loaded-text",

        easing: "easeOutQuad",
        translateY: [0, -20],
        opacity: [1, 0],
        duration: 400
      });
    };

    if (index == 3 && direction == "down") {
      $("#gateway .copy").fadeOut(150);
    };

    if (index == 4 && direction == "down") {
      // console pops up in this slide
      animate({
        el: ".console",

        easing: "easeOutQuad",
        translateY: [0, 50],
        opacity: [1, 0],
        duration: 400
      });
   }

    if (index == 5 && direction == "down") {
      $("#network .copy").fadeOut(150);
      $(".public .http").css("color", "rgba(255, 255, 255, 0.2)");
      network.stop();
    };

    if (index == 6 && direction == "down") {
      $("#code .copy").fadeOut(150);
    };

    if (index == 7 && direction == "down") {
      $("#bastion .copy").fadeOut(150);
      $(".public .ssh").css("color", "rgba(255, 255, 255, 0.2)");
      network.stop();
    };

    if (index == 8 && direction == "down") {
      $("#database .copy").fadeOut(150);
    }

    if (index == 9 && direction == "down") {
      $("#scale .copy").fadeOut(150);
      $(".network-container").fadeOut(150);

      network.stop();
    }
  },

  // Show page after fullpage.js initializes
  'afterRender': function(){
    $(".slides").css('opacity', 1);
  }

})