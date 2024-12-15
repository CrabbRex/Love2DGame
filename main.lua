-- main.lua

function love.load()
    Object = require "classic"
    local bump = require 'bump'
    local gamera = require 'gamera'
    require "Entity"
    require "Ground"
    require "Player"
    require "Crosshair"
    require "Enemy"
    require "Slime"
    love.window.setMode(1280, 720)
    love.mouse.setVisible(false)
    
    world = bump.newWorld(50)
    
    ground = Ground(0, 720 - 50, 1280, 50)
    platform = Ground(100, 500, 350, 50)
    platform2 = Ground(400, 300, 350, 50)
    player = Player(50, 500, world)
    slime = Slime(200, 600, player)
    slime2 = Slime(300, 600, player)
    slime3 = Slime(400, 600, player)
    
    
    entities = {}
    table.insert(entities, ground)
    table.insert(entities, platform)
    table.insert(entities, player)
    table.insert(entities, platform2)
    table.insert(entities, slime)
    table.insert(entities, slime2)
    table.insert(entities, slime3)
    
    for i,entity in ipairs(entities) do
      world:add(entity, entity.x, entity.y, entity.width, entity.height)
    end
    crosshair = Crosshair()
    
    local worldWidth, worldHeight = 2000, 2000
    camera = gamera.new(-math.huge, -math.huge, math.huge, math.huge)
    camera:setWindow(0, 0, 1280, 720)
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
    camera:setPosition(player.x + player.width/2, player.y + player.height/2)
end

function love.draw()
  --for i,entity in ipairs(entities) do
  --  entity:draw()
  --end
  --crosshair:draw()
  camera:draw(function(l,t,w,h)
      for i,entity in ipairs(entities) do
        entity:draw()
      end
    end)
    crosshair:draw()
end
