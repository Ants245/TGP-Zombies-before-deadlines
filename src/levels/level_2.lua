-- Imports
levelManager = require('lib/managers/levelManager')
spriteManager = require('lib/managers/spriteManager')

level_2 = {}

function level_2.Load(numZombieSpawn, bulletFireRate)
  -- Load level manager
  levelManager.Load(numZombieSpawn, bulletFireRate)
end

function level_2.Update(dt)
  -- Update level manager
  levelManager.Update(dt)
end

function DrawBackground(posX, posY)
  -- Set sprite wrap mode to repeat(tile)
  spriteManager.sprites.backgrounds.level_2:setWrap("mirroredrepeat", "mirroredrepeat")

  -- Draw sprite
  love.graphics.draw(spriteManager.sprites.backgrounds.level_2, posX, posY)
end

function level_2.Draw()
  -- Draw background image
  DrawBackground()

  -- Draw level manager
  levelManager.Draw()
end

return level_2