-- Plugins
shack = require('plugins/Shack')
debugger = require('lib/debugger')

-- Managers
spriteManager = require('lib/managers/spriteManager')
audioManager = require('lib/managers/audioManager')
screenManager = require('lib/managers/screenManager')

-- Import screens
mainMenu = require('screens/mainMenu')
level_1 = require('screens/level_1')

-- Initialize debugger math helper
debugger.fpsMath()

-- Love2D Initialization
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

  -- Initialize screens
  mainMenu.Load()
  level_1.Load(500, 0.05)
end

-- Love2D Key press check
function love.keypressed(key)
  -- Debugger graph toggle
  debugger.keypressed(key, "f12")

  mainMenu.KeyPressed(key)

  if (key == "f") then
    shack:setShake(20)
  end

  if (key == "1") then
    audioManager.Play(audioManager.sounds.ui.click1)
  end
end

function love.mousepressed(x, y, button)
  mainMenu.MousePressed(x, y, button)
  levelManager.MousePressed(x, y, button)
end

-- Love2D Update
function love.update(dt)
  -- Shack update
  shack:update(dt)

  -- Screens update
  mainMenu.Update(dt)
  level_1.Update(dt)

  -- Debug graph update
  debugger.Update(dt)
end

-- Love2D Draw
function love.draw()
  -- Draw shack
  shack:apply()

  -- Screens draw
  mainMenu.Draw()

  -- Draw Debug Graph
  -- MUST be last to make top layer
  debugger.Draw()
end