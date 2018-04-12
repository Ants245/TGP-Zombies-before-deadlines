-- Imports
spriteManager = require('lib/managers/spriteManager')
playerManager = require('lib/managers/playerManager')
zombieManager = require('lib/managers/zombieManager')
gunManager    = require('lib/managers/gunManager') 
log = require('plugins/Log')

local bulletRPM, numZombies, mouseX, mouseY, shot, elapsedTime
local playerFrames = {}

levelManager = {}

----------------------------------------
-- Level Manager Initializtion
----------------------------------------
function levelManager.Load(slowZombieNum,fastZombieNum,largeZombieNum)
    log.info("[INIT]: Loading level manager...")

    -- num of total zombies to spawn
    numZombies = slowZombieNum + fastZombieNum + largeZombieNum 

    -- Initialially set number of zombies left to spawn amount
    numZombiesLeft = numZombies

    -- Initialize Player
    playerManager.Load(playerFrames)
    gunManager.Load(gunSelect) 

    -- Initialize Zombies
    zombieManager.Load(slowZombieNum,fastZombieNum,largeZombieNum) 

    -- Sets mouse to be invisible
    love.mouse.setVisible(not love.mouse.isVisible())

    -- Local var initialization
    shot = 0
    elapsedTime = 0
    currentFrameTime =0 
    speedDecresTime = 500
end

----------------------------------------
-- Level Manager Mouse press check
----------------------------------------
function levelManager.MousePressed(x, y, button)
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()
    playerManager.MousePressed(x,y,button) 
end

----------------------------------------
-- Level Manager Utility methods
----------------------------------------
function levelManager.GetNumZombies()
    return numZombies
end

function levelManager.GetNumZombiesLeft()
    return numZombiesLeft
end

----------------------------------------
-- Level Manager Update methods
----------------------------------------
function levelManager.Update(dt)
    playerManager.Update(dt)
    zombieManager.Update(dt)
    gunManager.Update(dt)
end

----------------------------------------
-- Level Manager Draw methods
----------------------------------------
function levelManager.Draw()
    playerManager.Draw()
    zombieManager.Draw()
    gunManager.Draw()

    -- Set background color
    love.graphics.setColor(255, 255, 255, 255)
end

return levelManager