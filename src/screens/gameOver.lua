screenManager = require('lib/managers/screenManager')
audioManager = require('lib/managers/audioManager')
screen = require('plugins/Screen')
shack = require('plugins/Shack')
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

    -- Initialize Shack to game window dimensions
    shack:setDimensions(love.graphics.getDimensions())

    -- Shake screen when game over
    shack:setShake(20)

    tryAgainButton = {
        x = (love.graphics.getWidth() / 2) - 100,
        y = (love.graphics.getHeight() / 2) - 0,
        image = spriteManager.sprites.ui.Button,
        text = "Try Again",
        textOffsetX = 37.5,
        textOffsetY = 7,
        clicked = false
    }
    
    exitButton = {
        x = (love.graphics.getWidth() / 2) - 100,
        y = (love.graphics.getHeight() / 2) + 75,
        image = spriteManager.sprites.ui.Button,
        text = "Exit",
        textOffsetX = 67.5,
        textOffsetY = 7,
        clicked = false
	}

    function self:mousepressed(x, y, button)
        gameOver.MousePressed(x, y, button)
    end

    function self:update(dt)
        gameOver.Update(dt)
    end

    function self:draw()
        gameOver.Draw()
    end

    return self
end

----------------------------------------
-- Mouse pressed method
----------------------------------------
function gameOver.MousePressed(x, y, button)
    if(button == 1) then
		if(x >= tryAgainButton.x and x <= tryAgainButton.x + tryAgainButton.image:getWidth() and y >= tryAgainButton.y and y <= tryAgainButton.y + tryAgainButton.image:getHeight()) then
			tryAgainButton.clicked = true
        end
        if(x >= exitButton.x and x <= exitButton.x + exitButton.image:getWidth() and y >= exitButton.y and y <= exitButton.y + exitButton.image:getHeight()) then
			exitButton.clicked = true
        end
	end
end

----------------------------------------
-- Update method
----------------------------------------
function gameOver.Update(dt)
    if(tryAgainButton.clicked == true) then
		screenManager.GetScreenObj().switch('survival')
    end
    if(exitButton.clicked == true) then
		love.event.quit()
	end

    -- Shack update
    shack:update(dt)
end

----------------------------------------
-- Draw method
----------------------------------------
function gameOver.Draw()
    -- Draw background
    love.graphics.setColor(255, 0, 0)
    love.graphics.draw(spriteManager.sprites.backgrounds.mainMenu, 0, 0)

    -- Draw title text on center of screen
    love.graphics.setFont(fontManager.fonts.rockSaltBig)
    love.graphics.print("GAME OVER!", (love.graphics.getWidth() / 2) - 250, (love.graphics.getHeight() / 2) - 300)

    -- Set font back to smaller font
    love.graphics.setFont(fontManager.fonts.rockSalt)

    -- Draw "Press space to play again or click 'Try Again'" text
    love.graphics.print("Press space to try again. Or press 'Try Again'", (love.graphics.getWidth() / 2) - 250, (love.graphics.getHeight() / 2) - 100 )
    
    -- Draw Play button
    love.graphics.draw(tryAgainButton.image, tryAgainButton.x, tryAgainButton.y)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(tryAgainButton.text, (tryAgainButton.x + tryAgainButton.textOffsetX), (tryAgainButton.y - tryAgainButton.textOffsetY))

    -- Draw Exit button
    love.graphics.setColor(255, 0, 0)
    love.graphics.draw(exitButton.image, exitButton.x, exitButton.y)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(exitButton.text, (exitButton.x + exitButton.textOffsetX), (exitButton.y - exitButton.textOffsetY))

    -- Draw shack
    shack:apply()
end

return gameOver