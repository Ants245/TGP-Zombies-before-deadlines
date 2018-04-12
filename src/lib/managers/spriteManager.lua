log = require('plugins/Log')

spriteManager = {}
spriteManager.sprites = {}
spriteManager.sprites.entities = {}
spriteManager.sprites.weapons = {}
spriteManager.sprites.ui = {}
spriteManager.sprites.backgrounds = {}

local assetsSpritesPath = "assets/sprites/"

----------------------------------------
-- Sprite Manager Initializtion
----------------------------------------
function spriteManager.Load()
  log.info("[INIT]: Loading sprites...")

  -- Entities
  spriteManager.sprites.entities.player = love.graphics.newImage(assetsSpritesPath .. "entities/player/playerSpritesheet.png")
  spriteManager.sprites.entities.zombie = love.graphics.newImage(assetsSpritesPath .. "entities/zombie/zombie_normal.png")
  spriteManager.sprites.entities.zombieFast = love.graphics.newImage(assetsSpritesPath .. "entities/zombie/zombie_fast.png")
  spriteManager.sprites.entities.zombieFat = love.graphics.newImage(assetsSpritesPath .. "entities/zombie/zombie_fat.png")

  -- Weapons
  spriteManager.sprites.weapons.shotgun = love.graphics.newImage(assetsSpritesPath .. "weapons/spritesheet_shotgun.png")
  spriteManager.sprites.weapons.pistol = love.graphics.newImage(assetsSpritesPath .. "weapons/spritesheet_pistol.png")
  spriteManager.sprites.weapons.tempGunSelection = love.graphics.newImage(assetsSpritesPath .. "weapons/TempGunSelection.png") 

  -- UI spritesheets
  spriteManager.sprites.ui.crosshair = love.graphics.newImage(assetsSpritesPath .. "crosshair.png")
  spriteManager.sprites.ui.red = love.graphics.newImage(assetsSpritesPath .. "ui/redSheet.png")
  spriteManager.sprites.ui.green = love.graphics.newImage(assetsSpritesPath .. "ui/greenSheet.png")
  spriteManager.sprites.ui.blue = love.graphics.newImage(assetsSpritesPath .. "ui/blueSheet.png")
  spriteManager.sprites.ui.ammoPickup = love.graphics.newImage(assetsSpritesPath .. "ui/ammoPickup.png")
  spriteManager.sprites.ui.gunSelection = love.graphics.newImage(assetsSpritesPath .. "ui/gunSelection.png")
  spriteManager.sprites.ui.healthBar = love.graphics.newImage(assetsSpritesPath .. "ui/HealthBarUI.png")

  -- Level background images
  spriteManager.sprites.backgrounds.level_1 = love.graphics.newImage("assets/sprites/background_road.png")
end

return spriteManager