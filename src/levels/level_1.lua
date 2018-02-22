-- Imports
levelManager = require('lib/levelManager')
spriteManager = require('lib/spriteManager')

level_1 = {}

function level_1.Load(numZombieSpawn, bulletFireRate)
  -- Load level manager
  levelManager.Load(numZombieSpawn, bulletFireRate)
end

function level_1.Update(dt)
  -- Update level manager
  levelManager.Update(dt)
end

function DrawBackground(posX, posY)
  -- Set sprite wrap mode to repeat(tile)
  spriteManager.sprites.backgrounds.level_1:setWrap("mirroredrepeat", "mirroredrepeat")

  -- Draw sprite
  love.graphics.draw(spriteManager.sprites.backgrounds.level_1, posX, posY)
end

function level_1.Draw()
  -- Draw background image
  DrawBackground()

  -- Draw level manager
  levelManager.Draw()
end

return level_1