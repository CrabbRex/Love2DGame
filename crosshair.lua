-- crosshair.lua

Crosshair = Object:extend()

function Crosshair:new()
    self.x, self.y = love.mouse.getPosition()
    self.isCrosshair = true
    self.size = 10
    self.colour = {1, 0, 0}
end

function Crosshair:update(dt)
    self.x, self.y = love.mouse.getPosition()
end

function Crosshair:draw()
    love.graphics.push()
    love.graphics.origin()
    love.graphics.setColor(self.colour)
    love.graphics.line(self.x - self.size, self.y, self.x + self.size, self.y)
    love.graphics.line(self.x, self.y - self.size, self.x, self.y + self.size)
    love.graphics.setColor(1, 1, 1)
    love.graphics.pop()
end

