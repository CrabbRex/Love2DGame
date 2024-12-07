-- ground.lua
Ground = Entity:extend()

function Ground:new(x, y, width, height)
  Ground.super.new(self, x, y, width, height)
end

function Ground:update()
  
end

function Ground:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
