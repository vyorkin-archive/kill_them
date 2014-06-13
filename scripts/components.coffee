define [], () ->
  window.U = Utils
  class Component
    @type = 'AbstractComponent'

    constructor: ->
      # generate eid somehow

    toString: () ->
      "#{type}: #{JSON.stringify(this)}"

  class Renderable extends Component
    @type: 'Renderable'

  class Position extends Component
    @type: 'Position'
    @x: 0
    @y: 0
    @rotation: 0

  return { Component, Renderable, Position }
