spriteManager = require('lib/managers/spriteManager')
playerManager = require('lib/managers/playerManager')
zombieManager = require('lib/managers/zombieManager')
audioManager =  require('lib/managers/audioManager')
log = require('plugins/Log')

local bulletRPM, numZombies, mouseX, mouseY, shot, elapsedTime
local playerFrames = {}

gunManager = {}

----------------------------------------
-- Gun Manager Initializtion
----------------------------------------
function gunManager.Load(gunSelect)
  log.info("[INIT]: Loading Gun manager...")

  -- Load crosshair
  target = spriteManager.sprites.ui.crosshair
  ammoPickup = spriteManager.sprites.ui.ammoPickup
  gunSelection = spriteManager.sprites.weapons.tempGunSelection
  gunSelected = spriteManager.sprites.ui.gunSelection
  bullet = spriteManager.sprites.weapons.bullet
  AmmoLeft = spriteManager.sprites.ui.AmmoLeft
  Reloading = spriteManager.sprites.ui.Reloading

  reloadingToggle = false
  gunSelectedX = 460

  -- Load gun audio/set audio volume
  gunSound = audioManager.sounds.guns.fire
  gunSound:setVolume(0.1)

  -- Gun default
  Ammo = 100
  GunMag = 0
  Guns = {}
  reloadAmmoStore = 0
  reloadRepeat = 0
  reloading = false

  timeSinceStart = love.timer.getTime()
  timeBetweenReload = 2.0

  for i=0,3 do
    if i == 0 then
      Guns[i] = {}
      Guns[i].make = "Pistol"
      Guns[i].speed = 0.5
      Guns[i].magSize = 15
      Guns[i].damage = 1
      Guns[i].ammo = 50
      Guns[i].mag = 15
    end
    if i == 1 then
      Guns[i] = {}
      Guns[i].make = "Assult Rifle"
      Guns[i].speed = 0.1
      Guns[i].magSize = 30
      Guns[i].damage = 1
      Guns[i].ammo = 50
      Guns[i].mag = 30
    end
    if i == 2 then
      Guns[i] = {}
      Guns[i].make = "Minigun"
      Guns[i].speed = 0.05
      Guns[i].magSize = 50
      Guns[i].damage = 1
      Guns[i].ammo = 50
      Guns[i].mag = 50
    end

  end

  CurrentGun = Guns[0]
  magLoad()

  BulletDistance = 0

  -- Create table for bullets to be stored in
  bullets = {}
  timeLastBullet = 0

  AmmoDrops = {}

  -- Set mouseX / mouseY values to x / y position of mouse
  mouseX = love.mouse.getX()
  mouseY = love.mouse.getY()

  scrollWheelX =0 
end

----------------------------------------
-- Gun Manager Utility methods
----------------------------------------
function magLoad()
  CurrentGun.mag = CurrentGun.mag + reloadAmmoStore
  reloadAmmoStore = 0

  --while(GunMag < (CurrentGun.magSize - GunMag)) do
  for i = 1, (CurrentGun.magSize - CurrentGun.mag) do
    if CurrentGun.ammo > 0 then
      CurrentGun.mag = CurrentGun.mag + 1
      CurrentGun.ammo = CurrentGun.ammo - 1
    else
      break
    end
  end
  reloadRepeat = 0
end

function DropAmmo(x,y)
  local n = #AmmoDrops + 1  
  AmmoDrops[n] = { x = x, y = y }
end

function gunManager.ChangeGun(gun)
  CurrentGun = Guns[gun]
  if gun == 0 then
    gunSelectedX = 460
  end
  if gun == 1 then
    gunSelectedX = 590
  end
  if gun == 2 then
    gunSelectedX = 710
  end
end

function CreateBullet(x,y)
  if love.timer.getTime() > timeLastBullet + CurrentGun.speed then
    --Bullet can fire if enough time has passed
    if gunSound:isPlaying() then
      gunSound:stop()
      gunSound:play()
    else
      gunSound:play()
    end
    CurrentGun.mag = CurrentGun.mag - 1
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

function BulletCollision()
  for l, b in pairs(bullets) do
    for i, E in pairs(Enemy) do
      if CheckCollision(b.x,b.y,7,7,E.x,E.y,20,20) == true then ---work in progress
        BulletDistance = distanceCheck(love.graphics.getWidth() /2,  love.graphics.getHeight() /2, b.x, b.y)
        if BulletDistance < 600 then
          local dropChance = math.random(1,E.chance)
          E.health = E.health - CurrentGun.damage
          if E.health <= 0 then 
            zombieManager.CreateDeathSprite(E.x,E.y)
            table.remove(Enemy, i)
            numZombiesLeft = numZombiesLeft - 1
            if dropChance == 1 then
              DropAmmo(E.x, E.y)
            end
          end
          table.remove(bullets, l)
        end
      end
    end
  end
