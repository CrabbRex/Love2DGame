-- HUD.lua
HUD = Object:extend()

function HUD:new(player)
    self.player = player
end

function HUD:drawHUD()
    local barWidth = 400
    local barHeight = 20
    local barPercentage = self.player.health / 100
    local healthBarX = 100
    local healthBarY = love.graphics.getHeight() - barHeight - 10
    
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", healthBarX, healthBarY, barWidth, barHeight)
    
    if self.player.health > 0 then
        love.graphics.setColor(1 - barPercentage, barPercentage, 0)
        love.graphics.rectangle("fill", healthBarX, healthBarY, barWidth * barPercentage, barHeight)
    end
    love.graphics.setColor(1, 1, 1)
    
    local fps = love.timer.getFPS()
    love.graphics.print("FPS: " .. fps, love.graphics.getWidth() - 60, 10)
end

function HUD:drawFPS()
    print("drawFPS outside")
end