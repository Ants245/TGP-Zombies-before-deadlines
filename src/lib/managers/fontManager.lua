log = require('plugins/Log')

fontManager = {}
fontManager.fonts = {}
fontManager.fonts.rockSalt = {}

local assetsFontsPath = "assets/fonts/"

----------------------------------------
-- Font Manager Initializtion
----------------------------------------
function fontManager.Load()
  log.info("[INIT]: Loading fonts...")

  fontManager.fonts.rockSalt = love.graphics.newFont(assetsFontsPath .. "RockSalt-Regular.ttf", 20)
end

return fontManager