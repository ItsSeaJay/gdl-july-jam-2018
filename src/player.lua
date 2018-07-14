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
	self.states.test = function(self, deltaTime)
		love.graphics.print("Test", 0, 0)
	end
	self.state = self.states.test
end

-- Game loop
function Player:update(deltaTime)
	-- Call the function associated with the player's current state
	self.state(self, deltaTime)
end

function Player:draw()
	love.graphics.draw(self.image, self.x, self.y)
end