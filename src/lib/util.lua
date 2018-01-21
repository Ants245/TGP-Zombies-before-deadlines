-- Import plugins
debugGraph = require('lib/plugins/DebugGraph') -- Debugging statistics
log = require('lib/plugins/Log') -- Basic logging functionality
shack = require('lib/plugins/Shack') -- Screen shaking effects

util = {}

-- Love 2D functions

-- Initialization
function love.load()
  -- Logging
  log.info("[UTIL]: Initializing...")

  -- Set Shack to game dimensions
  shack:setDimensions(love.graphics.getDimensions())

  -- Load debug graph data
  doDrawDebug = false
  fpsGraph = debugGraph:new('fps', 10, 10, 335)
  memGraph = debugGraph:new('mem', 10, 40, 335)
  dtGraph = debugGraph:new('custom', 10, 70, 335)

end

-- Returns 'n' rounded to the nearest 'deci'th (defaulting whole numbers).
function util.fpsMath()
  function math.round(n, deci)
    deci = 10^(deci or 0)
    return math.floor(n*deci+.5) / deci
  end
end

-- FPS toggle | Toggle key default: F12
function util.fpsKeyToggle(key)
  if (key == "f12") then
    -- Logging
    log.info("[UTIL]: Toggling debug graph")

    if (doDrawDebug == false) then
      doDrawDebug = true
    elseif (doDrawDebug == true) then
      doDrawDebug = false
    end
  end
end

-- FPS update
function util.fpsUpdate(dt)
  -- Update the graphs
  fpsGraph:update(dt)
  memGraph:update(dt)

  -- Update our custom graph
  dtGraph:update(dt, math.floor(dt * 1000))
  dtGraph.label = 'DT: ' ..  math.round(dt, 4)
end

-- Draws debug graph
function util.drawDebugGraph()
  fpsGraph:draw()
  memGraph:draw()
  dtGraph:draw()
end

-- Basic collision checking
-- WIP | TODO: Upgrade
function util.checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

return util