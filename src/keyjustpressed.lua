keyjustpressed = {}

-- function justpressedUpdate()
--     for i, _ in pairs(justpressed) do
--         justpressed[i] = false
--     end
-- end

function love.keypressed(key)
	keyjustpressed[key] = true
end

return keyjustpressed