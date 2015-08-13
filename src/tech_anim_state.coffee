#
# techAnimation
#
# Animation sequences
# Four different animations depending on user behavior
#
# play: runs when a slide is in view and ready
# leave: runs before a slide transitions on scroll down
# leaveUp: runs before a slide transtions on scroll up
# click: runs when a user clicks the navigation dots
#

class techAnimation


  awsTitle = $ '.aws .title'
  aptibleTitle = $ '.aptible-cloud .title'

  fixedDiagram = $ '.fixed-diagram'



  # Network Animation Object
  # This var gets set during the Gateway animation or if a
  # user clicks navigation dots since it depends on the position
  # and size of <div class="customer-vpc">
  network = null


  # Animation play states
  intro = {
    played: false
  }
  infrastructure = {
    played: false
    copyAnim: null
    circleAnim: null
    privateAnim: null
  }
  scaling = {
    half2: null
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
    setTimeout (-> $('#intro .copy').removeClass('disappear')), 300
    unless intro.played
      intro.played = true
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
        Helpers.typeConsole 'aptible account:create', $src
      ), 2000

  playInfrastructure = ->
    if infrastructure.played
      $('.load-balancer, .app, .bastion, .database').removeClass('faded')
      $('.network-container').addClass('disappear')
      $('#infrastructure .copy').removeClass('disappear')
      $('.aws span.title').css('color', 'rgba(255,255,255,0.3)')
    else
      # disable scrolling until animation finishes
      # borrowed from apple.com/mac-pro
      animate
        el: fixedDiagram
        easing: 'easeOutQuad'
        opacity: [0, 1]
        translateY: [80, 0]
        duration: 300
        delay: 600
      infrastructure.copyAnim = setTimeout ( ->
        $('#infrastructure .copy').removeClass('disappear')
      ), 400
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
      infrastructure.circleAnim = setTimeout (->
        $('.loading-circle-1, .loading-circle-2, .loading-text').fadeOut()
        $('.customer-vpc-dots, .customer-vpc').addClass('loaded')
      ), 3000
      setTimeout (->
        $('.aws span.title').css('color', 'rgba(255,255,255,0.3)')
      ), 3600
      # STEP3: Slide in Private Gateway and Pop in labels
      animate
        el: '.private'
        opacity: [0, 1]
        easing: 'easeOutCirc'
        duration: 400,
        delay: 4000
      infrastructure.privateAnim = setTimeout ( -> $('.private').addClass('loaded') ), 4200
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
      infrastructure.finalAnim = setTimeout ( ->
        infrastructure.played = true
      ), 7000

  playGateway = ->
    $('.http, .ssh').addClass('faded')
    setTimeout (-> $('.docker').addClass('faded') ), 100
    $('#network .copy').removeClass('disappear')
    if !network
      network = new Network()
      network.generateNetwork()
      network.generateLines()
    else
      $('.network-container').removeClass('disappear')

  playNetwork = ->
    $('.http, .load-balancer').removeClass('faded')
    $('#load-balancing .copy').removeClass('disappear')

  playApp = ->
    $('.app').removeClass('faded')
    $('#apps .copy').removeClass('disappear')

  playBastion = ->
    $('.ssh, .bastion').removeClass('faded')
    $('#bastion .copy').removeClass('disappear')

  playDatabase = ->
    $('.database').removeClass('faded')
    $('#database .copy').removeClass('disappear')

  playScaling = ->
    $('.load-balancer, .app, .bastion, .database').removeClass('faded')
    $('#scale .copy').removeClass('disappear')
    scaling.half2 = setTimeout (-> network.runHalf2() ), 3000

  playSignup = ->
    $('.load-balancer, .app, .bastion, .database').removeClass('faded')
    $('#signup .copy').removeClass('disappear')

  #
  # Leave Animations
  # These animations fire when a user scrolls down
  # and views the next slide below
  #
  leaveIntro = ->
    animate.stop('.console')
    animate
      el: '.console'
      easing: 'easeOutQuad'
      translateY: [0, 50]
      opacity: [1, 0]
      duration: 400
      delay: 50
    if infrastructure.played
      fixedDiagram.fadeIn(50)
      animate
        el: fixedDiagram
        easing: "easeOutQuad"
        opacity: [0, 1]
        duration: 800

  leaveInfrastructure = ->
    $('#infrastructure .copy').addClass('disappear')
    unless infrastructure.played
      fixedDiagram.fadeOut(50)
      stopInfrastructure()
      clickReset()
      if !network
        setTimeout (->
          finalInfrastructureState()
        ), 100

  leaveGateway = ->
    $('#network .copy').addClass('disappear')
    network.runHttp()

  leaveNetwork = ->
    $('#load-balancing .copy').addClass('disappear')
    $('.http, .load-balancer').addClass('faded')
    network.stop()

  leaveApp = ->
    $('#apps .copy').addClass('disappear')
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
    $('#scale .copy').addClass('disappear')
    clearTimeout scaling.half2
    network.stop()

  #
  # LeaveUp Animations
  # These animations fire when before a user scrolls up
  # and views the next slide above
  #
  leaveUpInfrastructure = ->
    animate
      el: fixedDiagram
      easing: "easeOutQuad"
      opacity: [1, 0]
      duration: 300
    setTimeout ( -> $('.fixed-console').fadeIn() ), 800

    $('#infrastructure .copy').addClass('disappear')
    unless infrastructure.played
      fixedDiagram.fadeOut(50)
      stopInfrastructure()
      clickReset()
      if !network
        setTimeout (->
          finalInfrastructureState(false)
        ), 100


  leaveUpGateway = ->
    setTimeout (-> $('#infrastructure .copy').removeClass('disappear') ), 500
    $('.http, .ssh, .load-balancer, .app, .bastion, .database').removeClass('faded')

  leaveUpNetwork = ->
    setTimeout (-> $('#network .copy').removeClass('disappear') ), 500
    $('.http, .load-balancer').addClass('faded')
    network.stop()

  leaveUpApp = ->
    setTimeout (-> $('#load-balancing .copy').removeClass('disappear') ), 500
    $('.app').addClass('faded')
    network.runHttp()

  leaveUpBastion = ->
    setTimeout (-> $('#apps .copy').removeClass('disappear') ), 500
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
    clearTimeout scaling.half2
    network.stop()

  leaveUpSignup = ->
    setTimeout (-> $('#scale .copy').removeClass('disappear') ), 500
    network.stop()

  #
  # If diagram animation hasn't finished
  # this will fast forward the DOM to the correct state
  # **Only used by the click handlers
  #
  finalInfrastructureState = (show = true) ->

    # Full size customer vpc
    $('.customer-vpc-dots, .customer-vpc').css(
      transition: 'all 50ms linear'
      opacity: 1
      ).addClass('loaded')

    # Fade out AWS and Aptible Cloud labels
    $('.aws span.title, aws span.title').css('color', 'rgba(255,255,255,0.3)')

    # Full width private gateway
    $('.private').css(
      transition: 'all 50ms linear'
      opacity: 1
      ).addClass('loaded')

    # Gatway labels
    $('.public span, .private span').css('opacity', 1)
    $('.public .left, .public .right').css('opacity', 1)

    $('.load-balancer, .app, .bastion, .database').css('opacity', 1).addClass('faded')

    animate
      el: fixedDiagram
      easing: 'easeOutQuad'
      opacity: [0, 1]
      duration: 300
      delay: 100

    setTimeout (->
      if show
        fixedDiagram.fadeIn()
      $('.slides').fadeIn()
      infrastructure.played = true
      createNetwork()
    ), 500



  createNetwork = ->
    if !network
      network = new Network()
      network.generateNetwork()
      network.generateLines()

  stopInfrastructure = ->
    animate.stop('.console')
    animate.stop('.fixed-diagram')
    animate.stop('.customer-vpc-dots')
    animate.stop('.loading-circle-1')
    animate.stop('.loading-circle-2')
    animate.stop('.loading-text')
    animate.stop('.private')
    animate.stop('.public span')
    animate.stop('.private span')
    animate.stop('.public .left, .public .right')
    animate.stop('.load-balancer, .app, .bastion, .database')

    clearTimeout infrastructure.copyAnim
    clearTimeout infrastructure.circleAnim
    clearTimeout infrastructure.privateAnim

    setTimeout (->
      $('.loading-circle-1, .loading-circle-2, .loading-text').hide()
      $('.diagram span.title').css('color', 'rgba(255,255,255,0.3)')
      infrastructure.played = true
    ), 500


  clickReset = ->
    stopInfrastructure()
    $('.copy').addClass('disappear')


  #
  # Click Animations
  # These animations fire when a user clicks
  # the navigations dots to jump to a slide
  #
  clickIntro = ->
    clickReset()
    if !network
      setTimeout (->
        finalInfrastructureState()
      ), 100
    else
      clearTimeout scaling.half2
      network.stop()
      animate
        el: fixedDiagram
        easing: "easeOutQuad"
        opacity: [1, 0]
        duration: 50
      $('.network-container').addClass('disappear')


      setTimeout (->
        $('.slides, .fixed-console, .network-container').fadeIn()
        fixedDiagram.fadeIn()
      ), 1000

      $('.load-balancer, .app, .bastion, .database').css('opacity', 1).addClass('faded')

  clickInfrastructure = ->
    clickReset()
    if !network
      setTimeout (->
        finalInfrastructureState()
      ), 100
    else
      clearTimeout scaling.half2
      network.stop()
      animate
        el: fixedDiagram
        easing: "easeOutQuad"
        opacity: [0, 1]
        duration: 50
      $('.network-container').addClass('disappear')


      setTimeout (->
        $('.slides, .network-container').fadeIn()
        fixedDiagram.fadeIn()
      ), 1000


      $('.load-balancer, .app, .bastion, .database').css('opacity', 1).addClass('faded')

  clickGateway = ->
    clickReset()
    if !network
      setTimeout (->
        finalInfrastructureState()
      ), 100
    else
      clearTimeout scaling.half2
      network.stop()
      animate
        el: fixedDiagram
        easing: "easeOutQuad"
        opacity: [0, 1]
        duration: 50
      $('.network-container').removeClass('disappear')

      setTimeout (->
        $('.slides, .network-container').fadeIn()
        fixedDiagram.fadeIn()
      ), 1000

      $('.load-balancer, .app, .bastion, .database').css('opacity', 1).addClass('faded')

  clickNetwork = ->
    clickReset()
    if !network
      setTimeout (->
        finalInfrastructureState()
      ), 100
      setTimeout (->  network.runHttp() ), 800
    else
      clearTimeout scaling.half2
      network.stop()
      animate
        el: fixedDiagram
        easing: "easeOutQuad"
        opacity: [0, 1]
        duration: 50
      $('.network-container').removeClass('disappear')

      setTimeout (->
        $('.slides, .network-container').fadeIn()
        fixedDiagram.fadeIn()
        network.runHttp()
      ), 1000


      $('.load-balancer, .app, .bastion, .database').css('opacity', 1).addClass('faded')

  clickApp = ->
    clickReset()
    if !network
      setTimeout (->
        finalInfrastructureState()
      ), 100
    else
      clearTimeout scaling.half2
      network.stop()
      animate
        el: fixedDiagram
        easing: "easeOutQuad"
        opacity: [0, 1]
        duration: 50
      $('.network-container').removeClass('disappear')


      setTimeout (->
        $('.slides, .network-container').fadeIn()
        fixedDiagram.fadeIn()
      ), 1000

      $('.load-balancer, .app, .bastion, .database').css('opacity', 1).addClass('faded')

  clickBastion = ->
    clickReset()
    if !network
      setTimeout (->
        finalInfrastructureState()
      ), 100
      setTimeout (->  network.runSSH() ), 800
    else
      clearTimeout scaling.half2
      network.stop()
      animate
        el: fixedDiagram
        easing: "easeOutQuad"
        opacity: [0, 1]
        duration: 50
      $('.network-container').removeClass('disappear')

      setTimeout (->
        $('.slides, .network-container').fadeIn()
        fixedDiagram.fadeIn()
        network.runSSH()
      ), 1000

      $('.load-balancer, .app, .bastion, .database').css('opacity', 1).addClass('faded')

  clickDatabse = ->
    clickReset()
    if !network
      setTimeout (->
        finalInfrastructureState()
      ), 100
    else
      clearTimeout scaling.half2
      network.stop()
      animate
        el: fixedDiagram
        easing: "easeOutQuad"
        opacity: [0, 1]
        duration: 50
      $('.network-container').removeClass('disappear')
      setTimeout (->
        $('.slides, .network-container').fadeIn()
        fixedDiagram.fadeIn()
      ), 1000

      $('.load-balancer, .app, .bastion, .database').css('opacity', 1).addClass('faded')

  clickScaling = ->
    clickReset()
    if !network
      setTimeout (->
        finalInfrastructureState()
      ), 100
    else
      network.stop()
      animate
        el: fixedDiagram
        easing: "easeOutQuad"
        opacity: [0, 1]
        duration: 50
      $('.network-container').removeClass('disappear')


      $('.load-balancer, .app, .bastion, .database').css('opacity', 1)
      setTimeout (->
        $('.slides, .network-container').fadeIn()
        fixedDiagram.fadeIn();
        network.runHalf()
      ), 1000

  clickSignup = ->
    clickReset()
    if !network
      setTimeout (->
        finalInfrastructureState()
      ), 100
    else
      network.stop()
      animate
        el: fixedDiagram
        easing: "easeOutQuad"
        opacity: [0, 1]
        duration: 50
      $('.network-container').removeClass('disappear')


      $('.load-balancer, .app, .bastion, .database').css('opacity', 1)
      setTimeout (->
        $('.slides, .network-container').fadeIn()
        fixedDiagram.fadeIn()
        network.runHalf()
      ), 1000


  #
  # Animation arrays
  # fullPage.js uses index values to determine
  # its current slide position which corresponds
  # to these arrays of functions
  #
  play: [playIntro, playInfrastructure, playGateway, playNetwork, playApp, playBastion, playDatabase, playScaling, playSignup]
  leave: [leaveIntro, leaveInfrastructure, leaveGateway, leaveNetwork, leaveApp, leaveBastion, leaveDatabase, leaveScaling]
  leaveUp: [leaveUpInfrastructure, leaveUpGateway, leaveUpNetwork, leaveUpApp, leaveUpBastion, leaveUpDatabase, leaveUpScaling, leaveUpSignup]
  clickOn: [clickIntro, clickInfrastructure, clickGateway, clickNetwork, clickApp, clickBastion, clickDatabse, clickScaling, clickSignup]



