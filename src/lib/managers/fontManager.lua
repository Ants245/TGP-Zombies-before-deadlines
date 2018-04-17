log = require('plugins/Log')

fontManager = {}
fontManager.fonts = {}

local assetsFontsPath = "assets/fonts/"

----------------------------------------
-- Sprite Manager Initializtion
----------------------------------------
function fontManager.Load()
  log.info("[INIT]: Loading fonts...")
  fontManager.fonts.rockSalt = love.graphics.newFont(assetsFontsPath .. "RockSalt-Regular.ttf", 20)
  fontManager.fonts.rockSaltBig = love.graphics.newFont(assetsFontsPath .. "RockSalt-Regular.ttf", 64)
end

return fontManager