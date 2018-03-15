levelManager = require('lib/managers/levelManager')
spriteManager = require('lib/managers/spriteManager')
overlayManager = require('lib/managers/overlayManager')
screen = require('plugins/Screen')
log = require('plugins/Log')

level_3 = {}

-- Number of zombies to spawn
local numZombieSpawn = 500

-- Bullet fire rate
local bulletFireRate = 0.05

----------------------------------------
-- Create new screen
----------------------------------------
function level_3.new()
    local self = screen.new()

    log.info("[INIT]: Loading level 3...")

    -- Initialize level
    levelManager.Load(numZombieSpawn, bulletFireRate)

    function self:update(dt)
        level_3.Update(dt)
    end

    function self:draw()
        level_3.Draw()
    end

    return self
end

----------------------------------------
-- Update method
----------------------------------------
function level_3.Update(dt)
    -- Update level manager
    levelManager.Update(dt)

    -- Update overlay
    overlayManager.Update(dt)
end

----------------------------------------
-- Draw background image
----------------------------------------
function DrawBackground(posX, posY)
  -- Set sprite wrap mode to repeat(tile)
  spriteManager.sprites.backgrounds.level_1:setWrap("mirroredrepeat", "mirroredrepeat")

  -- Draw sprite
  love.graphics.draw(spriteManager.sprites.backgrounds.level_1, posX, posY)
end

----------------------------------------
-- Draw method
----------------------------------------
function level_3.Draw()
  -- Draw background image
  DrawBackground()

  -- Draw level manager
  levelManager.Draw()

  -- Draw overlay
  overlayManager.Draw()
end

return level_3