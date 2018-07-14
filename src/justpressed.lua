justpressed = {}

function love.update(dt)
    if justpressed["space"] then
        print("aaaaay")
    end

    for i, _ in pairs(justpressed) do
        justpressed[i] = false
    end
end

function love.keypressed(key)
    justpressed[key] = true
end

return justpressed