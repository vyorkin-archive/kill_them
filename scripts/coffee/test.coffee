game = new Phaser.Game(800, 600, Phaser.CANVAS, 'phaser-example', {
  preload: ->
    game.load.image('einstein', 'assets/images/einstein.png')
  create: ->
    game.add.sprite(0, 0, 'einstein')
})
