require('src/input')
require('src/train')
require('src/doors')

function nothing()
end

function love.load()
    love.window.setMode(1024, 768, {
        fullscreen = false,
        resizable = false,
    })
    background = love.graphics.newImage('img/background.png')
    car = love.graphics.newImage('img/car.png')
    leftDoor = love.graphics.newImage('img/door.png')
    rightDoor = love.graphics.newImage('img/door.png')

    Train.state = Train.isStopped
    Train.tryMove = Train.move
    Doors.state = Doors.areClosed
    Doors.toggle = Doors.open
    love.mousepressed = InputManager.mousepressed
end

function love.update(dt)
    Train:state(dt)
    Doors:state(dt)
end

function love.draw()
    love.graphics.draw(background)
    love.graphics.draw(car)
    love.graphics.draw(leftDoor)
    love.graphics.draw(rightDoor, 99)
end
