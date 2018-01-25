-- Import plugins
loader = require('lib/plugins/AssetLoader') -- Asset Loader
log = require('lib/plugins/Log') -- Basic logging functionality

assetLoader = {}

-- Initialization
function assetLoader.load()
  log.info("[DEBUGGER]: Loading asset loader")

  loader.setBaseImageDir('assets/sprites')
  loader.setBaseAudioDir('assets/sounds')
  loader.setBaseFontDir('assets/fonts')
  loader.init() -- Do not forget this!
end

return assetLoader