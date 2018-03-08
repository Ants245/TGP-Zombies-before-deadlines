levelManager = require('lib/managers/levelManager')

overlayManager = {}

function overlayManager.Load()
    
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