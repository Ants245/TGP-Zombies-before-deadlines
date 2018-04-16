log = require('plugins/Log')

fontManager = {}
fontManager.fonts = {}
fontManager.fonts.rockSalt = {}
fontManager.fonts.rockSaltBig = {}

local assetsFontsPath = "assets/fonts/"

----------------------------------------
-- Sprite Manager Initializtion
----------------------------------------
function fontManager.Load()
  log.info("[INIT]: Loading fonts...")

  -- Fonts
  fontManager.fonts.rockSalt = love.graphics.newFont(assetsFontsPath .. "RockSalt-Regular.ttf", 20)
  fontManager.fonts.rockSaltBig = love.graphics.newFont(assetsFontsPath .. "RockSalt-Regular.ttf", 60)
end

return fontManager