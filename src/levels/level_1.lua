-- Imports
levelManager = require('levels/levelManager')

level_1 = {}

function level_1.Load()
  -- Load level manager
  levelManager.Load()
end

function level_1.Update(dt)
  -- Update level manager
  levelManager.Update(dt)
end

function level_1.Draw()
  -- Draw level manager
  levelManager.Draw()
end

return level_1