People = {}

function goTo(actor, destination, dt, threshold)
	local direction = {destination.x - actor.x, destination.y - actor.y}
	local mag = math.sqrt(direction[1]^2 + direction[2]^2)
	if mag > threshold then
		local unitDirection = {direction[1] / mag, direction[2] / mag}
		actor.x = actor.x + unitDirection[1]
		actor.y = actor.y + unitDirection[2]
		return false
	else
		return true
	end
end

function People:goToTurnstile(person, dt)
	return goTo(person, Station.turnstile, dt, 5)
end

function People:useCard(person, dt)
	return true
end

function People:goToTrainDoor(person, dt)
	return goTo(person, Station.doors, dt, 5)
end

function People:waitForOpenDoor(person, dt)
	return Doors.state == Doors.areOpen
end

function People:goToTrain(person, dt)
	return goTo(person, Station.train, dt, 0)
end

function People:load()
	self.id = 0
	self.timer = 0
	self.people = {}
	People:add({x = 200, y = 200, r = 10})
end

function People:add(person)
	id = self.id + 1
	self.id = id
	person.id = id
	person.plan = {
		self.goToTurnstile,
		self.useCard,
		self.goToTrainDoor,
		self.waitForOpenDoor,
		self.goToTrain,
	}
	self.people[id] = person
end

function People:update(dt)
	local success, action
	for person_id, person in pairs(self.people) do
		action = person.plan[1]
		if action then
			success = action(self, person, dt)
			if success then
				table.remove(person.plan, 1)
			end
		end
	end
	self.timer = self.timer + dt
	if self.timer > 5 then
		self:add({x = 200, y = 200, r = 10})
		self.timer = 0
	end
end

function People:draw()
	love.graphics.setColor(0, 255, 0)
	for id, person in pairs(self.people) do
		love.graphics.circle("fill", person.x, person.y, person.r)
	end
	love.graphics.setColor(255, 255, 255)
end
