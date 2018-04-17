log = require('plugins/Log')

audioManager = {}
audioManager.sounds = {}
audioManager.sounds.voiceover = {}
audioManager.sounds.music = {}
audioManager.sounds.entities = {}
audioManager.sounds.entities.player = {}
audioManager.sounds.entities.player.guns = {}
audioManager.sounds.entities.zombie = {}

local assetsSoundsPath = "assets/sounds/"

----------------------------------------
-- Audio Initialization
----------------------------------------
function audioManager.Load()
  log.info("[INIT]: Loading audio...")

  -- Set window volume to 100%
  love.audio.setVolume(1)

  -- Voiceover
  audioManager.sounds.voiceover.begin = love.audio.newSource(assetsSoundsPath .. "voiceover/begin.ogg")
  audioManager.sounds.voiceover.game_over = love.audio.newSource(assetsSoundsPath .. "voiceover/game_over.ogg")

  -- Music
  audioManager.sounds.music.gameplay_music = love.audio.newSource(assetsSoundsPath .. "music/gameplay_music.ogg")

  -- Player sounds
  audioManager.sounds.entities.player.guns.fire = love.audio.newSource(assetsSoundsPath .. "entities/player/guns/pistol.mp3")

  -- Zombie sounds
  audioManager.sounds.entities.zombie.zombie_death = love.audio.newSource(assetsSoundsPath .. "entities/zombie/zombie_death.mp3")
end

----------------------------------------
-- Audio Utility Methods
----------------------------------------
function audioManager.Play(path)
  love.audio.play(path)
end

return audioManager