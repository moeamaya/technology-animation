#
# techAnimation
#
# Local Object for state management and animation sequences
# Requires jQuery
#
#
class techAnimation

  # Network Animation Object
  # This var gets set during the Gateway animation
  # since it depends on the position and size of
  # <div class="customer-vpc">
  network = null

  #
  # Slide States
  #
  animState = {
    console: false
    http: false
    loadBalancer: false
    app: false
    ssh: false
    bastion: false
    database: false
  }

  # Animation play states
  intro = {
    play: false
    end: false
  }
  infrastructure = {
    play: false
  }


  #
  # Play Animations
  # These animations fire when a user scrolls down
  # and views a slide. Unless statements play
  # only on first viewing
  #
  playIntro = ->
    animate
      el: '.console'
      easing: 'easeOutCirc'
      opacity: [0, 1]
      translateY: [1000, 0]
      duration: 1500
      delay: 100
    unless intro.play
      animate
        el: '.intro-header'
        easing: 'easeOutCirc'
        opacity: [0, 1]
        duration: 1500
        delay: 1600
      animate
        el: '.intro-text'
        easing: 'easeOutQuad'
        opacity: [0, 1]
        duration: 1500
        delay: 1900
      animate
        el: '.primary-header'
        easing: 'easeOutQuad'
        opacity: [0, 1]
        duration: 1000
        delay: 2300
      setTimeout (->
        intro.play = true
        $src = $ '.b1-text'
        Helpers.typeConsole 'aptible apps:create test-app', $src
      ), 2000

  playInfrastructure = ->
    if infrastructure.play

    else
      # disable scrolling until animation finishes
      # borrowed from apple.com/mac-pro
      $.fn.fullpage.setAllowScrolling(false)
      animate
        el: '.fixed-panel'
        easing: 'easeOutQuad'
        opacity: [0, 1]
        translateY: [80, 0]
        duration: 300
        delay: 600
      setTimeout ( -> $('#infrastructure .copy').removeClass('disappear') ), 400
      # STEP1: Bounce in and rotate circles
      animate
        el: '.customer-vpc-dots'
        opacity: [0, 1]
        scaleX: [0.8, 1.0]
        scaleY: [0.8, 1.0]
        duration: 1200
        delay: 1300
      animate
        el: '.loading-circle-1'
        opacity: [0, 1]
        scaleX: [0.8, 1.0]
        scaleY: [0.8, 1.0]
        duration: 1200
        delay: 1400
        complete: (obj) -> $(obj).addClass('rotate-rev')
      animate
        el: '.loading-circle-2'
        opacity: [0, 1]
        scaleX: [0.8, 1.0]
        scaleY: [0.8, 1.0]
        duration: 1200
        delay: 1500
        complete: (obj) -> $(obj).addClass('rotate')
      animate
        el: '.loading-text'
        easing: 'easeOutCirc'
        opacity: [0, 1]
        translateY: [10, 0]
        duration: 600
        delay: 2000
      # STEP2: Circle Transforms into full-size VPC
      setTimeout (->
        $('.loading-circle-1, .loading-circle-2, .loading-text').fadeOut()
        $('.customer-vpc-dots, .customer-vpc').addClass('loaded')
      ), 3000
      setTimeout (->
        $('.aws span.title, aws span.title').css('color', 'rgba(255,255,255,0.1)')
      ), 3600
      # STEP3: Slide in Private Gateway and Pop in labels
      animate
        el: '.private'
        opacity: [0, 1]
        easing: 'easeOutCirc'
        duration: 400,
        delay: 4000
      setTimeout ( -> $('.private').addClass('loaded') ), 4200
      animate
        el: '.public span'
        opacity: [0, 1]
        translateY: [10, 0]
        duration: 1000
        delay: 5400
      animate
        el: '.private span'
        opacity: [0, 1]
        translateY: [10, 0]
        duration: 1000
        delay: 5700
      # STEP3: Fade in
      animate
        el: '.public .left, .public .right'
        easing: 'easeOutCirc'
        opacity: [0, 1]
        duration: 800
        delay: 6500
      animate
        el: '.load-balancer, .app, .bastion, .database'
        easing: 'easeOutCirc'
        opacity: [0, 1]
        duration: 1200
        delay: 7100
      # STEP4: Re-enable scrolling and set played state
      setTimeout ( ->
        $.fn.fullpage.setAllowScrolling(true)
        infrastructure.play = true
      ), 7000

  playGateway = ->
    $('.http, .ssh').addClass('faded')
    setTimeout (-> $('.docker').addClass('faded') ), 100
    if !network
      network = new Network()
      network.generateNetwork()
      network.generateLines()
    else
      $('.network-container').removeClass('disappear')

  playNetwork = ->
    $('.http, .load-balancer').removeClass('faded')

  playApp = ->
    $('.app').removeClass('faded')

  playBastion = ->
    $('.ssh, .bastion').removeClass('faded')

  playDatabase = ->
    $('.database').removeClass('faded')

  playScaling = ->
    $('.load-balancer, .app, .bastion').removeClass('faded')
    setTimeout (-> network.runHalf2() ), 3000


  #
  # Stop the Animations
  # These methods stop animations on DOM objects
  #
  stopIntro: ->
    animate.stop '.console'


  #
  # Leave Animations
  # These animations fire when a user scrolls down
  # and views the next slide below
  #
  leaveIntro = ->
    animate
      el: '.console'
      easing: 'easeOutQuad'
      translateY: [0, 50]
      opacity: [1, 0]
      duration: 400
    if infrastructure.play
      animate
        el: ".fixed-panel"
        easing: "easeOutQuad"
        opacity: [0, 1]
        duration: 800

  leaveInfrastructure = ->
    $('#infrastructure .copy').addClass('disappear')

  leaveGateway = ->
    $('#gateway .copy').addClass('disappear')
    network.runHttp()

  leaveNetwork = ->
    $('#network .copy').addClass('disappear')
    $('.http, .load-balancer').addClass('faded')
    network.stop()

  leaveApp = ->
    $('#code .copy').addClass('disappear')
    $('.app').addClass('faded')
    network.runSSH()

  leaveBastion = ->
    $('#bastion .copy').addClass('disappear')
    $('.bastion').addClass('faded')
    $('.ssh').addClass('faded')
    network.stop()

  leaveDatabase = ->
    $('#database .copy').addClass('disappear')
    network.runHalf()

  leaveScaling = ->


  #
  # LeaveUp Animations
  # These animations fire when before a user scrolls up
  # and views the next slide above
  #

  leaveUpInfrastructure = ->
    animate
      el: ".fixed-panel"
      easing: "easeOutQuad"
      opacity: [1, 0]
      duration: 300

  leaveUpGateway = ->
    setTimeout (-> $('#infrastructure .copy').removeClass('disappear') ), 500
    $('.http, .ssh, .load-balancer, .app, .bastion, .database').removeClass('faded')
    $('.network-container').addClass('disappear')


  leaveUpNetwork = ->
    setTimeout (-> $('#gateway .copy').removeClass('disappear') ), 500
    $('.http, .load-balancer').addClass('faded')
    network.stop()

  leaveUpApp = ->
    setTimeout (-> $('#network .copy').removeClass('disappear') ), 500
    $('.app').addClass('faded')
    network.runHttp()

  leaveUpBastion = ->
    setTimeout (-> $('#code .copy').removeClass('disappear') ), 500
    $('.bastion').addClass('faded')
    $('.ssh').addClass('faded')
    network.stop()

  leaveUpDatabase = ->
    setTimeout (-> $('#bastion .copy').removeClass('disappear') ), 500
    $('.database').addClass('faded')
    network.runSSH()

  leaveUpScaling = ->
    setTimeout (-> $('#database .copy').removeClass('disappear') ), 500
    $('.http, .ssh, .load-balancer, .app, .bastion').addClass('faded')
    network.stop()

  #
  # Back Animations
  # These animations fire when a user scrolls up
  # and views the next slide above
  #



  #
  # Click Animations
  # These animations fire when a user clicks
  # the navigations dots to jump to a slide
  #



  #
  # Animation arrays
  # fullPage.js uses index values to determine
  # its current slide position which corresponds
  # to these immutable arrays
  #
  play: [playIntro, playInfrastructure, playGateway, playNetwork, playApp, playBastion, playDatabase, playScaling]
  leave: [leaveIntro, leaveInfrastructure, leaveGateway, leaveNetwork, leaveApp, leaveBastion, leaveDatabase, leaveScaling]
  leaveUp: [leaveUpInfrastructure, leaveUpGateway, leaveUpNetwork, leaveUpApp, leaveUpBastion, leaveUpDatabase, leaveUpScaling]




