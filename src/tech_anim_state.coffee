#
# techAnimation
#
# Local Object for state management and formatting helpers for that state.
# Requires jQuery, broadcasts update events on $(document)
# DOM controls (links, inputs) update this object
#
class techAnimation
  intro = {
    visible: false
    state: false
    play: false
    leave: false
    end: false
  }

  playIntro = ->
    unless intro.play
      animate
        el: '.console'
        easing: 'easeOutCirc'
        opacity: [0, 1]
        translateY: [1000, 0]
        duration: 500
        delay: 100
        begin: ->
          intro.play = true
        complete: ->
          intro.end = true

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



  play: [animIntro, animInfrastructure, animGateway, animNetwork, playApp, playBastion, playDatabase, playScaling]
  leave: [leaveIntro, leaveInfrastructure, leaveGateway, leaveNetwork, leaveApp, leaveBastion, leaveDatabase, leaveScaling]



