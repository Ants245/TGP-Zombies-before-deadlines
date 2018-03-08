-- Imports
spriteManager = require('lib/managers/spriteManager')
playerManager = require('lib/managers/playerManager')
zombieManager = require('lib/managers/zombieManager')

local bulletRPM, numZombies, mouseX, mouseY, shot, elapsedTime
local playerFrames = {}

levelManager = {}

----------------------------------------
-- Initializtion methods
----------------------------------------
function levelManager.Load(numZombieSpawn, bulletFireRate)
    -- Load crosshair
    target = spriteManager.sprites.ui.crosshair

    -- Create table for bullets to be stored in
    bullets = {}
    timeLastBullet = 0
    bulletRPM = bulletFireRate

    -- Sets num of zombies to spawn
    numZombies = numZombieSpawn

    -- Initialially set number of zombies left to spawn amount
    numZombiesLeft = numZombies

    -- Initialize Player
    playerManager.Load(playerFrames)

    -- Initialize Zombies
    zombieManager.Load(numZombies)

    -- Sets mouse to be invisible
    love.mouse.setVisible(not love.mouse.isVisible())

    -- Set mouseX / mouseY values to x / y position of mouse
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()

    -- Local var initialization
    shot = 0
    elapsedTime = 0
    roadHeight = 99
    speed = 6
    distance = 0
    distance2 = 0
    distance3 = 0
    currentFrameTime =0 
    speedDecresTime = 500
end

----------------------------------------
-- Device input methods
----------------------------------------
function levelManager.KeyPressed(key)
    -- Close the game if the escape key is pressed
    if(key == "escape") then
        love.event.quit()
    end
end

function levelManager.MousePressed(x, y, button)
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()
end

----------------------------------------
-- Utility methods
----------------------------------------
function CreateBullet(x,y)
  if love.timer.getTime() > timeLastBullet + bulletRPM then
    --Bullet can fire if enough time has passed
    local n = #bullets + 1
    bullets[n] = 
    {x = x, 
      y = y,    
      DirX = 0, 
      DirY = 0, 
      AngleX = mouseX - playerManager.GetPlayerVector():getX(), 
      AngleY = mouseY - playerManager.GetPlayerVector():getY(), 
      Distance = 0}
    timeLastBullet = love.timer.getTime()
  end
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function FinishlineCollision()
  for l, b in pairs(bullets) do
    for i, E in pairs(Enemy) do
      if CheckCollision(b.x,b.y,7,7, E.x,E.y,20,20) == true then ---work in progress
        table.remove(Enemy, i)
        E.x = 1000000
        E.y = 1000000
        numZombiesLeft = numZombiesLeft - 1
        table.remove(bullets, l)
      end
    end
  end
end

function levelManager.GetNumZombies()
    return numZombies
end

function levelManager.GetNumZombiesLeft()
    return numZombiesLeft
end

----------------------------------------
-- Update methods
----------------------------------------
function UpdateBullets(dt)
    if love.mouse.isDown(1)  then   
        shot = 1
        CreateBullet(playerManager.GetPlayerVector():getX(), playerManager.GetPlayerVector():getY())
        for i, b in pairs(bullets) do
            b.distance = math.sqrt((b.AngleX * b.AngleX) + (b.AngleY * b.AngleY))
            b.DirX = b.AngleX / b.distance
            b.DirY = b.AngleY / b.distance
        end
    end

    elapsedTime = elapsedTime + dt

    if shot > 0 then
        if(elapsedTime > 0.05) then
            if(currentFrame < 5) then
                currentFrame = currentFrame + 1
            else
                currentFrame = 1
                shot = 0
            end
            activeFrame = playerFrames[currentFrame]
            elapsedTime = 0
        end
    end
end

function levelManager.Update(dt)
    for i, b in pairs(bullets) do
        --b.x = b.x + b.dir * b.speed * dt
        b.x = b.x + (b.DirX * 15)
        b.y = b.y + (b.DirY* 15)
    end

    currentFrameTime = currentFrameTime + dt
    if(currentFrameTime > speedDecresTime) then
        if(speedX > 0) then
            speedX = speedX * 0.7
        else
            speedX = 0.0
        end
        currentFrameTime = 0
    end

    -- Set mouseX / mouseY values to x / y position of mouse every tick
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()

    playerManager.Update(dt)
    zombieManager.Update(dt)
    UpdateBullets(dt)
end

----------------------------------------
-- Draw methods
----------------------------------------
function levelManager.Draw()

    playerManager.Draw(mouseX, mouseY)
    zombieManager.Draw()

    -- Set background color
    love.graphics.setColor(255, 255, 255, 255) 

    -- Draw crosshair
    love.graphics.draw(target,mouseX,mouseY,0,1,1, target:getWidth()/2, target:getHeight()/2)

    -- Draw bullets
    for i, b in pairs(bullets) do
        love.graphics.rectangle("fill", b.x,b.y, 7, 7 ) -- work in progress
    end

    FinishlineCollision()
end

return levelManager