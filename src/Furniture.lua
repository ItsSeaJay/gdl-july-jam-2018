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
end

function Furniture:draw()
	love.graphics.draw(self.x, self.y, self.image)
end