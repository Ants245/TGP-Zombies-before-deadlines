-- Import plugins
debugGraph = require('lib/plugins/DebugGraph') -- Debugging statistics
log = require('lib/plugins/Log') -- Basic logging functionality

debugger = {}

-- Returns 'n' rounded to the nearest 'deci'th (defaulting whole numbers).
function debugger.fpsMath()
  function math.round(n, deci)
    deci = 10^(deci or 0)
    return math.floor(n*deci+.5) / deci
  end
end

-- Initialization
function debugger.load()
  log.info("[DEBUGGER]: Loading debugger")

  doDrawDebug = false
  fpsGraph = debugGraph:new('fps', 10, 10, 335)
  memGraph = debugGraph:new('mem', 10, 40, 335)
  dtGraph = debugGraph:new('custom', 10, 70, 335)
end

function debugger.keypressed(key, debugKey)
  if (key == debugKey) then
    -- Logging
    log.info("[DEBUGGER]: Toggling debug graph")

    if (doDrawDebug == false) then
      doDrawDebug = true
    elseif (doDrawDebug == true) then
      doDrawDebug = false
    end
  end
end

function debugger.update(dt)
  -- Update the graphs
  fpsGraph:update(dt)
  memGraph:update(dt)

  -- Update our custom graph
  dtGraph:update(dt, math.floor(dt * 1000))
  dtGraph.label = 'DT: ' ..  math.round(dt, 4)
end

function debugger.draw()
  fpsGraph:draw()
  memGraph:draw()
  dtGraph:draw()
end

return debugger