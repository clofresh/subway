People = {}

function goTo(actor, destination, dt, threshold)
	local x, y = actor.shape:center()
	local direction = {destination.x - x, destination.y - y}
	local mag = math.sqrt(direction[1]^2 + direction[2]^2)
	if mag > threshold then
		local unitDirection = {direction[1] / mag, direction[2] / mag}
		actor.shape:move(unitDirection[1], unitDirection[2])
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
	local onTrain = goTo(person, Station.train, dt, 5)
	person.onTrain = onTrain
	return onTrain
end

function People:load()
	self.id = 0
end

function People:add(people, person, x, y, r)
	id = person.id
	if id == nil then
		id = self.id + 1
		self.id = id
		person.id = id
	end
	if person.plan == nil then
		person.plan = {
			self.goToTurnstile,
			self.useCard,
			self.goToTrainDoor,
			self.waitForOpenDoor,
			self.goToTrain,
		}
	end
	if person.shape == nil then
	    person.shape = Collider:addCircle(x, y, r)
	end
	people[id] = person
end

function People:remove(people, person)
	people[person.id] = nil
end

function People:update(people, dt)
	local success, action
	for person_id, person in pairs(people) do
		action = person.plan[1]
		if action then
			success = action(self, person, dt)
			if success then
				table.remove(person.plan, 1)
			end
		end
		if person.onTrain then
			Station:remove(person)
			Train:add(person)
		else
			table[person_id] = person
		end
	end
end

function People:draw(people)
	love.graphics.setColor(0, 255, 0)
	local x, y, r
	for id, person in pairs(people) do
		x, y, r = person.shape:outcircle()
		love.graphics.circle("fill", x, y, r)
	end
	love.graphics.setColor(255, 255, 255)
end
