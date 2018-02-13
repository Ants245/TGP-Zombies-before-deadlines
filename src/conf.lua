config = {}

function love.conf(c)
  -- Sets window title
  c.title = "Zombies Before Deadlines"

  -- Set to true to enable console on launch
  c.console = true

  local window = c.screen or c.window -- love 0.9 renamed "screen" to "window"
  window.minwidth = 720 -- Sets minimum window width
  window.minheight = 480 -- Sets minimum window height
  window.vsync = true -- Enable V-Sync
  window.highdpi = true -- Enable High DPI mode
  window.msaa = 4 -- Sets msaa sampling to 4

  isWindowFullscreen = false
  setFullscreenType(window)
end

function config.toggleFullscreen()
  isWindowFullscreen = not isWindowFullscreen
end

function setFullscreenType(window)
  if(isWindowFullscreen == true) then
    window.width = 1920
    window.height = 1080
    window.borderless = false
    window.fullscreen = true
    window.resizable = false
  else
    window.width = 1280
    window.height = 720
    window.borderless = false
    window.fullscreen = false
    window.resizable = true
  end
end

return config