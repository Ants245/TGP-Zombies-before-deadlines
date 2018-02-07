log = require('lib/plugins/Log')

spriteManager = {}
spriteManager.sprites = {}

-- Load sprites
function spriteManager.Load()
  log.info("[INIT]: Loading sprites")

  spriteManager.sprites.playerSpritesheet = love.graphics.newImage("assets/sprites/playerSpritesheet.png")
  spriteManager.sprites.shotgunSpritesheet = love.graphics.newImage("assets/sprites/playerSpritesheet.png")
  spriteManager.sprites.pistolSpritesheet = love.graphics.newImage("assets/sprites/playerSpritesheet.png")
  spriteManager.sprites.zombieSpritesheet = love.graphics.newImage("assets/sprites/playerSpritesheet.png")
end

function spriteManager.Update(dt)
  
end

function spriteManager.Draw()
  
end

return spriteManager