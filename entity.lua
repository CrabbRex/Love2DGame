-- entity.lua
Entity = Object:extend()

function Entity:new(x, y, width, height, image_path)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    
    if image_path then
      self.image = love.grpahics.newImage(image_path)
      self.width = self.image.getWidth()
      self.height = self.height.getHeight()
    else
      self.image = nil
    end
end

function Entity:update()
    
end


--[[function Entity:__toString()
    return string.format("Entity[%s] at (%d, %d)", self.__class, self.x, self.y)
end]]--
