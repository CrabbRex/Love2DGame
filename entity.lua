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

function Entity:draw()
    if self.image then
      love.graphics.draw(self.image, self.x, self.y)
    else
      love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end
end

function Entity:checkCollision(e)
    return self.x + self.width > e.x
    and self.x < e.x + e.width
    and self.y + self.height > e.y
    and self.y < e.y + e.height
end
