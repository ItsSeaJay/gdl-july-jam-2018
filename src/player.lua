require("justpressed")

Object = require("classic")
Player = Object:extend()

function Player:new(x, y)
	self.images = {}
	self.images.normal = love.graphics.newImage("img/ghostDown.png")
	self.image = self.images.normal
	self.x = x
	self.y = y
	self.speed = 128
	self.velocity = {}
	self.velocity.x = 0
	self.velocity.y = 0
end

-- Game loop
function Player:update(deltaTime)
	local up = love.keyboard.isDown("w") or love.keyboard.isDown("up")
	local down = love.keyboard.isDown("s") or love.keyboard.isDown("down")
	local left = love.keyboard.isDown("a") or love.keyboard.isDown("left")
	local right = love.keyboard.isDown("d") or love.keyboard.isDown("right")

	-- Horizontal
	if up then
		self.velocity.y = -self.speed
	elseif down then
		self.velocity.y = self.speed
	else
		self.velocity.y = 0
	end

	-- Vertical
	if left then
		self.velocity.x = -self.speed
	elseif right then
		self.velocity.x = self.speed
	else
		self.velocity.x = 0
	end

	-- Apply the velocity to the self's position
	self.x = self.x + self.velocity.x * deltaTime
	self.y = self.y + self.velocity.y * deltaTime
end

function Player:draw()
	love.graphics.draw(self.image, self.x, self.y)
end