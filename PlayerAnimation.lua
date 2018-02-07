local imageFile
local frames = {}
local activeFrame
local currentFrame = 1

function love.load()
  Player = love.graphics.newImage("sprites/playerSpritesheet.png")
  -- Pistol sprites
  frames[1] = love.graphics.newQuad(0, 25, 14, 23, Player:getDimensions())
  frames[2] = love.graphics.newQuad(14, 25, 14, 23, Player:getDimensions())
  frames[3] = love.graphics.newQuad(28, 25, 14, 23, Player:getDimensions())
  frames[4] = love.graphics.newQuad(42, 25, 14, 23, Player:getDimensions())
  frames[5] = love.graphics.newQuad(56, 25, 14, 23, Player:getDimensions())
  -- Shotgun sprites
  frames[6] = love.graphics.newQuad(0, 0, 14, 24, Player:getDimensions())
  frames[7] = love.graphics.newQuad(14, 0, 14, 24, Player:getDimensions())
  frames[8] = love.graphics.newQuad(28, 0, 14, 24, Player:getDimensions())
  frames[9] = love.graphics.newQuad(42, 0, 14, 24, Player:getDimensions())
  frames[10] = love.graphics.newQuad(56, 0, 14, 24, Player:getDimensions())
  -- Baseball bat sprites
  frames[11] = love.graphics.newQuad(0, 49, 23, 21, Player:getDimensions())
  frames[12] = love.graphics.newQuad(23, 49, 23, 21, Player:getDimensions())
  frames[13] = love.graphics.newQuad(46, 49, 23, 21, Player:getDimensions())
  frames[14] = love.graphics.newQuad(69, 49, 23, 21, Player:getDimensions())
  frames[15] = love.graphics.newQuad(92, 49, 23, 21, Player:getDimensions())
  
  activeFrame = frames[currentFrame]
  print(select(4,activeFrame:getViewport())/2)
end


function love.draw()
  love.graphics.draw(Player,activeFrame,
    love.graphics.getWidth()/2 - ({activeFrame:getViewport()})[3]/2 * 4,
    love.graphics.getHeight()/2 - ({activeFrame:getViewport()})[4]/2 * 4)

end
local shot = 0
local elapsedTime = 0
function love.update(dt)
  if love.mouse.isDown(1) then
    shot = 1
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
end