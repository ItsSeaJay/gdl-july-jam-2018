Object = require("classic")
Possessable = Object:extend()

function Possessable:new(x, y)
	self.x = x
	self.y = y
	self.image = love.graphics.newImage("img/lever.png")
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function Possessable:update()
	
end

function Possessable:draw()
	love.graphics.draw(self.image, self.x, self.y)
end