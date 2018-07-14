Object = require("classic")
Player = Object:extend()

function Player:new(x, y)
	self.image = love.graphics.newImage("img/ghost.png")
	self.x = x
	self.y = y
	self.speed = 64
	self.velocity = {}
	self.velocity.x = 0
	self.velocity.y = 0

	-- Finite state machine
	self.states = {}
	self.states.normal = function(self, deltaTime)
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

		if love.keyboard.isDown("q") then self.state = self.states.test end
	end
	self.states.test = function(self, deltaTime)
		if love.keyboard.isDown("e") then self.state = self.states.normal end
	end
	self.state = self.states.normal
end

-- Game loop
function Player:update(deltaTime)
	-- Call the function associated with the player's current state
	self.state(self, deltaTime)
end

function Player:draw()
	love.graphics.draw(self.image, self.x, self.y)
end