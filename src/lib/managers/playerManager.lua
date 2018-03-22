-- Imports
Vector = require("lib/vector")
log = require('plugins/Log')

player = {}

----------------------------------------
-- Player Manager Initializtion
----------------------------------------
function player.Load(playerFrames)
    log.info("[INIT]: Loading player data...")

    activeFrame = 0
    currentFrame = 01

    Player = spriteManager.sprites.entities.player
    playerFrames[1] = love.graphics.newQuad(0, 25, 14, 23, Player:getDimensions())
    playerFrames[2] = love.graphics.newQuad(14, 25, 14, 23, Player:getDimensions())
    playerFrames[3] = love.graphics.newQuad(28, 25, 14, 23, Player:getDimensions())
    playerFrames[4] = love.graphics.newQuad(42, 25, 14, 23, Player:getDimensions())
    playerFrames[5] = love.graphics.newQuad(56, 25, 14, 23, Player:getDimensions())
    activeFrame = playerFrames[currentFrame]

    playerRotationAngle = 0

    playerVector = Vector.Vector2D(100,100)
end

----------------------------------------
-- Player Manager Update
----------------------------------------
function player.Update(dt)
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

    playerRotationAngle = math.atan2(love.mouse.getY() - playerManager.GetPlayerVector():getY(), love.mouse.getX() - playerManager.GetPlayerVector():getX()) + (math.pi/2)
end

----------------------------------------
-- Player Manager Draw
----------------------------------------
function player.Draw()
    love.graphics.draw(Player, activeFrame, playerManager.GetPlayerVector():getX(), playerManager.GetPlayerVector():getY(), playerRotationAngle)
end

----------------------------------------
-- Player Manager Utility Methods
----------------------------------------
function player.GetPlayerVector()
    return playerVector
end

return player