-- crosshair.lua

Crosshair = Object:extend()

function Crosshair:new()
    self.x, self.y = love.mouse.getPosition()
    self.isCrosshair = true
    self.size = 10
    self.color = {1, 0, 0}
end

function Crosshair:update(dt)
    self.x, self.y = love.mouse.getPosition()
end

function Crosshair:draw()
    love.graphics.line(self.x - self.size, self.y, self.x + self.size, self.y)
    love.graphics.line(self.x, self.y - self.size, self.x, self.y + self.size)
end

