-- puaseState.lua

local pauseState = {}

function pauseState:enter()
    print("PAUSED")
end

function pauseState:update(dt)
end

function pauseState:draw()
    love.graphics.setColor(0, 0, 0, 0.5) -- Semi-transparent background
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(1, 0, 0)
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.printf("Game Paused", 0, love.graphics.getHeight() / 2 - 50, love.graphics.getWidth(), "center")
    love.graphics.setColor(1, 1, 1)
end


function pauseState:keypressed(key)
    if key == "p" then
      Gamestate.switch(levelOne)
    end
end

return pauseState