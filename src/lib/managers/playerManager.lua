-- Imports
Vector = require("lib/vector")
log = require('plugins/Log')
--gunManagers = require('lib/managers/gunManager') 

playerManager = {}

-- Current frame for player animation
local activeFrame

----------------------------------------
-- Player Manager Initializtion
----------------------------------------
function playerManager.Load(playerFrames)
    log.info("[INIT]: Loading player data...")

    currentFrame = 1
    elapsedTime = 0
    shot = 0
    playerFrames = {}
    
    playerHealth = 100
    healthBar =  spriteManager.sprites.ui.healthBar

    Player = spriteManager.sprites.entities.player
    playerFrames[1] = love.graphics.newQuad(0, 25, 14, 23, Player:getDimensions())
    playerFrames[2] = love.graphics.newQuad(14, 25, 14, 23, Player:getDimensions())
    playerFrames[3] = love.graphics.newQuad(28, 25, 14, 23, Player:getDimensions())
    playerFrames[4] = love.graphics.newQuad(42, 25, 14, 23, Player:getDimensions())
    playerFrames[5] = love.graphics.newQuad(56, 25, 14, 23, Player:getDimensions())
    activeFrame = playerFrames[currentFrame]

    playerVector = Vector.Vector2D(100,100)

    -- Set mouseX / mouseY values to x / y position of mouse
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()
end

----------------------------------------
-- Player Manager Mouse Press Check
----------------------------------------
function playerManager.MousePressed(x, y, button) 
  mouseX = love.mouse.getX() 
  mouseY = love.mouse.getY() 
end 

----------------------------------------
-- Player Manager Update
----------------------------------------
function playerManager.Update(dt)
    if love.mouse.isDown(1) then
        shot = 1
    end

    elapsedTime = elapsedTime + love.timer.getTime()

    if shot > 0 then
        if(elapsedTime > 0.05) then
            if(currentFrame < 5) then
            currentFrame = currentFrame + 1
            else
            currentFrame = 1
            shot = 0
            end
            -- activeFrame = playerFrames[currentFrame]
            elapsedTime = 0
        end
    end

    if love.keyboard.isDown("w") then
        playerManager.GetPlayerVector():setY(playerManager.GetPlayerVector():getY() - 4.2) -- Move Up
    end
    if love.keyboard.isDown("s") then
        playerManager.GetPlayerVector():setY(playerManager.GetPlayerVector():getY() + 4.2) -- Move Down
    end
    if love.keyboard.isDown("a") then
        playerManager.GetPlayerVector():setX(playerManager.GetPlayerVector():getX() - 4.2) -- Move Left
    end
    if love.keyboard.isDown("d") then
        playerManager.GetPlayerVector():setX(playerManager.GetPlayerVector():getX() + 4.2) -- Move Right
    end
    if love.keyboard.isDown("r") then
        gunManager.Reload()
    end
    if love.keyboard.isDown("4") then
        gunManager.ChangeGun(0)
    end
    if love.keyboard.isDown("5") then
        gunManager.ChangeGun(1)
    end
    if love.keyboard.isDown("6") then
        gunManager.ChangeGun(2)
    end

    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()
end

----------------------------------------
-- Player Manager Draw
----------------------------------------
function playerManager.Draw()
    local playerAngle = math.atan2(mouseY - playerManager.GetPlayerVector():getY(), mouseX - playerManager.GetPlayerVector():getX()) + (math.pi/2)
    love.graphics.draw(Player, activeFrame, playerManager.GetPlayerVector():getX(), playerManager.GetPlayerVector():getY(), playerAngle)

    --love.graphics.print(playerHealth, 1190,20, 0,2)
    love.graphics.setColor(230,0,0)
    love.graphics.rectangle("fill",1130,25,playerHealth, 20)
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line",1130,25,100,20)
    love.graphics.draw(healthBar,1100,20,0,2,1.7,1.7)
end

----------------------------------------
-- Player Manager Utility Methods
----------------------------------------
function playerManager.GetPlayerVector()
    return playerVector
end

function playerManager.GetPlayerHealth()
    return playerHealth
end

return playerManager