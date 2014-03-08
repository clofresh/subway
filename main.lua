require('src/input')
require('src/train')
require('src/station')
require('src/people')

function nothing()
end

function love.load()
    love.window.setMode(1024, 768, {
        fullscreen = false,
        resizable = false,
    })

    People:load()
    Station:load()
    Train:load()
    InputManager:load()
end

function love.update(dt)
    Station:update(dt)
    Train:update(dt)
    InputManager:update(dt)
end

function love.draw()
    Station:draw()
    Train:draw()
    People:draw(Station.people)
end
