require("TextBubble")
require("Furniture")
cam = require("cam")
keyjustpressed = require("keyjustpressed")
mousejustpressed = require("mousejustpressed")
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
	self.state = "opening" -- set to 'angry' to skip the opening cutscene
	self.openingTimer = 0
	self.endingTimer = 0
	self.furniture = {}
	-- Sofa
	self.furniture[1] = Furniture(
		825, -- X
		372, -- Y
		"img/normalSofa.png", -- Normal image
		"img/smashedSofa.png", -- Smashed image
		3 -- Health
	)
	-- Cupboard
	self.furniture[2] = Furniture(
		579, -- X
		309, -- Y
		"img/normalCupboard.png", -- Normal image
		"img/smashedCupboard.png", -- Smashed image
		2 -- Health
	)
	-- Bed
	self.furniture[3] = Furniture(
		108, -- X
		366, -- Y
		"img/normalBed.png", -- Normal image
		"img/smashedBed.png", -- Smashed image
		2 -- Health
	)
	self.angryMusic = love.audio.newSource("bgm/exhilarate.mp3", "stream")
	self.endMusic = love.audio.newSource("bgm/feelinGood.mp3", "stream")
	self.indicator = love.graphics.newImage("img/indicator.png")
	self.dingDong = love.audio.newSource("sfx/dingDong.wav", "static")
end