end

function DropCollision()
  for i, e in pairs(AmmoDrops) do 
    if CheckCollision(playerManager.GetPlayerVector():getX(),playerManager.GetPlayerVector():getY(),14,23, e.x,e.y,20,20) == true then
      table.remove(AmmoDrops, i)
      CurrentGun.ammo = CurrentGun.ammo + 10
    end
  end
end

----------------------------------------
-- Gun Manager Update methods
----------------------------------------
function UpdateBullets(dt)
  if love.mouse.isDown(1)  then 
    if CurrentGun.mag > 0 then
      timeSinceStart  = love.timer.getTime()
      CreateBullet(playerManager.GetPlayerVector():getX(), playerManager.GetPlayerVector():getY())
      for i, b in pairs(bullets) do
        b.distance = math.sqrt((b.AngleX * b.AngleX) + (b.AngleY * b.AngleY))
        b.DirX = b.AngleX / b.distance
        b.DirY = b.AngleY / b.distance
      end
      reloadRepeat = 0
    else
    end
  end 
  if CurrentGun.mag == 0 then
    if love.timer.getTime() > timeSinceStart + timeBetweenReload then
      magLoad()
      reloading = false
      timeSinceStart  = love.timer.getTime()
    else
      if CurrentGun.ammo > 0 then
        reloading = true
      end
    end
  end

end

function gunManager.Reload()
  if reloadRepeat == 0 then
    if GunMag < CurrentGun.magSize then
      reloadAmmoStore = CurrentGun.mag
      CurrentGun.mag = 0 
    end
  end
  reloadRepeat = 1
end

function gunManager.Update(dt)
  UpdateBullets(dt)
  BulletCollision()
  DropCollision()

  mouseX = love.mouse.getX()
  mouseY = love.mouse.getY()

  for i, b in pairs(bullets) do
    b.x = b.x + (b.DirX * 15)
    b.y = b.y + (b.DirY* 15)
  end
  gunManager.ChangeGun(scrollWheelX)
end

function distanceCheck( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end

function love.wheelmoved(x, y)
  if y > 0 then
    scrollWheelX = scrollWheelX - 1
    if scrollWheelX < 0 then
      scrollWheelX = 2
    end
  elseif y < 0 then
    scrollWheelX = scrollWheelX + 1
    if scrollWheelX > 2 then
      scrollWheelX = 0
    end
  end
end

function gunManager.Draw()
  -- Draw crosshair
  love.graphics.draw(target,mouseX,mouseY,0,1,1, target:getWidth()/2, target:getHeight()/2)
  love.graphics.print(CurrentGun.mag, 736,20, 0)
  love.graphics.print(" / " , 770, 20,0 )
  love.graphics.print(CurrentGun.ammo, 792, 20, 0)
  love.graphics.draw(AmmoLeft, 619,23,0 ,0.2,0.2)
  if reloading == true then
    love.graphics.draw(Reloading,450,109)
  end
  -- Draw bullets
  for i, b in pairs(bullets) do
    love.graphics.draw(bullet, b.x,b.y, 0, 1.7,1.0 ) -- work in progress
  end

  for u, j in pairs(AmmoDrops) do 
    love.graphics.draw(ammoPickup,j.x,j.y)
  end

  love.graphics.setColor(255, 255, 255, 50) -- red, green, blue, opacity (this would be white with 20% opacity)
  love.graphics.draw(gunSelected, gunSelectedX, 630)
  love.graphics.setColor(255, 255, 255)

  love.graphics.draw(gunSelection, 460, 625)
end

function TEMPHOLD()
  if Ammo < CurrentGun.magSize then
    GunMag = GunMag + reloadAmmoStore
    reloadAmmoStore = 0
    for i = CurrentGun.magSize - GunMag, 1,1 do
      if Ammo > 0 then
        GunMag = GunMag + 1
        Ammo = Ammo -1
      else
        break
      end
    end
  else   
    while(GunMag < CurrentGun.magSize) do
      GunMag = GunMag + reloadAmmoStore
      reloadAmmoStore = 0
      if Ammo > 0 then
        GunMag = GunMag + 1
        Ammo = Ammo - 1
      end
    end
  end
end

return gunManager