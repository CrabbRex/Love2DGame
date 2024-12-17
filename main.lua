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
    platform = Ground(250, 500, 300, 50)
    player = Player(50, 500, world)
    slime = Slime(world, 200, 600, player)
    slime2 = Slime(world, 300, 600, player)
    slime3 = Slime(world, 400, 600, player)
    entities = {}
    
    generatePlatforms(20, 2000, 2000)
    
    table.insert(entities, ground)
    table.insert(entities, platform)
    table.insert(entities, player)
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
    if entity.isEnemy and entity.toRemove then
      table.remove(entities, i)
      entity:destroy()
    end
    
    end
    crosshair:update(dt)
    --camera pos
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
    drawHUD()
    DrawFPS()
end

function generatePlatforms(count, worldWidth, worldHeight)
    local minVertSpacing = 100
    local maxVertSpacing = 200
    local minHorzSpacing = -300
    local maxHorzSpacing = 300
    
    local lastX = 100
    local lastY = 500
    
    for i = 1, count do
        local width = love.math.random(100, 300)
        local height = 50
        
        local x = lastX + love.math.random(minHorzSpacing, maxHorzSpacing)
        local y = lastY - love.math.random(minVertSpacing, maxVertSpacing)
        
        x = math.max(0, math.min(worldWidth - width, x))
        y = math.max(0, y)
        
        local platform = Ground(x, y, width, height)
        table.insert(entities, platform)
        
        lastX = x
        lastY = y
    end
    
end


function drawHUD()
    local barWidth = 400
    local barHeight = 20
    local barPercentage = player.health / 100
    local healthBarX = 10
    local healthBarY = love.graphics.getHeight() - barHeight - 10
    
    --Background bar
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", healthBarX, healthBarY, barWidth, barHeight)
    
    --Moving health bar
    if player.health > 0 then
      love.graphics.setColor(1 - barPercentage, barPercentage, 0)
      love.graphics.rectangle("fill", healthBarX, healthBarY, barWidth * barPercentage, barHeight)
    end
    love.graphics.setColor(1, 1, 1)
end


function DrawFPS()
    local fps = love.timer.getFPS()
    love.graphics.print("FPS: " .. fps, love.graphics.getWidth() - 60, 10)
end
