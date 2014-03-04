Doors = {}

function Doors:open()
    print('opening doors')
    self.state = self.areOpening
    love.mousepressed = nothing
    love.mousereleased = nothing
    openingTimer = 0
    self.toggle = self.close
end

function Doors:close()
    print('closing doors')
    self.state = self.areClosing
    love.mousepressed = nothing
    love.mousereleased = nothing
    closingTimer = 0
    self.toggle = self.open
end

function Doors:areClosing(dt)
    closingTimer = closingTimer + dt
    self.leftX = self.leftX + dt * self.speed
    self.rightX = self.rightX - dt * self.speed
    if closingTimer > 2 then
        print('doors closed')
        self.state = self.areClosed
        love.mousepressed = InputManager.mousepressed
    end
end

function Doors:areClosed(dt)
end

function Doors:areOpening(dt)
    openingTimer = openingTimer + dt
    self.leftX = self.leftX - dt * self.speed
    self.rightX = self.rightX + dt * self.speed
    if openingTimer > 2 then
        print('doors open')
        self.state = self.areOpen
        love.mousepressed = InputManager.mousepressed
    end
end

function Doors:areOpen(dt)
end

function Doors:load()
    self.leftDoor = love.graphics.newImage('img/door.png')
    self.rightDoor = love.graphics.newImage('img/door.png')
    self.leftX = 0
    self.leftY = 0
    self.rightX = 0
    self.rightY = 0
    self.offsetX = 99
    self.speed = 40
    self.state = self.areClosed
    self.toggle = self.open
end

function Doors:update(dt)
    self:state(dt)
end

function Doors:draw()
    love.graphics.draw(self.leftDoor, self.leftX, self.leftY)
    love.graphics.draw(self.rightDoor, self.rightX + self.offsetX, self.rightY)
end
