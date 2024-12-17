-- entity.lua
Entity = Object:extend()

function Entity:new(x, y, width, height, image_path)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.gravity = 1000
    self.vy = 0
    
    if image_path then
      self.image = love.grpahics.newImage(image_path)
      self.width = self.image.getWidth()
      self.height = self.height.getHeight()
    else
      self.image = nil
    end
end

function Entity:changeVelocityByGravity(dt)
    self.vy = self.vy + self.gravity * dt
end


function Entity:update()
    
end


function Entity:destroy()
    self.world:remove(self)
end
