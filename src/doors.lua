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
    if openingTimer > 2 then
        print('doors open')
        self.state = self.areOpen
        love.mousepressed = InputManager.mousepressed
    end
end

function Doors:areOpen(dt)
end

function Doors:load()
    self.state = self.areClosed
    self.toggle = self.open
end

function Doors:update(dt)
    self:state(dt)
end
