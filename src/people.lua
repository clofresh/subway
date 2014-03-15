People = {}

function goTo(actor, destination, dt, threshold)
	actor.animationTimer = actor.animationTimer + dt
	actor.animation = 'walking'
	local x, y = actor.shape:center()
	local direction = {destination.x - x, destination.y - y}
	local mag = math.sqrt(direction[1]^2 + direction[2]^2)
	if direction[1] > 0 then
		actor.dir = 1
	else
		actor.dir = -1
	end
	if mag > threshold then
		local unitDirection = {direction[1] / mag, direction[2] / mag}
		actor.shape:move(unitDirection[1], unitDirection[2])
		return false
	else
		actor.animation = 'idle'
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
	self.image = love.graphics.newImage('img/person.png')
	self.batch = love.graphics.newSpriteBatch(self.image)
	local tileWidth = 32
	local tileHeight = 32
	local imageWidth = self.image:getWidth()
	local imageHeight = self.image:getHeight()
	self.quads = {
		idle = {love.graphics.newQuad(0, 0, tileWidth, tileHeight, imageWidth, imageHeight)},
		walking = {
			love.graphics.newQuad(tileWidth, 0, tileWidth, tileHeight, imageWidth, imageHeight),
			love.graphics.newQuad(tileWidth*2, 0, tileWidth, tileHeight, imageWidth, imageHeight),
		}
	}

	-- Should eventually be animation-specific
	self.fps = 6.0
	self.w = 16
	self.h = 31
	self.ox = 8
	self.oy = 1
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
	    person.shape = Collider:addRectangle(x, y, self.w, self.h)
	end
	person.animationTimer = 0
	person.animation = 'idle'
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
	local x1, y1, x2, y2, frame, animation
	local spf = 1.0 / self.fps
	local ox
	local oy = self.oy
	for id, person in pairs(people) do
		x1, y1, x2, y2 = person.shape:bbox()
		animation = self.quads[person.animation]
		frame = math.floor(person.animationTimer / spf) % #animation
		if person.dir == -1 then
			ox = self.ox + self.w
		else
			ox = self.ox
		end
		self.batch:add(animation[frame + 1], x1, y1, nil, person.dir, 1, ox, oy)
	end
	love.graphics.draw(self.batch)
	self.batch:clear()
end
