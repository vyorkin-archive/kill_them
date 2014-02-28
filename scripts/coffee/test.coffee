game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', {
  preload: ->
    game.load.tilemap('level', 'assets/tilemaps/maps/map1.json',
      null, Phaser.Tilemap.TILED_JSON)

    game.load.image('tiles', 'assets/tilemaps/tiles/grass-tiles-2-small.png')
    game.load.image('hero', 'assets/images/hero.png')

  create: ->
    map = game.add.tilemap('level')
    map.addTilesetImage('grass-tiles-2-small', 'tiles')

    layer = map.createLayer('background')
    layer.resizeWorld()
    game.add.sprite(0, 0, 'hero')
})
