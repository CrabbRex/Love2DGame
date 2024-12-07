-- player.lua
Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, 100, 100)
    self.speed = 200
end

function Player:update(dt)
    Player.super.update(self, dt)
    
    if love.keyboard.isDown("left") then
      self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
      self.x = self.x + self.speed * dt
    end
    
    if love.keyboard.isDown("up") then
      self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown("down") then
      self.y = self.y + self.speed * dt
    end
    
end

function Player:draw()
    love.graphics.rectangle("line", self.x, self.y, 50, 50)
end
