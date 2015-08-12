$ ->
  $techAnim = $ '.tech-anim'

  # Only runs on the technology page...
  if $techAnim.length > 0

    $doc = $ document

    # Model / State
    window.techAnim = new techAnimation()

    $container = $ '.slides'

    $container.fullpage
      verticalCentered: false
      css3: true
      navigation: true
      navigationPosition: 'left'
      navigationTooltips: ['', 'Stack', 'Network', 'Secure Load Balancing', 'Apps', 'Team Access', 'Databases', 'Scaling']
      showActiveTooltip: true
      keyboardScrolling: false

      afterLoad: (anchorLink, index) ->
        # Play the slide's animation
        techAnim.play[index - 1].call(this) # 1-based index

      onLeave: (index, nextIndex, direction) ->
        click = Math.abs(nextIndex - index) != 1 ? true : false

        if click
          $('.slides, .fixed-panel, .fixed-console, .network-container').fadeOut(50)
          techAnim.clickOn[nextIndex - 1].call(this)
        else if (nextIndex - index == 1)
          techAnim.leave[index - 1].call(this)
        else if (nextIndex - index == -1)
          # index - 2 because the first slide can't be scrolled up
          techAnim.leaveUp[index - 2].call(this)

      afterRender: ->
        $container.css('opacity', 1)
