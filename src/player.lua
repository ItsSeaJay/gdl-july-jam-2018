Object = require("classic")
Player = Object:extend()

function Player:new()
	self.image = love.graphics.newImage("img/ghost.png")
	self.x = love.graphics.getWidth() / 2
	self.y = love.graphics.getHeight() / 2
	self.speed = 64
	self.velocity = {}
	self.velocity.x = 0
	self.velocity.y = 0
end

function Player:update(deltaTime)
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

function Player:draw()
	love.graphics.draw(player.image, player.x, player.y)
end

return player