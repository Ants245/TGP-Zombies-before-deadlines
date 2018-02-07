log = require('lib/plugins/Log')

spriteManager = {}
spriteManager.sprites = {}
spriteManager.sprites.entities = {}
spriteManager.sprites.weapons = {}
spriteManager.sprites.ui = {}

-- Load sprites
function spriteManager.Load()
  log.info("[INIT]: Loading sprites")

  -- Entities
  spriteManager.sprites.entities.playerSpritesheet = love.graphics.newImage("assets/sprites/entities/playerSpritesheet.png")
  spriteManager.sprites.entities.zombieSpritesheet = love.graphics.newImage("assets/sprites/entities/zombieSpritesheet.png")

  -- Weapons
  spriteManager.sprites.weapons.shotgunSpritesheet = love.graphics.newImage("assets/sprites/weapons/spritesheet_shotgun.png")
  spriteManager.sprites.weapons.pistolSpritesheet = love.graphics.newImage("assets/sprites/weapons/spritesheet_pistol.png")

  -- UI spritesheets
  spriteManager.sprites.ui.red = love.graphics.newImage("assets/sprites/ui/redSheet.png")
  spriteManager.sprites.ui.green = love.graphics.newImage("assets/sprites/ui/greenSheet.png")
  spriteManager.sprites.ui.blue = love.graphics.newImage("assets/sprites/ui/blueSheet.png")
end

function spriteManager.Update(dt)
  
end

function spriteManager.Draw()
  
end

return spriteManager