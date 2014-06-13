define ['phaser.min', 'entities', 'components', 'systems'], (Ph, E, C, S) ->
  window.E = E
  window.C = C
  window.S = S

  game = new Ph.Game(800, 600, Ph.AUTO, 'phaser-example', {
    preload: ->
      sprites =
        player:  'assets/images/player.png'
        bullet:  'assets/images/bullet.png'
        zombie1: 'assets/images/zombie1.png'
        zombie2: 'assets/images/zombie2.png'
        zombie3: 'assets/images/zombie3.png'
        zombie4: 'assets/images/zombie4.png'

      @load.tilemap(
        'level', 'assets/tilemaps/maps/map1.json',
        null, Ph.Tilemap.TILED_JSON
      )

      @load.image('tiles', 'assets/tilemaps/tiles/grass-tiles-2-small.png')

      for alias, path of sprites
        @load.image(alias, path)

    create: ->
      @map = @add.tilemap('level')
      @map.addTilesetImage('grass-tiles-2-small', 'tiles')

      @layer = @map.createLayer('background')
      @layer.resizeWorld()
  })
