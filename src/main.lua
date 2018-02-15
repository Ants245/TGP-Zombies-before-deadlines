-- Plugins
shack = require('plugins/Shack')
debugger = require('lib/debugger')

-- Managers
spriteManager = require('lib/spriteManager')
audioManager = require('lib/audioManager')

-- Config options
config = require('conf')

-- Level 1 import
levelManager = require('levels/levelManager')

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

  -- Initialize level 1
  levelManager.Load(500, 0.05)
end

-- Love2D Key press check
function love.keypressed(key)
  -- Debugger graph toggle
  debugger.keypressed(key, "f12")

  -- Level 1 key press checks
  levelManager.KeyPressed(key)

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

function love.mousepressed(x, y, button)
  -- Check mouse movement/clicks
  levelManager.MousePressed(x, y, button)
end

-- Love2D Update
function love.update(dt)
  -- Debug graph update
  debugger.Update(dt)

  -- Shack update
  shack:update(dt)

  -- Update sprites
  spriteManager.Update(dt)

  -- Level 1 update
  levelManager.Update(dt)
end

-- Love2D Draw
function love.draw()
  -- Draw shack
  shack:apply()

  -- Draw sprites
  spriteManager.Draw()

  -- Level 1 draw
  levelManager.Draw()

  -- Draw Debug Graph
  -- MUST be last to make top layer
  debugger.Draw()
end