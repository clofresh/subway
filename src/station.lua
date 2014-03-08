Station = {}

function Station:load()
	self.background = love.graphics.newImage('img/background.png')
	self.turnstile = {x=350, y=318}
	self.doors = {x=226, y=578}
	self.train = {x=226, y=682}
	self.people = {}
	People:add(self.people, {x = 200, y = 200, r = 10})
	print(self.people)
	self.timer = 0
end

function Station:update(dt)
	People:update(self.people, dt)
	self.timer = self.timer + dt
	if self.timer > 5 then
		People:add(self.people, {x = 200, y = 200, r = 10})
		self.timer = 0
	end
end

function Station:remove(person)
	People:remove(self.people, person)
end

function Station:draw()
    love.graphics.draw(self.background)
end
