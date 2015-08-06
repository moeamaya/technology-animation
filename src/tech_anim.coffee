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
      navigationTooltips: ['', 'Infrastructure', 'Gateway', 'Load Balancing', 'Application', 'Bastion', 'Database', 'Scale']
      showActiveTooltip: true

      afterLoad: (anchorLink, index) ->
        # Check slide's current state
        techAnim.play[index - 1].call(this) # 1-based index

      onLeave: (index, nextIndex, direction) ->
        # Check the direction and the slide's current state
        techAnim.stopIntro()
        techAnim.leave[index - 1].call(this)

      afterRender: ->
        $container.css('opacity', 1)
