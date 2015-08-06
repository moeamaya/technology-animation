#
# techAnimation
#
# Local Object for state management and animation sequences
# Requires jQuery
#
#
class techAnimation

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
    unless intro.play
      animate
        el: '.console'
        easing: 'easeOutCirc'
        opacity: [0, 1]
        translateY: [1000, 0]
        duration: 1500
        delay: 100
        begin: ->
          intro.play = true
        complete: ->
          intro.end = true

  playGateway = ->
    $('.http, .ssh').addClass('faded')
    setTimeout (-> $('.docker').addClass('faded') ), 300

  playApp = ->
    $('.app').removeClass('faded')

  playBastion = ->
    $('.ssh').removeClass('faded')
    $('.bastion').removeClass('faded')

  playDatabase = ->
    $('.database').removeClass('faded')

  playScaling = ->
    $('.load-balancer, .app, .bastion').removeClass('faded')
    window.network.runHalf()
    setTimeout (-> window.network.runHalf2() ), 3000

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

  leaveNetwork = ->
    $('#network .copy').fadeOut(150)
    $('.public .http').addClass('faded')
    $('.load-balancer').addClass('faded')
    window.network.stop()

  leaveApp = ->
    $('#code .copy').fadeOut(150)
    $('.app').addClass('faded')
    window.network.runSSH()

  leaveBastion = ->
    $('#bastion .copy').fadeOut(150)
    $('.bastion').addClass('faded')
    $('.ssh').addClass('faded')
    window.network.stop()

  leaveDatabase = ->
    $('#database .copy').fadeOut(150)

  leaveScaling = ->

  #
  # Back Animations
  # These animations fire when a user scrolls up
  # and views the next slide above
  #

  #
  # Click Animations
  #

  #
  # Animation arrays
  # fullPage.js uses index values to determine
  # it's current slide position which corresponds
  # to these immutable arrays
  #
  play: [animIntro, animInfrastructure, playGateway, animNetwork, playApp, playBastion, playDatabase, playScaling]
  leave: [leaveIntro, leaveInfrastructure, leaveGateway, leaveNetwork, leaveApp, leaveBastion, leaveDatabase, leaveScaling]



