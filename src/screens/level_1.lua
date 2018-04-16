levelManager = require('lib/managers/levelManager')
spriteManager = require('lib/managers/spriteManager')
overlayManager = require('lib/managers/overlayManager')
screenManager = require('lib/managers/screenManager')
screen = require('plugins/Screen')
log = require('plugins/Log')

level_1 = {}

-- Number of zombies to spawn
local slowZombieNum = 150
local fastZombieNum = 4
local largeZombieNum = 4

----------------------------------------
-- Create new screen
----------------------------------------
function level_1.new()
    local self = screen.new()

    log.info("[INIT]: Loading level 1...")

    screenManager.SetIsGameplay(true)

    -- Initialize level
    levelManager.Load(slowZombieNum, fastZombieNum, largeZombieNum)

    function self:update(dt)
        level_1.Update(dt)
    end

    function self:draw()
        level_1.Draw()
    end

    return self
end

----------------------------------------
-- Update method
----------------------------------------
function level_1.Update(dt)
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
function level_1.Draw()
  -- Draw background image
  DrawBackground()

  -- Draw level manager
  levelManager.Draw()

  -- Draw overlay
  overlayManager.Draw()
end

return level_1