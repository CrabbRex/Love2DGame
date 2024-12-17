-- menuState.lua
--[[
local menuState = {}

function menuState:load()
    print("Entering Menu State.")
end



function menuState:draw()
    love.graphics.printf("Welcome to the game!", 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("Press Enter to Start", 0, 300, love.graphics.getWidth(), "center")
end

function menuState:update(dt)
end

function menuState:keypressed(key)
    if key == "return" then
      setScene(level1)
    end
end
return menuState]]--