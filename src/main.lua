-- Plugins
shack = require('plugins/Shack')
debugger = require('lib/debugger')

-- Managers
spriteManager = require('lib/spriteManager')
audioManager = require('lib/audioManager')

-- Config options
config = require('conf')

-- Initialize debugger math helper
debugger.fpsMath()

-- Love2D Initialization
function love.load()
  -- Initialize Shack to game window dimensions
  shack:setDimensions(love.graphics.getDimensions())

  -- Initialize debug graph
  debugger.Load()

  -- Initialize assets
  spriteManager.Load()
  audioManager.Load()
end

-- Love2D Key press check
function love.keypressed(key)
  -- Debugger graph toggle
  debugger.keypressed(key, "f12")

  -- Toggle fullscreen
  if (key == "f11") then
    config.toggleFullscreen()
  end

  if (key == "f") then
    shack:setShake(20)
  end

  if (key == "1") then
    audioManager.Play(audioManager.sounds.ui.click1)
  end
end

-- Love2D Update
function love.update(dt)
  -- Debug graph update
  debugger.Update(dt)

  -- Shack update
  shack:update(dt)

  spriteManager.Update(dt)
end

-- Love2D Draw
function love.draw()
  -- Draw shack
  shack:apply()

  -- Draw sprites
  spriteManager.Draw()

  -- Draw Debug Graph
  -- MUST be last to make top layer
  debugger.Draw()
end