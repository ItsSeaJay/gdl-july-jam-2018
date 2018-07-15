Object = require("classic")
TextBubble = Object:extend()

function TextBubble:new(x, y, size, speed)
	self.x = x
	self.y = y
	self.targetMessage = "Hello, World!"
	self.currentMessage = ""
	self.font = love.graphics.newFont("ttf/m5x7.ttf", size)
	self.textDelta = 0
	self.textSpeed = speed
	self.destroyed = false
end

function TextBubble:update(deltaTime)
	self.currentMessage = string.sub(self.targetMessage, 0, self.textDelta)
	self.textDelta = self.textDelta + self.textSpeed * deltaTime
	self.textDelta = math.min(self.textDelta, string.len(self.targetMessage))
end

function TextBubble:draw()
	love.graphics.setFont(self.font)
	love.graphics.print(
		self.currentMessage,
		self.x,
		self.y
	)
end

function TextBubble:setPosition(x, y)
	self.x = x
	self.y = y
end