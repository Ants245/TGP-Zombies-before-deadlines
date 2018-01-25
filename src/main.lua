-- Imports
shack = require('lib/plugins/Shack') -- Screen shaking effects
debugger = require('lib/debugger')
assetLoader = require('lib/assetLoader')

-- Initialize debugger math helper
debugger.fpsMath()

-- Love2D Initialization
function love.load()

  -- Initialize Shack to game window dimensions
  shack:setDimensions(love.graphics.getDimensions())

  -- Initialize debug graph
  debugger.load()

  -- Initialize asset loader
  assetLoader.load()
end

-- Love2D Key press check
function love.keypressed(key)
  -- Debugger graph toggle
  debugger.keypressed(key, "f12")
end

-- Love2D Update
function love.update(dt)
  -- Debug graph update
  debugger.update(dt)
end

-- Love2D Draw
function love.draw()
  -- Toggle Debug Graph
  if(debugger.doDrawDebug == true) then
    debugger.draw()
  end
end