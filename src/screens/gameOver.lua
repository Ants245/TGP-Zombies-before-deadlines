screenManager = require('lib/managers/screenManager')
audioManager = require('lib/managers/audioManager')
screen = require('plugins/Screen')
log = require('plugins/Log')

gameOver = {}

----------------------------------------
-- Create new screen
----------------------------------------
function gameOver.new()
    local self = screen.new()

    log.info("[INIT]: Loading game over...")

    screenManager.SetIsGameplay(false)

    -- Play game over sound when player dies
    audioManager.Play(audioManager.sounds.voiceover.game_over)

    function self:update(dt)
        gameOver.Update(dt)
    end

    function self:draw()
        gameOver.Draw()
    end

    return self
end

----------------------------------------
-- Update method
----------------------------------------
function gameOver.Update(dt)
    
end

----------------------------------------
-- Draw method
----------------------------------------
function gameOver.Draw()
    love.graphics.setColor(0, 0, 0, 50)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(255, 255, 255, 255)
end

return gameOver