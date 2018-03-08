levelManager = require('lib/managers/levelManager')
debugger = require('lib/debugger')

overlayManager = {}

-- Initialize debugger math helper
debugger.fpsMath()

function overlayManager.Load()
    -- Initialize debug graph
    debugger.Load()
end

function overlayManager.KeyPressed(key)
    -- Debugger graph toggle
    debugger.keypressed(key, "f12")
end

function overlayManager.Update(dt)
    -- Debug graph update
    debugger.Update(dt)
end

function overlayManager.Draw()
    -- Draw score/zombies left text
    love.graphics.print(levelManager.GetNumZombiesLeft() .. " / " .. levelManager.GetNumZombies(), 980,20, 0,2)

    -- Draw Debug Graph
    -- MUST be last to make top layer
    debugger.Draw()
end

return overlayManager