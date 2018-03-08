screenManager = require('lib/managers/screenManager')

mainMenu = {}

function mainMenu.Load()
    screenManager.Load()
end

function mainMenu.KeyPressed(key)
    if(key == 't') then
        screenManager.SwitchState('screens/level_1')
    end
end

function mainMenu.MousePressed(x, y, button)

end

function mainMenu.Update(dt)

end

function mainMenu.Draw()
    
end

return mainMenu