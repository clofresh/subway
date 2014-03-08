require('src/doors')

Train = {}

function Train:move(speed)
    print("train is leaving the station")
    self.state = self.isOutgoing
    self.timer = 0
    self.tryMove = nothing
    self.speed = speed
end

function Train:isStopped(dt)
end

function Train:isIncoming(dt)
    local t = self.timer
    t = t + dt
    self.x = self.x + dt * self.speed
    if self.x > 0 then
        print('train has entered the station')
        self.state = self.isStopped
        self.tryMove = self.move
        love.mousepressed = InputManager.mousepressed
        t = 0
        self.x = 0
        self.speed = 0
    end
    if self.x > 0 then
        self.x = 0
        self.speed = 0
    end
    self.timer = t
end

function Train:isOutgoing(dt)
    local t = self.timer
    t = t + dt
    self.x = self.x + dt * self.speed
    if self.x > love.graphics.getWidth() then
        print('train has left the station')
        self.state = self.isIncoming
        self.speed = 1000
        self.x = -1024
        t = 0
    end
    self.timer = t
end

function Train:load()
    self.car = love.graphics.newImage('img/car.png')
    self.state = self.isStopped
    self.tryMove = self.move
    self.x = 0
    self.speed = 0
    Doors:load()
end

function Train:update(dt)
    self:state(dt)
    Doors:update(dt)
end

function Train:draw()
    love.graphics.draw(self.car, self.x)

    -- Move the doors relative to the train's coordinate system
    love.graphics.push()
    love.graphics.translate(self.x, 0)
    Doors:draw()
    love.graphics.pop()
end
