Object = require("classic")
TextBubble = Object:extend()

function TextBubble:new(message, x, y)
	self.x = x
	self.y = y
	self.targetMessage = message
	self.currentMessage = ""
	self.font = love.graphics.newFont("ttf/m5x7.ttf", 32)
	self.textDelta = 0
	self.textSpeed = 32
	self.life = 0
	self.duration = string.len(message) / 4
	self.destroyed = false
end

function TextBubble:update(deltaTime)
	self.currentMessage = string.sub(self.targetMessage, 0, self.textDelta)
	self.textDelta = self.textDelta + self.textSpeed * deltaTime
	self.textDelta = math.min(self.textDelta, string.len(self.targetMessage))
	self.life = self.life + deltaTime

	-- Destroy the bubble if it's been too long
	if self.life >= self.duration then
		self.destroyed = true
	end
end

function TextBubble:draw()
	love.graphics.setFont(self.font)
	love.graphics.print(
		self.currentMessage,
		self.x,
		self.y
	)
end

function TextBubble:setMessage(message)
	self.targetMessage = message
end

function TextBubble:setPosition(x, y)
	self.x = x
	self.y = y
end

function TextBubble:getDestroyed()
	return self.destroyed
end