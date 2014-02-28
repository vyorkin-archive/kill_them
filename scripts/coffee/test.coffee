game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', {
  preload: ->
    game.load.tilemap('level', 'assets/tilemaps/example.json', null, Phaser.Tilemap.TILED_JSON)
    console.log game
    game.load.tileset('tiles', 'assets/images/tiles/grass-tiles-2-small.png', 32, 32)
    game.load.tileset('tree_tile', 'assets/images/tiles/tree2-final.pan', 256, 256)

    game.load.image('hero', 'assets/images/hero.png')

  create: ->
    map = game.add.tilemap('level')
    game.add.tileset('tiles')
    game.add.tileset('tree_tile')
    game.add.sprite(0, 0, 'hero')
})