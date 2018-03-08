-- Plugins
shack = require('plugins/Shack')

-- Managers
spriteManager = require('lib/managers/spriteManager')
audioManager = require('lib/managers/audioManager')
overlayManager = require('lib/managers/overlayManager')

-- Import levels
level_1 = require('levels/level_1')

-- Love2D Initialization
function love.load()
  -- Initialize Shack to game window dimensions
  shack:setDimensions(love.graphics.getDimensions())

  -- Initialize assets
  spriteManager.Load()
  audioManager.Load()
  overlayManager.Load()

  -- Initialize levels
  level_1.Load(500, 0.05)
end

-- Love2D Key press check
function love.keypressed(key)
  overlayManager.KeyPressed(key)

  -- Level 1 key press checks
  levelManager.KeyPressed(key)

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
  -- Update overlay
  overlayManager.Update(dt)

  -- Shack update
  shack:update(dt)

  -- Levels update
  level_1.Update(dt)
end

-- Love2D Draw
function love.draw()
  -- Draw shack
  shack:apply()

  -- Levels draw
  level_1.Draw()

  -- Draw overlay
  overlayManager.Draw()
end