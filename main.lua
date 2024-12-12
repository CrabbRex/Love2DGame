-- main.lua

function love.load()
    Object = require "classic"
    local bump = require 'bump'
    require "Entity"
    require "Ground"
    require "Player"
    require "Crosshair"
    require "Enemy"
    love.window.setMode(1280, 720)
    love.mouse.setVisible(false)
    
    world = bump.newWorld(50)
    
    ground = Ground(0, 720 - 50, 1280, 50)
    platform = Ground(100, 500, 350, 50)
    platform2 = Ground(400, 300, 350, 50)
    player = Player(50, 500, world)
    enemy = Enemy(800, 600)
    
    
    entities = {}
    table.insert(entities, ground)
    table.insert(entities, platform)
    table.insert(entities, player)
    table.insert(entities, platform2)
    table.insert(entities, enemy)
    
    for i,entity in ipairs(entities) do
      world:add(entity, entity.x, entity.y, entity.width, entity.height)
    end
    crosshair = Crosshair()
end

function love.update(dt)
  for i, entity in ipairs(entities) do
    entity:update(dt)
    
    if entity.isBullet and entity.toRemove then
      entity:destroy()
      table.remove(entities, i)
    end
    
  end
  crosshair:update(dt)
end

function love.draw()
  for i,entity in ipairs(entities) do
    entity:draw()
  end
  crosshair:draw()
end
