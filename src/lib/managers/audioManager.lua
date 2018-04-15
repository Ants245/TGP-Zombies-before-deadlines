log = require('plugins/Log')

audioManager = {}
audioManager.sounds = {}
audioManager.sounds.ui = {}
audioManager.sounds.voiceover = {}
audioManager.sounds.guns = {}

local assetsSoundsPath = "assets/sounds/"

----------------------------------------
-- Audio Initialization
----------------------------------------
function audioManager.Load()
  log.info("[INIT]: Loading audio...")

  -- Set window volume to 100%
  love.audio.setVolume(1)

  audioManager.sounds.voiceover.begin = love.audio.newSource(assetsSoundsPath .. "voiceover/begin.ogg")
  audioManager.sounds.voiceover.game_over = love.audio.newSource(assetsSoundsPath .. "voiceover/game_over.ogg")

  audioManager.sounds.guns.fire = love.audio.newSource(assetsSoundsPath .. "guns/pistol.mp3")
end

----------------------------------------
-- Utility Methods
----------------------------------------
function audioManager.Play(path)
  love.audio.play(path)
end

return audioManager