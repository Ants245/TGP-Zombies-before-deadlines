-- Import plugins
debugGraph = require('plugins/DebugGraph')
log = require('plugins/Log')

debugger = {}

-- Returns 'n' rounded to the nearest 'deci'th (defaulting whole numbers).
function debugger.fpsMath()
  function math.round(n, deci)
    deci = 10^(deci or 0)
    return math.floor(n*deci+.5) / deci
  end
end

----------------------------------------
-- Debugger Initialization
----------------------------------------
function debugger.Load()
  log.info("[INIT]: Loading debugger...")

  doDrawDebug = false
  fpsGraph = debugGraph:new('fps', 10, 10, 335)
  memGraph = debugGraph:new('mem', 10, 40, 335)
  dtGraph = debugGraph:new('custom', 10, 70, 335)
end

----------------------------------------
-- Debugger Key press check
----------------------------------------
function debugger.keypressed(key, debugKey)
  if (key == debugKey) then
    log.info("[DEBUGGER]: Toggling debug graph")
    doDrawDebug = not doDrawDebug
  end
end

----------------------------------------
-- Debugger Update
----------------------------------------
function debugger.Update(dt)
  -- Update the graphs
  fpsGraph:update(dt)
  memGraph:update(dt)

  -- Update our custom graph
  dtGraph:update(dt, math.floor(dt * 1000))
  dtGraph.label = 'DT: ' ..  math.round(dt, 4)
end

----------------------------------------
-- Debugger Draw
----------------------------------------
function debugger.Draw()
  if(doDrawDebug == true) then
    fpsGraph:draw()
    memGraph:draw()
    dtGraph:draw()
  end
end

return debugger