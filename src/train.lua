Train = {}

function Train:move(displacement)
    print("train is leaving the station")
    self.state = self.isOutgoing
    self.timer = 0
    self.tryMove = nothing
end

function Train:isStopped(dt)
end

function Train:isIncoming(dt)
    local t = self.timer
    t = t + dt
    if t > 2 then
        print('train has entered the station')
        self.state = self.isStopped
        self.tryMove = self.move
        love.mousepressed = InputManager.mousepressed
        t = 0
    end
    self.timer = t
end

function Train:isOutgoing(dt)
    local t = self.timer
    t = t + dt
    if t > 2 then
        print('train has left the station')
        self.state = self.isIncoming
        t = 0
    end
    self.timer = t
end

function Train:load()
    self.state = self.isStopped
    self.tryMove = self.move
end

function Train:update(dt)
    self:state(dt)
end
