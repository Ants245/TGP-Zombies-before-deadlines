log = require('plugins/Log')

zombie = {}

----------------------------------------
-- Core methods
----------------------------------------
function zombie.Load(numZombies)
    log.info("[INIT]: Loading zombie data...")

    zombie = spriteManager.sprites.entities.zombie
    zombieRun = spriteManager.sprites.entities.zombieFast

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

------------------------------------------------------------
-- Table of enemys not tracking properly, they move in one direction 
-- (using the same method as the single tracking object that uses 2D vectors)
-------------------------------------------------------------
function zombie.Update(dt)
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
end

function zombie.Draw()
    for i, b in pairs(Enemy) do 
        local angle = math.atan2(playerManager.GetPlayerVector():getY() - b.y, playerManager.GetPlayerVector():getX() - b.x)
        love.graphics.draw(b.image, b.x, b.y, angle,1,1, b.image:getWidth()/2, b.image:getHeight()/2)
    end
end

----------------------------------------
-- Getters and setters
----------------------------------------

return zombie