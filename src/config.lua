function love.conf(c)
  -- Sets window title
  c.title = "Zombies Before Deadlines"

  -- Set to true to enable console on launch
  c.console = true

  local window = c.screen or c.window -- love 0.9 renamed "screen" to "window"
  window.width = 720/2 -- Set window width to 720/2(360)
  window.height = 1280/2 -- Set window height to 1280/2(640)
  window.vsync = false -- Disable V-Sync
  window.highdpi = true -- Enable High DPI mode
  window.msaa = 4 -- Sets msaa sampling to 4
end