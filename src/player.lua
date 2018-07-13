player = {}
player.x = love.graphics.getWidth() / 2
player.y = love.graphics.getHeight() / 2
player.velocity = {}
player.velocity.x = 23
player.velocity.y = 0
player.image = love.graphics.newImage("img/ghost.png")

function player:update(deltaTime)
	player.x = player.x + player.velocity.x * deltaTime
	player.y = player.y + player.velocity.y * deltaTime
end

return player