require("justpressed")

Object = require("classic")
Player = Object:extend()

function Player:new(x, y)
	self.images = {}
	self.images.normal = love.graphics.newImage("img/ghostNormal.png")
	self.images.up = love.graphics.newImage("img/ghostUp.png")
	self.images.down = love.graphics.newImage("img/ghostDown.png")
	self.images.left = love.graphics.newImage("img/ghostLeft.png")
	self.images.right = love.graphics.newImage("img/ghostRight.png")
	self.image = self.images.normal
	self.x = x
	self.y = y
	self.speed = 128
	self.velocity = {}
	self.velocity.x = 0
	self.velocity.y = 0
	self.waveHeight = 16
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
		self.image = self.images.up
	elseif down then
		self.velocity.y = self.speed
		self.image = self.images.down
	elseif left then
		self.velocity.x = -self.speed
		self.image = self.images.left
	elseif right then
		self.velocity.x = self.speed
		self.image = self.images.right
	else
		self.velocity.x = 0
		self.velocity.y = 0
		self.image = self.images.normal
	end

	-- Apply the velocity to the self's position
	self.x = self.x + self.velocity.x * deltaTime
	self.y = self.y + self.velocity.y * deltaTime
end

function Player:draw()
	local wave = math.sin(love.timer.getTime()) * self.waveHeight

	love.graphics.draw(self.image, self.x, self.y + wave)
end