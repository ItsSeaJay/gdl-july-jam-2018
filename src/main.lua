function love.load()
	player = require("player")
end

function love.update(deltaTime)
	
end

function love.draw()
	love.graphics.draw(player.image, 100, 100)
end