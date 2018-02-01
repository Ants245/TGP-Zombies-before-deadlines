assetLoader = require('lib/assetLoader')

audioManager = {}
audioManager.sounds = {}

function GetUISound(path)
  return assetLoader.Audio.Stream.ui .. path
end

function GetVoiceOverSound(path)
  return assetLoader.Audio.Stream.voiceover .. path
end

-- UI sounds
audioManager.sounds.ui.click1 = GetUISound(click1)
audioManager.sounds.ui.click2 = GetUISound(click2)
audioManager.sounds.ui.click3 = GetUISound(click3)
audioManager.sounds.ui.click4 = GetUISound(click4)
audioManager.sounds.ui.click5 = GetUISound(click5)

-- Play sound
function audioManager.Play(sound)
  love.audio.play(sounds.sound)
end

return audioManager