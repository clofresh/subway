require('src/input')
require('src/train')
require('src/station')

function nothing()
end

function love.load()
    love.window.setMode(1024, 768, {
        fullscreen = false,
        resizable = false,
    })

    Station:load()
    Train:load()
    InputManager:load()
end

function love.update(dt)
    Train:update(dt)
end

function love.draw()
    Station:draw()
    Train:draw()
end
