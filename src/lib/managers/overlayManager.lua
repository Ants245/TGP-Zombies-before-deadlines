levelManager = require('lib/managers/levelManager')
log = require('plugins/Log')

overlayManager = {}

----------------------------------------
-- Overlay Manager Initializtion
----------------------------------------
function overlayManager.Load()
    log.info("[INIT]: Loading overlay...")
end

----------------------------------------
-- Overlay Manager Key press check
----------------------------------------
function overlayManager.KeyPressed(key)
    
end

----------------------------------------
-- Overlay Manager Update
----------------------------------------
function overlayManager.Update(dt)

end

----------------------------------------
-- Overlay Manager Draw
----------------------------------------
function overlayManager.Draw()
    -- Draw score/zombies left text
    love.graphics.print(levelManager.GetNumZombiesLeft() .. " / " .. levelManager.GetNumZombies(), 980,20, 0,2)
end

return overlayManager