log = require('plugins/Log')

spriteManager = {}
spriteManager.sprites = {}
spriteManager.sprites.entities = {}
spriteManager.sprites.weapons = {}
spriteManager.sprites.ui = {}

-- Load sprites
function spriteManager.Load()
  log.info("[INIT]: Loading sprites")

  -- Entities
  spriteManager.sprites.entities.player = love.graphics.newImage("assets/sprites/entities/player/playerSpritesheet.png")
  spriteManager.sprites.entities.zombie = love.graphics.newImage("assets/sprites/entities/zombie/zombieSpritesheet.png")

  -- Weapons
  spriteManager.sprites.weapons.shotgun = love.graphics.newImage("assets/sprites/weapons/spritesheet_shotgun.png")
  spriteManager.sprites.weapons.pistol = love.graphics.newImage("assets/sprites/weapons/spritesheet_pistol.png")

  -- UI spritesheets
  spriteManager.sprites.ui.red = love.graphics.newImage("assets/sprites/ui/redSheet.png")
  spriteManager.sprites.ui.green = love.graphics.newImage("assets/sprites/ui/greenSheet.png")
  spriteManager.sprites.ui.blue = love.graphics.newImage("assets/sprites/ui/blueSheet.png")

  -- Misc sprites
  spriteManager.sprites.backgroundImage = love.graphics.newImage("assets/sprites/background_road.png")
end

function spriteManager.Update(dt)
  
end

function spriteManager.Draw()
  drawBackground(0, 0)
end

function drawBackground(posX, posY)
  -- Set sprite wrap mode to repeat(tile)
  spriteManager.sprites.backgroundImage:setWrap("mirroredrepeat", "mirroredrepeat")

  -- Draw sprite
  love.graphics.draw(spriteManager.sprites.backgroundImage, posX, posY)
end

return spriteManager