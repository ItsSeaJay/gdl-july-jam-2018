Object = require("classic")
Furniture = Object:extend()

function Furniture:new(x, y, normalImage, smashedImage, maxHealth)
	self.x = x
	self.y = y
	self.normalImage = love.graphics.newImage(normalImage)
	self.smashedImage = love.graphics.newImage(smashedImage)
	self.image = self.normalImage
	self.health	= maxHealth
	self.smashed = false
	self.hitSound = love.audio.newSource("sfx/smash.wav", "static")
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function Furniture:update(deltaTime)
	if self.health == 0 then
		self.smashed = true
	end

	if self.smashed then
		self.image = self.smashedImage
	else
		self.image = self.normalImage
	end
end

function Furniture:attack()
	self.health = math.max(self.health - 1, 0)
	
	if self.health > 0 then
		love.audio.play(self.hitSound)
	end
end

function Furniture:getPosition()
	local position = {}
	position.x = self.x
	position.y = self.y

	return position
end

function Furniture:getScale()
	local scale = {}
	scale.width = self.width
	scale.height = self.height

	return scale
end

function Furniture:draw()
	love.graphics.draw(self.image, self.x, self.y)
end