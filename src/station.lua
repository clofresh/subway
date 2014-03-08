Station = {}

function Station:load()
	self.background = love.graphics.newImage('img/background.png')
	self.turnstile = {x=350, y=318}
	self.doors = {x=226, y=578}
	self.train = {x=226, y=682}
end

function Station:update(dt)
end

function Station:draw()
    love.graphics.draw(self.background)
end
