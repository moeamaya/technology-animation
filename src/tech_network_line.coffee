class TechNetworkLine


  constructor: (line) ->
    @start = null
    @startTime = null

    @line = line
    @dot = null
    @active = null

    @animating = null



  randomTime: (max, min) ->
    (Math.random() * (max - min) + min) * 1000


  step: (timestamp) =>
    if !@start
      @start = timestamp
    progress = timestamp - @start
    stepping = Math.min(progress / 20, 96)

    @active.css('transform', 'scaleY(' + stepping / 100 + ')')
    @dot.css('top', stepping + '%')

    if progress < 2000
      @animating = window.requestAnimationFrame @step
    else
      @resetActivity()
      @animating = window.requestAnimationFrame @step



  generateLine: (yPos, klass) ->
    # @line = $('<div class="network-line">')
    @line.addClass(klass)
    @line.css('left', yPos + "px")   

    @startTime = @randomTime(0, 3)
    @createActive()


  createActive: ->
    @active = $ '<div class="active">'
    @dot = $ '<div class="dot">'
    @line.append(@active).append(@dot)


  
  runActivity: ->
    @showActive()

    setTimeout (=>
      @animating = window.requestAnimationFrame @step
    ), @startTime


  destroyActivity: ->
    @hideActive()

    setTimeout ( => 
      window.cancelAnimationFrame @animating
      @animating = null
      @resetActivity()
    ), 600


  resetActivity: ->
    @active.css('transform', 'scaleY(0)')
    @dot.css('top', '0%')
    @start = null


  showActive: ->
    console.log @dot.offset().left
    animate
      el: @dot
      easing: 'easeOutCirc'
      opacity: [0, 1]
      duration: 600
    animate
      el: @active
      easing: 'easeOutCirc'
      opacity: [0, 1]
      duration: 600


  hideActive: ->
    animate
      el: @dot
      easing: 'easeOutCirc'
      opacity: [1, 0]
      duration: 600
    animate
      el: @active
      easing: 'easeOutCirc'
      opacity: [1, 0]
      duration: 600



  # -------------------------------
  # Public methods
  # -------------------------------


  createLine: (yPos, klass)->
    @generateLine(yPos, klass)


  getDOMObject: ->
    @line


  startActivity: ->
    @runActivity()


  stopActivity: ->
    @destroyActivity()


