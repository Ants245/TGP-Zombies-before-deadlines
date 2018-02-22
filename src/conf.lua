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
  window.width = 1920 -- Set window width
  window.height = 1080 -- Set window height
  window.borderless = true -- Set window to borderless mode
  window.fullscreen = true -- Set window to fullscreen
  window.resizable = false -- Disable window resizable
end