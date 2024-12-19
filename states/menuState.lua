-- menuState.lua

local menuState = {}
local levelOne = require("states/levelOne")
function menuState:enter()
  print("Entering Menu State")
end

function menuState:update(dt)
end
    
function menuState:draw()
  love.graphics.printf("Welcome to the game!", 0, 200, love.graphics.getWidth(), "center")
  love.graphics.printf("Press Enter to Start", 0, 300, love.graphics.getWidth(), "center")
end
    
function menuState:keyreleased(key, code)
  if key == 'return' then
      Gamestate.switch(levelOne)
  end
end

return menuState