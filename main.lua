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

    Station:load()
    People:load()
    Train:load()
    InputManager:load()
end

function love.update(dt)
    Station:update(dt)
    People:update(dt)
    Train:update(dt)
    InputManager:update(dt)
end

function love.draw()
    Station:draw()
    Train:draw()
    People:draw()
end
