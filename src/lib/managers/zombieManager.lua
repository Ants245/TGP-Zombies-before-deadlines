log = require('plugins/Log')

zombieManager = {}

----------------------------------------
-- Zombie Manager Initializtion
----------------------------------------
function zombieManager.Load(numZombies)
    log.info("[INIT]: Loading zombie data...")

    zombie = spriteManager.sprites.entities.zombie
    zombieRun = spriteManager.sprites.entities.zombieFast
    largeZombie = spriteManager.sprites.entities.zombieLarge

    Enemy = {}

    for i=0,slowZombieNum do
        CreateEnemy(2,zombie,1,10)
    end

    for i=0,fastZombieNum do
        CreateEnemy(5,zombieRun,1,8)
    end  

    for i=0,largeZombieNum do
        CreateEnemy(1.5,largeZombie,4,1)
    end

    wheelx = 10
end

----------------------------------------
-- Zombie Manager Utility methods
----------------------------------------
function CreateEnemy(_speed, _image, _health, _DropChance)
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
  
  local n = #Enemy + 1

  Enemy[n] = {
    health = _health,
    speed = _speed,
    image = _image,
    x = ranNumX,
    y = ranNumY,
    DirX = 0,
    DirY = 0,
    AngleX = 0,
    AngleY = 0,
    distance = 0,
    sector = sector,
    chance = _DropChance
  }
end

function RandomLocation()
  local ranNumX = 0
  local ranNumY = 0

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

  return ranNumX,ranNumY
end

function PlayerCollision()
  for i, e in pairs(Enemy) do 
    if CheckCollision(playerManager.GetPlayerVector():getX(),playerManager.GetPlayerVector():getY(),5,5, e.x,e.y,5,5) == true then
      if playerHealth > 0 then
        playerHealth = playerHealth - 1
      end
    end
  end
end

------------------------------------------------------------
-- Zombie Manager Update
-- Table of enemys not tracking properly, they move in one direction 
-- (using the same method as the single tracking object that uses 2D vectors)
-------------------------------------------------------------
function zombieManager.Update(dt)
    for i, b in pairs(Enemy) do
        b.AngleX = playerManager.GetPlayerVector():getX() - b.x
        b.AngleY = playerManager.GetPlayerVector():getY() - b.y
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
    
    PlayerCollision()
end

----------------------------------------
-- Zombie Manager Draw
----------------------------------------
function zombieManager.Draw()
    for i, b in pairs(Enemy) do
        local angle = math.atan2(playerManager.GetPlayerVector():getY() - b.y, playerManager.GetPlayerVector():getX() - b.x)
        love.graphics.draw(b.image, b.x, b.y, angle,1,1, b.image:getWidth()/2, b.image:getHeight()/2)
    end
    love.graphics.print(wheelx,40,20)
end

return zombieManager