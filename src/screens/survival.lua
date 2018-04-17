levelManager = require('lib/managers/levelManager')
audioManager = require('lib/managers/audioManager')
spriteManager = require('lib/managers/spriteManager')
overlayManager = require('lib/managers/overlayManager')
screenManager = require('lib/managers/screenManager')
screen = require('plugins/Screen')
log = require('plugins/Log')

survival = {}

-- Number of zombies to spawn
local slowZombieNum = 150
local fastZombieNum = 4
local largeZombieNum = 4

----------------------------------------
-- Create new screen
----------------------------------------
function survival.new()
    local self = screen.new()

    log.info("[INIT]: Loading survival...")

    screenManager.SetIsGameplay(true)

    -- Play "Begin" voiceover
    audioManager.Play(audioManager.sounds.voiceover.begin)
    
    gameplayMusic = audioManager.sounds.music.gameplay_music
    gameplayMusic:setVolume(0.15)
    
    audioManager.Play(gameplayMusic)

    -- Initialize level
    levelManager.Load(slowZombieNum, fastZombieNum, largeZombieNum)

    function self:update(dt)
        survival.Update(dt)
    end

    function self:draw()
        survival.Draw()
    end

    return self
end

----------------------------------------
-- Update method
----------------------------------------
function survival.Update(dt)
    -- Update level manager
    levelManager.Update(dt)

    -- Update overlay
    overlayManager.Update(dt)

    -- Check for gameover
    if(playerManager.GetPlayerHealth() == 0) then
        if(gameplayMusic:isPlaying() == true) then
            gameplayMusic:stop()
        end
        manager.switch('gameOver')
    end
end

----------------------------------------
-- Draw background image
----------------------------------------
function DrawBackground(posX, posY)
  -- Set sprite wrap mode to repeat(tile)
  spriteManager.sprites.backgrounds.survival:setWrap("mirroredrepeat", "mirroredrepeat")

  -- Draw sprite
  love.graphics.draw(spriteManager.sprites.backgrounds.survival, posX, posY)
end

----------------------------------------
-- Draw method
----------------------------------------
function survival.Draw()
  -- Draw background image
  DrawBackground()

  -- Draw level manager
  levelManager.Draw()

  -- Draw overlay
  overlayManager.Draw()
end

return survival