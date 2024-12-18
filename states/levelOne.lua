-- level1.lua LEVEL 1

Object = require "Libraries/classic"
local bump = require 'Libraries/bump'
local gamera = require 'Libraries/gamera'
require "Entity"
require "Ground"
require "Player"
require "Crosshair"
require "Enemy"
require "Slime"

local levelOne = {}

function levelOne:init()
    love.mouse.setVisible(false)
    self.world = bump.newWorld(50)
    
    self.crosshair = Crosshair()
    self.camera = gamera.new(-math.huge, -math.huge, math.huge, math.huge)
    self.camera:setWindow(0, 0, 1280, 720)
    
    self.entities = {}
    self.ground = Ground(0, 720 - 50, 1280, 50)
    self.platform = Ground(250, 500, 300, 50)
    self.player = Player(50, 500, self.world, self.camera)
    self.slime = Slime(self.world, 200, 600, self.player)
    self.slime2 = Slime(self.world, 300, 600, self.player)
    self.slime3 = Slime(self.world, 400, 600, self.player)
     
    table.insert(self.entities, self.ground)
    table.insert(self.entities, self.platform)
    table.insert(self.entities, self.player)
    table.insert(self.entities, self.slime)
    table.insert(self.entities, self.slime2)
    table.insert(self.entities, self.slime3)
    
    self._entities = self.entities
    
    self:generatePlatforms(20, 2000, 2000)
   
    for _, entity in ipairs(self.entities) do
        self.world:add(entity, entity.x, entity.y, entity.width, entity.height)
    end
end

function levelOne:enter()
    print("Level 1")
end

    
function levelOne:update(dt)
    for i, entity in ipairs(self.entities) do
      entity:update(dt)
      if entity.isBullet and entity.toRemove then
          entity:destroy()
          table.remove(self.entities, i)
      elseif entity.isEnemy and entity.toRemove then
          entity:destroy()
          table.remove(self.entities, i)
      end
    end
    self.crosshair:update(dt)
    self.camera:setPosition(self.player.x + self.player.width / 2, self.player.y + self.player.height / 2)
end
    
function levelOne:draw()
    self.camera:draw(function()
      for _, entity in ipairs(self.entities) do
          entity:draw()
      end
    end)
    self.crosshair:draw()
    self:drawHUD()
    self:drawFPS()
end

function levelOne:keypressed(key)
    if key == "p" then
      Gamestate.switch(pauseState)
    end
end


function levelOne:generatePlatforms(count, worldWidth, worldHeight)
    local minVertSpacing = 100
    local maxVertSpacing = 200
    local minHorzSpacing = -300
    local maxHorzSpacing = 300
    
    local lastX = 100
    local lastY = 500
    
    for _ = 1, count do
        local width = love.math.random(100, 300)
        local height = 50
        
        local x = lastX + love.math.random(minHorzSpacing, maxHorzSpacing)
        local y = lastY - love.math.random(minVertSpacing, maxVertSpacing)
        
        x = math.max(0, math.min(worldWidth - width, x))
        y = math.max(0, y)
        
        local platform = Ground(x, y, width, height)
        table.insert(self.entities, platform)
        
        lastX = x
        lastY = y
    end
end

function levelOne:drawHUD()
    local barWidth = 400
    local barHeight = 20
    local barPercentage = self.player.health / 100
    local healthBarX = 10
    local healthBarY = love.graphics.getHeight() - barHeight - 10
    
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", healthBarX, healthBarY, barWidth, barHeight)
    
    if self.player.health > 0 then
        love.graphics.setColor(1 - barPercentage, barPercentage, 0)
        love.graphics.rectangle("fill", healthBarX, healthBarY, barWidth * barPercentage, barHeight)
    end
    love.graphics.setColor(1, 1, 1)
end

function levelOne:drawFPS()
    local fps = love.timer.getFPS()
    love.graphics.print("FPS: " .. fps, love.graphics.getWidth() - 60, 10)
end

return levelOne