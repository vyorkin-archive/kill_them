stage = new PIXI.Stage(0x66FF99)
renderer = PIXI.autoDetectRenderer(400, 300)
document.body.appendChild(renderer.view)

texture = PIXI.Texture.fromImage("img/bunny.png")
bunny = new PIXI.Sprite(texture)

bunny.anchor.x = 0.5
bunny.anchor.y = 0.5

bunny.position.x = 200
bunny.position.y = 150

stage.addChild(bunny)

animate = ->
  requestAnimFrame(animate)
  bunny.rotation += 0.1
  renderer.render(stage)

requestAnimFrame(animate)
