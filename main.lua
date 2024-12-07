-- main.lua

function love.load()
    Object = require "classic"
    require "Entity"
    require "Ground"
    require "Player"
    love.window.setMode(1280, 720)
    
    ground = Ground(0, 720 - 50, 1280, 50)
    player = Player(50, 50)
    
    entities = {}
    table.insert(entities, ground)
end

function love.update(dt)
  player:update(dt)
end

function love.draw()
  ground:draw()
  player:draw()
end
