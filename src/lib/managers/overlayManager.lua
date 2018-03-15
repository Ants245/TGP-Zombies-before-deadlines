levelManager = require('lib/managers/levelManager')
log = require('plugins/Log')

overlayManager = {}

function overlayManager.Load()
    log.info("[INIT]: Loading overlay...")
end

function overlayManager.KeyPressed(key)
    
end

function overlayManager.Update(dt)

end

function overlayManager.Draw()
    -- Draw score/zombies left text
    love.graphics.print(levelManager.GetNumZombiesLeft() .. " / " .. levelManager.GetNumZombies(), 980,20, 0,2)
end

return overlayManager