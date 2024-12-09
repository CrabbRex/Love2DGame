-- main.lua

function love.load()
    Object = require "classic"
    local bump = require 'bump'
    require "Entity"
    require "Ground"
    require "Player"
    require "Crosshair"
    love.window.setMode(1280, 720)
    
    world = bump.newWorld(50)
    
    ground = Ground(0, 720 - 50, 1280, 50)
    platform = Ground(100, 500, 700, 50)
    player = Player(50, 500)
    
    
    entities = {}
    table.insert(entities, ground)
    table.insert(entities, platform)
    table.insert(entities, player)
    
    for i,entity in ipairs(entities) do
      world:add(entity, entity.x, entity.y, entity.width, entity.height)
    end
    crosshair = Crosshair()
end

function love.update(dt)
  player:update(dt)
  ground:update(dt)
  crosshair:update(dt)
end

function love.draw()
  for i,entity in ipairs(entities) do
    entity:draw()
  end
  crosshair:draw()
end
