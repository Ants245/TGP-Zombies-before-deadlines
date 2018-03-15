log = require('plugins/Log')

spriteManager = {}
spriteManager.sprites = {}
spriteManager.sprites.entities = {}
spriteManager.sprites.weapons = {}
spriteManager.sprites.ui = {}
spriteManager.sprites.backgrounds = {}

----------------------------------------
-- Sprite Manager Initializtion
----------------------------------------
function spriteManager.Load()
  log.info("[INIT]: Loading sprites...")

  -- Entities
  spriteManager.sprites.entities.player = love.graphics.newImage("assets/sprites/entities/player/playerSpritesheet.png")
  spriteManager.sprites.entities.zombie = love.graphics.newImage("assets/sprites/entities/zombie/zombieSpritesheet.png")
  spriteManager.sprites.entities.zombieFast = love.graphics.newImage("assets/sprites/entities/zombie/zombieFastSpritesheet.png")

  -- Weapons
  spriteManager.sprites.weapons.shotgun = love.graphics.newImage("assets/sprites/weapons/spritesheet_shotgun.png")
  spriteManager.sprites.weapons.pistol = love.graphics.newImage("assets/sprites/weapons/spritesheet_pistol.png")

  -- UI spritesheets
  spriteManager.sprites.ui.crosshair = love.graphics.newImage("assets/sprites/crosshair.png")
  spriteManager.sprites.ui.red = love.graphics.newImage("assets/sprites/ui/redSheet.png")
  spriteManager.sprites.ui.green = love.graphics.newImage("assets/sprites/ui/greenSheet.png")
  spriteManager.sprites.ui.blue = love.graphics.newImage("assets/sprites/ui/blueSheet.png")

  -- Level background images
  spriteManager.sprites.backgrounds.level_1 = love.graphics.newImage("assets/sprites/background_road.png")
end

return spriteManager