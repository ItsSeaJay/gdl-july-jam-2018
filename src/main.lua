function love.load()
	player = require("player")
end

function love.update(deltaTime)
	player:update(deltaTime)
end

function love.draw()
	player:draw()
end