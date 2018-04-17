fontManager = require('lib/managers/fontManager')
spriteManager = require('lib/managers/spriteManager')
screenManager = require('lib/managers/screenManager')
screen = require('plugins/Screen')
log = require('plugins/Log')

mainMenu = {}

----------------------------------------
-- Create new screen
----------------------------------------
function mainMenu.new()
    local self = screen.new()

    log.info("[INIT]: Loading main menu...")

    screenManager.SetIsGameplay(false)
    
    playButton = {
        x = (love.graphics.getWidth() / 2) - 100,
        y = (love.graphics.getHeight() / 2) - 0,
        image = spriteManager.sprites.ui.Button,
        text = "Play",
        textOffsetX = 67.5,
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

    function self:keypressed(key)
        mainMenu.KeyPressed(key)
    end

    function self:mousepressed(x, y, button)
        mainMenu.MousePressed(x, y, button)
    end

    function self:update(dt)
        mainMenu.Update(dt)
    end

    function self:draw()
        mainMenu.Draw()
    end

    return self
end

----------------------------------------
-- Key pressed method
----------------------------------------
function mainMenu.KeyPressed(key)
    if(key == "space")then
        screenManager.GetScreenObj().switch('survival')
    end
end

----------------------------------------
-- Mouse pressed method
----------------------------------------
function mainMenu.MousePressed(x, y, button)
    if(button == 1) then
		if(x >= playButton.x and x <= playButton.x + playButton.image:getWidth() and y >= playButton.y and y <= playButton.y + playButton.image:getHeight()) then
			playButton.clicked = true
        end
        if(x >= exitButton.x and x <= exitButton.x + exitButton.image:getWidth() and y >= exitButton.y and y <= exitButton.y + exitButton.image:getHeight()) then
			exitButton.clicked = true
        end
	end
end

----------------------------------------
-- Update method
----------------------------------------
function mainMenu.Update(dt)
    if(playButton.clicked == true) then
		screenManager.GetScreenObj().switch('survival')
    end
    if(exitButton.clicked == true) then
		love.event.quit()
	end
end

----------------------------------------
-- Draw method
----------------------------------------
function mainMenu.Draw()
    -- Draw background
    love.graphics.draw(spriteManager.sprites.backgrounds.mainMenu, 0, 0)

    -- Draw title text on center of screen
    love.graphics.setFont(fontManager.fonts.rockSaltBig)
    love.graphics.print("Zombies Before Deadlines", (love.graphics.getWidth() / 2) - 500, (love.graphics.getHeight() / 2) - 200)

    -- Set font back to smaller font
    love.graphics.setFont(fontManager.fonts.rockSalt)
    
    -- Draw Play button
    love.graphics.draw(playButton.image, playButton.x, playButton.y)
    love.graphics.print(playButton.text, (playButton.x + playButton.textOffsetX), (playButton.y - playButton.textOffsetY))

    -- Draw Exit button
    love.graphics.draw(exitButton.image, exitButton.x, exitButton.y)
    love.graphics.print(exitButton.text, (exitButton.x + exitButton.textOffsetX), (exitButton.y - exitButton.textOffsetY))
end

return mainMenu