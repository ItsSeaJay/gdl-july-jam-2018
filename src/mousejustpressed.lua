mousejustpressed = {}

-- function justpressedUpdate()
--     for i, _ in pairs(justpressed) do
--         justpressed[i] = false
--     end
-- end

function love.mousepressed(x, y, button, istouch)
	mousejustpressed[button] = true
end

return mousejustpressed