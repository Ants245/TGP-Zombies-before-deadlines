 -- Plugins
shack = require('plugins/Shack')
debugger = require('lib/debugger')

-- Managers
spriteManager = require('lib/managers/spriteManager')
audioManager = require('lib/managers/audioManager')
overlayManager = require('lib/managers/overlayManager')
screenManager = require('lib/managers/screenManager')

-- Initialize debugger math helper
debugger.fpsMath()

----------------------------------------
-- Love2D Initialization
----------------------------------------
function love.load()
  -- Initialize Shack to game window dimensions
  shack:setDimensions(love.graphics.getDimensions())

  -- Initialize assets
  spriteManager.Load()
  audioManager.Load()
  overlayManager.Load()
  screenManager.Load()

  -- Initialize debug graph
  debugger.Load()
  wheelX = 0
  wheelY = 0
end

----------------------------------------
-- Love2D Key press check
----------------------------------------
function love.keypressed(key)
  -- Debugger graph toggle
  debugger.keypressed(key, "f12")

  screenManager.KeyPressed(key)

  if (key == "f") then
    shack:setShake(20)
  end

  if (key == "p") then
    audioManager.Play(audioManager.sounds.ui.click1)
  end
end

----------------------------------------
-- Love2D Mouse press check
----------------------------------------
function love.mousepressed(x, y, button)
  -- mainMenu.MousePressed(x, y, button)
  levelManager.MousePressed(x, y, button)
end

----------------------------------------
-- Love2D Update
----------------------------------------
function love.update(dt)
  -- Shack update
  shack:update(dt)

  -- Screen manager update
  screenManager.Update(dt)

  -- Debug graph update
  debugger.Update(dt)
end


----------------------------------------
-- Love2D Draw
----------------------------------------
function love.draw()
  -- Draw shack
  shack:apply()
  -- Screen manager draw
  screenManager.Draw()

  -- Draw Debug Graph
  -- MUST be last to make top layer
  debugger.Draw()
end