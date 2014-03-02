game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', {

  preload: ->
    @load.tilemap('level', 'assets/tilemaps/maps/map1.json',
      null, Phaser.Tilemap.TILED_JSON)

    @load.image('tiles', 'assets/tilemaps/tiles/grass-tiles-2-small.png')
    @load.image('player', 'assets/images/player.png')

  create: ->
    @map = @add.tilemap('level')
    @map.addTilesetImage('grass-tiles-2-small', 'tiles')

    @layer = @map.createLayer('background')
    @layer.resizeWorld()
    @sprite = @add.sprite(200, 200, 'player')
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5

    @camera.follow(@sprite)

    @cursors = @input.keyboard.createCursorKeys()

  update: ->
    @physics.collide(@sprite, @layer)

    @sprite.body.velocity.x = 0
    @sprite.body.velocity.y = 0
    @sprite.body.angularVelocity = 0

    if @cursors.left.isDown
      @sprite.body.angularVelocity = -200
    else if @cursors.right.isDown
      @sprite.body.angularVelocity = 200

    if @cursors.up.isDown
      vel = @physics.velocityFromAngle(@sprite.angle, 200)
      @sprite.body.velocity.copyFrom(vel)
})
