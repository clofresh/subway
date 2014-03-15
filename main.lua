HC = require('lib/hardoncollider')
anim8 = require('lib/anim8/anim8')
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
    Collider = HC(100, function(dt, shape1, shape2, dx, dy)
        shape1:move(dx/2, dy/2)
        shape2:move(-dx/2, -dy/2)
    end)

    People:load()
    Station:load()
    Train:load()
    InputManager:load()
end

function love.update(dt)
    Station:update(dt)
    Train:update(dt)
    InputManager:update(dt)
    Collider:update(dt)
end

function love.draw()
    Station:draw()
    Train:draw()
    People:draw(Station.people)
end
