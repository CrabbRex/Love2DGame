-- puaseState.lua

local pauseState = {}

function pauseState:new()
    print("PAUSED")
end

function pauseState:draw()
    love.graphics.printf("Game Paused", 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("Press P to Resume", 0, 300, love.graphics.getWidth(), "center")
end

function pauseState:keypressed(key)
    if key == "p" then
      GameStateManager:revertState()
    end
end

return pauseState