-- Slime.lua
Slime = Enemy:extend()


function Slime:new(x, y, player)
    self.slimeSpeed = 10
    Slime.super.new(self, x, y, slimeSpeed, player)
    self.isSlime = true
    self.setColor = {0, 1, 0}
    self.knockBack = 20
end

function Slime:update(dt)
    Slime.super.update(self, dt)
end

function Slime:draw()
    love.graphics.setColor(self.setColor)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
end
