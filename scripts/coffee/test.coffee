class CarbonBased
  constructor: (@game, @image) ->
    @alive = true
    @sprite = @game.add.sprite(@game.world.randomX, game.world.randomY, @image)
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.body.collideWorldBounds = true
    @sprite.angle = @game.rnd.angle()
    @sprite.body.linearDamping = 0.2
    @sprite.body.bounce.setTo(1, 1)
    @sprite.body.maxVelocity.setTo(0, 0)

class Zombie extends CarbonBased
  constructor: (@game, @player) ->
    @health = 10
    @speed = 2
    super @game, 'zombie' + @game.rnd.integerInRange(1, 4)

  hit: ->
    @health -= 1
    @alive = false if @health <= 0

  update: ->
    @sprite.rotation = @game.physics.angleBetween(@sprite, @player.sprite)
    @game.physics.moveToObject(@sprite, @player.sprite, @speed * 10, 0)
    @sprite.kill if !@alive

class Player extends CarbonBased
  constructor: (options) ->
    {@game, @layer, @cursors, @bullets} = options
    @health = 50
    @speed = 200
    @fireRate = 100
    @nextFire = 0
    super @game, 'player'

  update: ->
    @game.physics.collide(@sprite, @layer)

    @sprite.body.velocity.x = 0
    @sprite.body.velocity.y = 0
    @sprite.body.angularVelocity = 0

    if @cursors.left.isDown
      @sprite.body.angularVelocity -= @speed
    else if @cursors.right.isDown
      @sprite.body.angularVelocity += @speed

    if @cursors.up.isDown
      vel = @game.physics.velocityFromAngle(@sprite.angle, @speed)
      @sprite.body.velocity.copyFrom(vel)

    if @cursors.down.isDown
      vel = @game.physics.velocityFromAngle(@sprite.angle, -@speed)
      @sprite.body.velocity.copyFrom(vel)

    if @game.input.keyboard.isDown(Phaser.Keyboard.SPACEBAR)
      if @game.time.now > @nextFire && @bullets.countDead() > 0
        @nextFire = @game.time.now + @fireRate

        bullet = @bullets.getFirstDead()
        bullet.reset(@sprite.x, @sprite.y)
        @game.physics.velocityFromAngle(@sprite.angle,
          1000, bullet.body.velocity)

game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', {
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
      null, Phaser.Tilemap.TILED_JSON
    )

    @load.image('tiles', 'assets/tilemaps/tiles/grass-tiles-2-small.png')

    for alias, path of sprites
      @load.image(alias, path)

  create: ->
    # TODO: try it
    # @stage.fullScreenScaleMode = Phaser.StageScaleMode.SHOW_ALL
    # @input.keyboard.addCallbacks(
    #   Phaser.Keyboard.F1,
    #   => @stage.scale.startFullScreen(),
    #   null
    # )

    @map = @add.tilemap('level')
    @map.addTilesetImage('grass-tiles-2-small', 'tiles')

    @layer = @map.createLayer('background')
    @layer.resizeWorld()

    @cursors = @input.keyboard.createCursorKeys()

    @bullets = @game.add.group()
    @bullets.createMultiple(100, 'bullet')
    @bullets.setAll('anchor.x', 0.5)
    @bullets.setAll('anchor.y', 0.5)
    @bullets.setAll('outOfBoundsKill', true)

    @player = new Player(
      game: @game,
      layer: @layer,
      cursors: @cursors,
      bullets: @bullets
    )

    @zombies = []
    @zombies.push(new Zombie(@game, @player)) for [1..5]

    @camera.follow(@player.sprite)

    @camera.deadzone = new Phaser.Rectangle(150, 150, 500, 300)
    @camera.focusOnXY(0, 0)

    @zombieHit = (z, b) ->
      @hit()
      b.kill()

  update: ->
    @player.update()

    for zombie in @zombies
      if zombie.alive
        zombie.update()
        @physics.collide(@player.sprite, zombie.sprite)
        @physics.overlap(@bullets, zombie.sprite, @zombieHit, null, zombie)

})