-- Game loop
function Player:update(deltaTime)
	if self.state == "opening" then
		-- Play the opening
		self.openingTimer = self.openingTimer + 1 * deltaTime

		-- This is based on a timer in a rigid manner
		if self.openingTimer > 0 and self.openingTimer < 2 then
			-- Move up
			up = true
		elseif self.openingTimer > 2 and self.openingTimer < 3 then
			up = false
		elseif self.openingTimer > 4.25 and self.openingTimer < 4.5 then
			right = true
		elseif self.openingTimer > 4.5 and self.openingTimer < 5 then
			right = false
			left = true
		elseif self.openingTimer > 5 and self.openingTimer < 6 then
			right = false
			left = false
		elseif self.openingTimer > 6 and self.openingTimer < 6.1 then
			table.insert(self.bubbles, TextBubble("Wait...", 487, 315))
		elseif self.openingTimer > 6.1 and self.openingTimer < 6.5 then
			right = false
			left = false
		elseif self.openingTimer > 6.5 and self.openingTimer < 8 then
			left = true
		elseif self.openingTimer > 8 and self.openingTimer < 8.5 then
			left = false
		elseif self.openingTimer > 8.5 and self.openingTimer < 8.6 then
			table.insert(self.bubbles, TextBubble("Double bed?", 162, 342))
		elseif self.openingTimer > 8.6 and self.openingTimer < 9 then
			left = false
		elseif self.openingTimer > 9 and self.openingTimer < 13 then
			right = true
		elseif self.openingTimer > 13 and self.openingTimer < 13.5 then
			right = false
		elseif self.openingTimer > 13.5 and self.openingTimer < 13.6 then
			table.insert(self.bubbles, TextBubble("Leather sofa?", 843, 290))
		elseif self.openingTimer > 18 and self.openingTimer < 18.1 then
			table.insert(self.bubbles, TextBubble("Someone built a house on my grave!", 843, 321))
		elseif self.openingTimer > 27 and self.openingTimer < 27.1 then
			table.insert(self.bubbles, TextBubble("How...", 843, 290))
		elseif self.openingTimer > 28 and self.openingTimer < 28.1 then
			table.insert(self.bubbles, TextBubble("inconsiderate...", 843, 321))
		elseif self.openingTimer > 32.5 and self.openingTimer < 32.6 then
			table.insert(self.bubbles, TextBubble("It's OK.", 843, 321))
		elseif self.openingTimer > 33.5 and self.openingTimer < 33.6 then
			table.insert(self.bubbles, TextBubble("I can work this out.", 843, 290))
		elseif self.openingTimer > 36.5 and self.openingTimer < 36.6 then
			table.insert(self.bubbles, TextBubble("I'll just have a nice,\nquiet chat with the owner!", 810, 321))
		elseif self.openingTimer > 40.5 and self.openingTimer < 40.6 then
			table.insert(self.bubbles, TextBubble("Everything will be fine,\nso long as I remain c...", 830, 424))
		elseif self.openingTimer > 45.7 and self.openingTimer < 45.8 then
			cam:setScale(3)
			self.angryMusic:play()
			table.insert(self.bubbles, TextBubble("CAAAAAAAAAAALM!!", 810, player.y - 16))
		elseif self.openingTimer > 46.7 and self.openingTimer < 46.8 then
			cam:setScale(1)
			self.state = "angry"
		else
			up, down, left, right = false
		end

		-- Add drama to the end of the cutscene
		if self.openingTimer > 32.5 and self.openingTimer < 43.8 then
			local zoomSpeed = 0.02
			cam:setScale(cam:getScale() + zoomSpeed * deltaTime)
		end

		self:move(deltaTime, up, down, left, right)
		self:animate(deltaTime, up, down, left, right)
	elseif self.state == "angry" then
		-- Float around angrily
		-- Give the player control
		local up = love.keyboard.isDown("w") or love.keyboard.isDown("up")
		local down = love.keyboard.isDown("s") or love.keyboard.isDown("down")
		local left = love.keyboard.isDown("a") or love.keyboard.isDown("left")
		local right = love.keyboard.isDown("d") or love.keyboard.isDown("right")
		
		local numberOfFurnitureSmashed = 0

		-- Move faster
		self.speed = 256

		self:move(deltaTime, up, down, left, right)
		self:animate(deltaTime, up, down, left, right)

		for i, _ in ipairs(self.furniture) do
			self.furniture[i]:update()

			if self.furniture[i]:getSmashed() then
				numberOfFurnitureSmashed = numberOfFurnitureSmashed + 1
			end

			if self:mouseCollidingWithFurniture(self.furniture[i]) then
				if mousejustpressed[1] then
					self.furniture[i]:attack()
				end
			end	
		end

		if numberOfFurnitureSmashed == 3 then
			self.angryMusic:stop()
			self.dingDong:play()
			self.state = "ending"
		end
	elseif self.state == "ending" then
		-- Sit still whilst the ending plays
		self.endingTimer = self.endingTimer + 1 * deltaTime

		if self.endingTimer > 2 and self.endingTimer < 2.1 then
			table.insert(self.bubbles, TextBubble("Oh for--", 810, player.y - 16))
		elseif self.endingTimer > 2.2 then
			-- Show the credits
			scene = "credits"
			self.endMusic:play()
		end
	end

	-- Text Bubbles
	for key, bubble in ipairs(self.bubbles) do
		bubble:update(deltaTime)

		-- Remove destroyed bubbles
		if bubble:getDestroyed() == true then
			table.remove(self.bubbles, key)
		end
	end

	-- Reset keyjustpressed
	for i, _ in pairs(keyjustpressed) do
		keyjustpressed[i] = false
	end

	-- Reset mousejustpressed
	for i, _ in pairs(mousejustpressed) do
		mousejustpressed[i] = false
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
	-- Clamp the position in the world
	self.x = math.min(math.max(self.x, 0), 1260 - (self.image:getWidth() / 2))
	self.y = math.min(math.max(self.y, 0), 632 - (self.image:getHeight() / 2))
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

function Player:mouseCollidingWithFurniture(item)
	local mouseX, mouseY = love.mouse.getPosition()
	local camX, camY = cam:getPosition()

	-- Measure from the top left
	camX = camX - (love.graphics.getWidth() / 2)
	camY = camY - (love.graphics.getHeight() / 2)
	local position = item:getPosition()
	local scale = item:getScale()

	if (mouseX + camX) > (position.x) and
	   (mouseX + camX) < (position.x + scale.width) and
	   (mouseY + camY) > (position.y) and
	   (mouseY + camY) < (position.y + scale.height) then
		return true
	end

	return false
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
		-- Indicate what to smash
		love.graphics.draw(self.indicator, 888, 345 + wave)
		love.graphics.draw(self.indicator, 587, 286 + wave)
		love.graphics.draw(self.indicator, 183, 356 + wave)
	end

	love.graphics.draw(self.image, self.x, self.y + wave)
	love.graphics.setColor(1, 1, 1, 1)

	for key, bubble in pairs(self.bubbles) do
		bubble:draw()
	end
end