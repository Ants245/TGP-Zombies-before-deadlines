
local Vector = require("lib/vector")
local vec2 = require("lib/vector2D")

level_1 = {}

function level_1.Load(numZombieSpawn, bulletFireRate)
  frames = {}
  activeFrame = 0
  currentFrame = 01

  Player = love.graphics.newImage("assets/sprites/entities/player/playerSpritesheet.png")
  frames[1] = love.graphics.newQuad(0, 25, 14, 23, Player:getDimensions())
  frames[2] = love.graphics.newQuad(14, 25, 14, 23, Player:getDimensions())
  frames[3] = love.graphics.newQuad(28, 25, 14, 23, Player:getDimensions())
  frames[4] = love.graphics.newQuad(42, 25, 14, 23, Player:getDimensions())
  frames[5] = love.graphics.newQuad(56, 25, 14, 23, Player:getDimensions())
  activeFrame = frames[currentFrame]

  player = Vector.Vector2D(100,100)

  zombie = love.graphics.newImage("assets/sprites/entities/zombie/Zombie.png")
  zombieRun = love.graphics.newImage("assets/sprites/entities/zombie/ZombieRun.png")
  target = love.graphics.newImage("assets/sprites/crosshair.png")

  bullets = {}
  --Needed to create the table
  timeLastBullet = 0
  timeBetweenBullets = bulletFireRate
  
  zombieAmount = numZombieSpawn
  zombiesLeft = zombieAmount
  --Set this lower for rapid bullets or higher for slower firing

  local state = not love.mouse.isVisible()   -- the opposite of whatever it currently is
  love.mouse.setVisible(state)

  Enemy = {}

  for i=0, zombieAmount do

    local ranNumX = 0
    local ranNumY = 0
    local sector = math.random(4)

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
    
    local speed = math.random(30)
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
  ---------------------------------------

  RoadHeight = 99
  test1 = 0
  speed = 6
  distance = 0
  distance2 = 0
  distance3 = 0
  CurrentFrameTime =0 
  SpeedDecresTime = 500
end

function level_1.KeyPressed(key)
  if  key == "escape" then
    love.event.quit(Close:play())
  end
end

function createBullet(x,y)
  local mouseX, mouseY = love.mouse.getPosition()
  if love.timer.getTime() > timeLastBullet + timeBetweenBullets then
    --Bullet can fire if enough time has passed
    local n = #bullets + 1
    bullets[n] = 
    {x = x, 
      y = y,    
      DirX = 0, 
      DirY = 0, 
      AngleX = mouseX - player:getX(), 
      AngleY = mouseY - player:getY(), 
      Distance = 0}
    timeLastBullet = love.timer.getTime()
  end
end

function level_1.MousePressed(x,y,button)
  local mouseX, mouseY = love.mouse.getPosition()
end

local shot = 0
local elapsedTime = 0
function level_1.Update(dt)
  for i, b in pairs(bullets) do
    --b.x = b.x + b.dir * b.speed * dt
    b.x = b.x + (b.DirX * 15)
    b.y = b.y + (b.DirY* 15)
  end

  CurrentFrameTime = CurrentFrameTime + dt
  if CurrentFrameTime > SpeedDecresTime then

    if SpeedX > 0 then
      SpeedX = SpeedX * 0.7
    else
      SpeedX = 0.0
    end

    CurrentFrameTime = 0
  end

  local mouseX, mouseY = love.mouse.getPosition()

  ------------------------------------------------------------
  -- Table of enemys not tracking properly, they move in one direction 
  -- (using the same method as the single tracking object that uses 2D vectors)
  -------------------------------------------------------------
  for i, b in pairs(Enemy) do
    b.AngleX = player:getX() - b.x
    b.AngleY = player:getY() - b.y
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

  ---------------------------------------------
  -- bullets,  click mouse 1
  ---------------------------------------------
  if love.mouse.isDown(1)  then   
    shot = 1
    createBullet(player:getX(), player:getY())
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
      activeFrame = frames[currentFrame]
      elapsedTime = 0
    end
  end

  ----------------------
  -- Player movement
  ----------------------
  if love.keyboard.isDown("d") then
    player:setX(player:getX() + 4.2)
  end
  if love.keyboard.isDown("a") then
    player:setX(player:getX() - 4.2)
  end
  if love.keyboard.isDown("s") then
    player:setY(player:getY() + 4.2)
  end
  if love.keyboard.isDown("w") then
    player:setY(player:getY() - 4.2)
  end
end

function FinishlineCollision()
  for l, b in pairs(bullets) do
    for i, E in pairs(Enemy) do
      if CheckCollision(b.x,b.y,7,7, E.x,E.y,20,20) == true then ---work in progress
        table.remove(Enemy, i)
        E.x = 1000000
        E.y = 1000000
        zombiesLeft = zombiesLeft - 1
        table.remove(bullets, l)
      end
    end
  end
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
  x2 < x1+w1 and
  y1 < y2+h2 and
  y2 < y1+h1
end

function level_1.Draw()
  local mouseX, mouseY = love.mouse.getPosition()
  local playerAngle = math.atan2(mouseY - player:getY(), mouseX - player:getX()) + (math.pi/2)
  love.graphics.draw(Player,activeFrame, player:getX(), player:getY(),playerAngle)
  
  love.graphics.draw(target,mouseX,mouseY,0,1,1, target:getWidth()/2, target:getHeight()/2)

  love.graphics.print(mouseX, 10,10)
  love.graphics.print(mouseY, 10,30)
  
  love.graphics.print(zombieAmount, 980,20, 0,2) 
  love.graphics.print(" / " , 1040, 20,0 ,2)
  love.graphics.print(zombiesLeft, 1062, 20, 0,2)
  
  love.graphics.setColor(255, 255, 255, 255) 

  for i, b in pairs(Enemy) do 
    local angle = math.atan2(player:getY() - b.y, player:getX() - b.x)
    love.graphics.draw(b.image, b.x, b.y, angle,1,1, b.image:getWidth()/2, b.image:getHeight()/2)
  end
  for i, b in pairs(bullets) do
    love.graphics.rectangle("fill", b.x,b.y, 7, 7 ) -- work in progress
  end

  FinishlineCollision()
end

return level_1