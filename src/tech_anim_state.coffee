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


  # Slide States
  #
  intro = {
    visible: false
    state: false
    play: false
    leave: false
    end: false
  }
  infrastructure = {
    play: false
  }

  #
  # Play Animations
  # These animations fire when a user scrolls down
  # and views a slide for the first time
  #
  playIntro = ->
    animate
      el: '.console'
      easing: 'easeOutCirc'
      opacity: [0, 1]
      translateY: [1000, 0]
      duration: 1500
      delay: 100
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
      $src = $ '.b1-text'
      Helpers.typeConsole 'aptible apps:create test-app', $src
    ), 2000

  playGateway = ->
    $('.http, .ssh').addClass('faded')
    setTimeout (-> $('.docker').addClass('faded') ), 100
    network = new Network()
    network.generateNetwork()
    network.generateLines()

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

  stopIntro: ->
    animate.stop '.console'


  #
  # Leave Animations
  # These animations fire when a user scrolls down
  # and views the next slide below
  #
  leaveIntro = ->
    unless intro.leave
      animate
        el: '.console'
        easing: 'easeOutQuad'
        translateY: [0, 50]
        opacity: [1, 0]
        duration: 400
        begin: ->
          intro.leave = true

  leaveInfrastructure = ->
    $('#infrastructure .copy').fadeOut(150)

  leaveGateway = ->
    $('#gateway .copy').fadeOut(150)
    network.runHttp()

  leaveNetwork = ->
    $('#network .copy').fadeOut(150)
    $('.http, .load-balancer').addClass('faded')
    network.stop()

  leaveApp = ->
    $('#code .copy').fadeOut(150)
    $('.app').addClass('faded')
    network.runSSH()

  leaveBastion = ->
    $('#bastion .copy').fadeOut(150)
    $('.bastion').addClass('faded')
    $('.ssh').addClass('faded')
    network.stop()

  leaveDatabase = ->
    $('#database .copy').fadeOut(150)
    network.runHalf()

  leaveScaling = ->


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
  play: [playIntro, animInfrastructure, playGateway, playNetwork, playApp, playBastion, playDatabase, playScaling]
  leave: [leaveIntro, leaveInfrastructure, leaveGateway, leaveNetwork, leaveApp, leaveBastion, leaveDatabase, leaveScaling]



