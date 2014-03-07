InputManager = {}

function InputManager:startPress(x, y)
    self.pressed = {x, y}
    self.timer = 0
end

function InputManager:endPress(x, y)
    self.released = {x, y}
    local displacement = {x - self.pressed[1], y - self.pressed[2]}
    local distance = math.sqrt(displacement[1]^2 + displacement[2]^2)
    if distance > 10 then
        Train:tryMove(displacement[1] / self.timer)
    else
        Doors:toggle()
    end
end

function InputManager.mousepressed(x, y, button)
    InputManager:startPress(x, y)
    love.mousepressed = nothing
    love.mousereleased = InputManager.mousereleased
end

function InputManager.mousereleased(x, y, button)
    InputManager:endPress(x, y)
    love.mousepressed = nothing
    love.mousereleased = nothing
end

function InputManager:load()
    love.mousepressed = InputManager.mousepressed
    self.timer = 0
end

function InputManager:update(dt)
    self.timer = self.timer + dt
end
