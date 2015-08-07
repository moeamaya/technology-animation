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
      navigationTooltips: ['', 'Infrastructure', 'Gateway', 'Load Balancing', 'Application', 'Bastion', 'Database', 'Scaling']
      showActiveTooltip: true

      afterLoad: (anchorLink, index) ->
        # Play the slide's animation
        techAnim.play[index - 1].call(this) # 1-based index

      onLeave: (index, nextIndex, direction) ->
        # Check the direction and the slide's current state
        if direction == "down"
          techAnim.leave[index - 1].call(this)
        else
          # index - 2 because the first slide can't be scrolled up
          techAnim.leaveUp[index - 2].call(this)

      afterRender: ->
        $container.css('opacity', 1)
