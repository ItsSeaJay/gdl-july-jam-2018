player = {}
player.image = love.graphics.newImage("img/ghost.png")
player.x = (love.graphics.getWidth() / 2) - (player.image:getWidth() / 2)
player.y = love.graphics.getHeight() / 2
player.speed = 64
player.velocity = {}
player.velocity.x = 0
player.velocity.y = 0

function player:update(deltaTime)
	local up = love.keyboard.isDown("w") or love.keyboard.isDown("up")
	local down = love.keyboard.isDown("s") or love.keyboard.isDown("down")
	local left = love.keyboard.isDown("a") or love.keyboard.isDown("left")
	local right = love.keyboard.isDown("d") or love.keyboard.isDown("right")

	-- Horizontal
	if up then
		player.velocity.y = -player.speed
	elseif down then
		player.velocity.y = player.speed
	else
		player.velocity.y = 0
	end

	-- Vertical
	if left then
		player.velocity.x = -player.speed
	elseif right then
		player.velocity.x = player.speed
	else
		player.velocity.x = 0
	end

	-- Apply the velocity to the player's position
	player.x = player.x + player.velocity.x * deltaTime
	player.y = player.y + player.velocity.y * deltaTime
end

function player:draw()
	love.graphics.draw(player.image, player.x, player.y)
end

return player