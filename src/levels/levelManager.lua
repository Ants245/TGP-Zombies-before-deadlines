-- Imports
local Vector = require("lib/vector")
local Vec2D = require("lib/vector2D")

local bulletRPM, numZombies, mouseX, mouseY, shot, elapsedTime
local playerFrames = {}

levelManager = {}

----------------------------------------
-- Initializtion methodsssss
----------------------------------------
function InitPlayer()
    activeFrame = 0
    currentFrame = 01

    Player = love.graphics.newImage("assets/sprites/entities/player/playerSpritesheet.png")
    playerFrames[1] = love.graphics.newQuad(0, 25, 14, 23, Player:getDimensions())
    playerFrames[2] = love.graphics.newQuad(14, 25, 14, 23, Player:getDimensions())
    playerFrames[3] = love.graphics.newQuad(28, 25, 14, 23, Player:getDimensions())
    playerFrames[4] = love.graphics.newQuad(42, 25, 14, 23, Player:getDimensions())
    playerFrames[5] = love.graphics.newQuad(56, 25, 14, 23, Player:getDimensions())
    activeFrame = playerFrames[currentFrame]

    playerVector = Vector.Vector2D(100,100)
end

function InitZombie()
    zombie = love.graphics.newImage("assets/sprites/entities/zombie/Zombie.png")
    zombieRun = love.graphics.newImage("assets/sprites/entities/zombie/ZombieRun.png")

    Enemy = {}

    for i=0, numZombies do
        local ranNumX = 0
        local ranNumY = 0
        local sector = math.random(4)
        local speed = math.random(30)

        if sector == 1 then
            ranNumX = math.random(-300, -9000)
            ranNumY = math.random(700)
        elseif sector == 2 then
            ranNumX = math.random(1400)
            ranNumY = math.random(-300, -9000)
        elseif sector == 3 then
            ranNumX = math.random(2000, 10000)
            ranNumY = math.random(700)
        elseif sector == 4 then
            ranNumX = math.random(1400)
            ranNumY = math.random(1000, 9700)
        end

        Enemy[i] = {}

        if speed == 1 then
            Enemy[i].speed = 5
            Enemy[i].image = zombieRun
        else
            Enemy[i].speed = 2
            Enemy[i].image = zombie
        end

        Enemy[i].x = ranNumX
        Enemy[i].y = ranNumY
        Enemy[i].DirX = 0
        Enemy[i].DirY = 0
        Enemy[i].AngleX = 0
        Enemy[i].AngleY = 0
        Enemy[i].distance = 0
        Enemy[i].sector = sector
    end
end

function levelManager.Load(numZombieSpawn, bulletFireRate)
    -- Load crosshair
    target = love.graphics.newImage("assets/sprites/crosshair.png")

    -- Create table for bullets to be stored in
    bullets = {}
    timeLastBullet = 0
    bulletRPM = bulletFireRate

    -- Sets num of zombies to spawn
    numZombies = numZombieSpawn

    -- Initialially set number of zombies left to spawn amount
    numZombiesLeft = numZombies

    -- Initialize Player
    InitPlayer()

    -- Initialize Zombies
    InitZombie()

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
        love.event.quit(Close:play())
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
      AngleX = mouseX - playerVector:getX(), 
      AngleY = mouseY - playerVector:getY(), 
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

----------------------------------------
-- Update methods
----------------------------------------
function UpdateZombies(dt)
    ------------------------------------------------------------
    -- Table of enemys not tracking properly, they move in one direction 
    -- (using the same method as the single tracking object that uses 2D vectors)
    -------------------------------------------------------------
    for i, b in pairs(Enemy) do
        b.AngleX = playerVector:getX() - b.x
        b.AngleY = playerVector:getY() - b.y
        b.distance = math.sqrt((b.AngleX * b.AngleX) + (b.AngleY * b.AngleY))
        b.DirX = (b.AngleX / b.distance)
        b.DirY = (b.AngleY / b.distance)

        if b.sector == 1 then
            if b.x < 0 then
                b.x = (b.x + (b.DirX * b.speed))
            else
                b.x = (b.x + (b.DirX * b.speed))
                b.y = (b.y + (b.DirY * b.speed))
            end
        elseif b.sector == 3 then
            if b.x > 1430 then  
                b.x = (b.x + (b.DirX * b.speed))
            else
                b.x = (b.x + (b.DirX * b.speed))
                b.y = (b.y + (b.DirY * b.speed))
            end
        elseif b.sector == 2 then
            if b.y < 0 then 
                b.y = (b.y + (b.DirY * b.speed))
            else
                b.x = (b.x + (b.DirX * b.speed))
                b.y = (b.y + (b.DirY * b.speed))
            end
        elseif b.sector == 4 then
            if b.y > 700 then
                b.y = (b.y + (b.DirY * b.speed))
            else
                b.x = (b.x + (b.DirX * b.speed))
                b.y = (b.y + (b.DirY * b.speed))
            end
        end
    end
end

function UpdateBullets(dt)
    if love.mouse.isDown(1)  then   
        shot = 1
        CreateBullet(playerVector:getX(), playerVector:getY())
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

function UpdatePlayerMovement()
    if love.keyboard.isDown("w") then
        playerVector:setY(playerVector:getY() - 4.2) -- Move Up
    end

    if love.keyboard.isDown("s") then
        playerVector:setY(playerVector:getY() + 4.2) -- Move Down
    end

    if love.keyboard.isDown("a") then
        playerVector:setX(playerVector:getX() - 4.2) -- Move Left
    end

    if love.keyboard.isDown("d") then
        playerVector:setX(playerVector:getX() + 4.2) -- Move Right
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

    UpdateZombies(dt)
    UpdateBullets(dt)
    UpdatePlayerMovement()

end

----------------------------------------
-- Draw methods
----------------------------------------
function DrawPlayer()
    local playerAngle = math.atan2(mouseY - playerVector:getY(), mouseX - playerVector:getX()) + (math.pi/2)
    love.graphics.draw(Player, activeFrame, playerVector:getX(), playerVector:getY(), playerAngle)
end

function DrawZombies()
    for i, b in pairs(Enemy) do 
        local angle = math.atan2(playerVector:getY() - b.y, playerVector:getX() - b.x)
        love.graphics.draw(b.image, b.x, b.y, angle,1,1, b.image:getWidth()/2, b.image:getHeight()/2)
    end
end

function levelManager.Draw()

    DrawPlayer()

    -- Draw crosshair
    love.graphics.draw(target,mouseX,mouseY,0,1,1, target:getWidth()/2, target:getHeight()/2)

    -- Draw score/zombies left text
    love.graphics.print(numZombies, 980,20, 0,2) 
    love.graphics.print(" / " , 1040, 20,0 ,2)
    love.graphics.print(numZombiesLeft, 1062, 20, 0,2)

    -- Set background color
    love.graphics.setColor(255, 255, 255, 255) 

    DrawZombies()

    -- Draw bullets
    for i, b in pairs(bullets) do
        love.graphics.rectangle("fill", b.x,b.y, 7, 7 ) -- work in progress
    end

    FinishlineCollision()
end

return levelManager