levelManager = require('lib/managers/levelManager')
screenManager = require('lib/managers/screenManager')
fontManager = require('lib/managers/fontManager')
log = require('plugins/Log')

overlayManager = {}

isPauseMenuDrawn = false

----------------------------------------
-- Overlay Manager Initializtion
----------------------------------------
function overlayManager.Load()
    log.info("[INIT]: Loading overlay...")
    isPauseMenuDrawn = false
end

----------------------------------------
-- Overlay Manager Key press check
----------------------------------------
function overlayManager.KeyPressed(key)
    
end

----------------------------------------
-- Overlay Manager Mouse press check
----------------------------------------
function overlayManager.MousePressed(x, y, button)
    
end

----------------------------------------
-- Overlay Manager Update
----------------------------------------
function UpdatePauseMenu(dt)
    
end

function overlayManager.Update(dt)
    UpdatePauseMenu(dt)
end

----------------------------------------
-- Overlay Manager Draw
----------------------------------------
function DrawPauseMenu()
    
end

function overlayManager.Draw()
    -- Set font to rock salt
    love.graphics.setFont(fontManager.fonts.rockSalt)

    -- Draw pause menu overlay
    -- Must draw last to make top layer
    if(isPauseMenuDrawn == false)then
        DrawPauseMenu()
    end
end

return overlayManager