-- Configuration
function love.conf(t)
    print('running')
    t.title = "Hero Game"

    t.modules.joystick = false
    t.modules.physics = false
end
