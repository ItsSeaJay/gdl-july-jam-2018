function love.load()
	player = require("player")
end

function love.update(deltaTime)
	player:update(deltaTime)
end

function love.draw()
	love.graphics.draw(player.image, player.x, player.y)
end