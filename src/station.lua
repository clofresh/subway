Station = {}

function Station:load()
	self.background = love.graphics.newImage('img/background.png')
end

function Station:update(dt)
end

function Station:draw()
    love.graphics.draw(self.background)
end
