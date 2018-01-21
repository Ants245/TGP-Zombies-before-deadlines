-- Imports
util = require('lib/util')

-- Initialize FPS math helper
util.fpsMath()

-- Love2D Key press check
function love.keypressed(key)
  -- Debug graph toggle
  util.fpsKeyToggle(key)
end

-- Love2D Update
function love.update(dt)
  -- Debug graph update
  util.fpsUpdate(dt)

end

-- Love2D Draw
function love.draw()

  -- Toggle Debug Graph
  if(util.doDrawDebug == true) then
    util.drawDebugGraph()
  end

end