-- main.lua

Gamestate = require "Libraries/gameState"

function love.load()
    love.window.setMode(1280, 720)
    love.mouse.setVisible(false)
    -- Define States:
    local menuState = require "states/menuState"
    levelOne = require "states/levelOne"
    
    -- Set Initial State:
    Gamestate.registerEvents()
    Gamestate.switch(menuState)
end

function love.update(dt)
end

function love.draw()
end
