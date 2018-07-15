require("TextBubble")
require("Furniture")
cam = require("cam")
justpressed = require("justpressed")
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
	self.bubbles = {}
	self.state = "angry"
	self.openingTimer = 0
	self.furniture = {}
	-- Sofa
	self.furniture[1] = Furniture(
		825,
		372,
		"img/normalSofa.png",
		"img/smashedSofa.png",
		3 -- Health
	)
end

-- Game loop
function Player:update(deltaTime)
	local up = love.keyboard.isDown("w") or love.keyboard.isDown("up")
	local down = love.keyboard.isDown("s") or love.keyboard.isDown("down")
	local left = love.keyboard.isDown("a") or love.keyboard.isDown("left")
	local right = love.keyboard.isDown("d") or love.keyboard.isDown("right")

	if self.state == "opening" then
		-- Play the opening
		self.opening = self.opening + deltaTime

		self:move(deltaTime, up, down, left, right)
		self:animate(deltaTime, up, down, left, right)
	elseif self.state == "angry" then
		-- Float around angrily
		self.speed = 256

		self:move(deltaTime, up, down, left, right)
		self:animate(deltaTime, up, down, left, right)

		for i, _ in ipairs(self.furniture) do
			self.furniture[i]:update()

			local mouseX, mouseY = love.mouse.getPosition()
			local camX, camY = cam:getPosition()
			local position = self.furniture[i]:getPosition()
			local scale = self.furniture[i]:getScale()

			if (mouseX + cam:getPosition().x) > position.x then
				-- attack!
			end
		end
	elseif self.state == "ending" then
		-- Sit still whilst the ending plays
	end

	-- Text Bubbles
	for key, bubble in ipairs(self.bubbles) do
		bubble:update(deltaTime)

		-- Remove destroyed bubbles
		if bubble:getDestroyed() == true then
			table.remove(self.bubbles, key)
		end
	end

	-- Furniture
	for i, _ in ipairs(self.furniture) do
		self.furniture[i]:update()
	end

	-- Reset justpressed
	for i, _ in pairs(justpressed) do
		justpressed[i] = false
	end
end

function Player:move(deltaTime, up, down, left, right)
	-- Movement
	-- Vertical
	if up then
		self.velocity.y = -self.speed
	elseif down then
		self.velocity.y = self.speed
	else
		self.velocity.y = 0
	end

	-- Horizontal
	if left then
		self.velocity.x = -self.speed
	elseif right then
		self.velocity.x = self.speed
	else
		self.velocity.x = 0
	end

	-- Apply the velocity to the player's position
	self.x = self.x + self.velocity.x * deltaTime
	self.y = self.y + self.velocity.y * deltaTime
end

function Player:animate(deltaTime, up, down, left, right)
	if up then
		self.image = self.images.up
	elseif down then
		self.image = self.images.down
	elseif left then
		self.image = self.images.left
	elseif right then
		self.image = self.images.right
	else
		self.image = self.images.normal
	end
end

function Player:draw()
	local wave = math.sin(love.timer.getTime()) * self.waveHeight

	for i, _ in ipairs(self.furniture) do
		self.furniture[i]:draw()
	end

	if self.state ~= "angry" then
		love.graphics.setColor(1, 1, 1, 0.8)
	else
		-- Glow red
		love.graphics.setColor(1, 0.5, 0.5, 0.8)
	end

	love.graphics.draw(self.image, self.x, self.y + wave)
	love.graphics.setColor(1, 1, 1, 1)

	for key, bubble in pairs(self.bubbles) do
		bubble:draw()
	end
end