log = require('plugins/Log')

audioManager = {}
audioManager.sounds = {}
audioManager.sounds.ui = {}
audioManager.sounds.voiceover = {}
audioManager.sounds.gun = {}

----------------------------------------
-- Audio Initialization
----------------------------------------
function audioManager.Load()
  log.info("[INIT]: Loading audio...")

  -- Set window volume to 100%
  love.audio.setVolume(1)

  audioManager.sounds.ui.click1 = love.audio.newSource("assets/sounds/ui/click1.ogg")
  audioManager.sounds.ui.click2 = love.audio.newSource("assets/sounds/ui/click2.ogg")
  audioManager.sounds.ui.click3 = love.audio.newSource("assets/sounds/ui/click3.ogg")
  audioManager.sounds.ui.click4 = love.audio.newSource("assets/sounds/ui/click4.ogg")
  audioManager.sounds.ui.click5 = love.audio.newSource("assets/sounds/ui/click5.ogg")
  
  audioManager.sounds.voiceover.one = love.audio.newSource("assets/sounds/voiceover/1.ogg")
  audioManager.sounds.voiceover.two = love.audio.newSource("assets/sounds/voiceover/2.ogg")
  audioManager.sounds.voiceover.three = love.audio.newSource("assets/sounds/voiceover/3.ogg")
  audioManager.sounds.voiceover.four = love.audio.newSource("assets/sounds/voiceover/4.ogg")
  audioManager.sounds.voiceover.five = love.audio.newSource("assets/sounds/voiceover/5.ogg")
  
  audioManager.sounds.gun.fire = love.audio.newSource("assets/sounds/Gun/pistol.mp3")
end

----------------------------------------
-- Utility Methods
----------------------------------------
function audioManager.Play(path)
  love.audio.play(path)
end

return audioManager