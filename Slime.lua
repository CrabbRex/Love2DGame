-- Slime.lua
Slime = Enemy:extend()


function Slime:new(world, x, y, player)
    self.slimeSpeed = 30
    local slimeHealth = 30
    Slime.super.new(self, world, x, y, self.slimeSpeed, slimeHealth, player)
    self.isSlime = true
    self.setColor = {0, 1, 0}
    self.knockBack = 50
end

function Slime:update(dt)
    Slime.super.update(self, dt)
end

function Slime:draw()
    love.graphics.setColor(self.setColor)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
end
