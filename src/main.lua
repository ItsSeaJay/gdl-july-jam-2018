require("classic")
require("Player")
require("TextBubble")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	player = Player(
		love.graphics.getWidth() / 2, -- X
		love.graphics.getHeight() / 2 -- Y
	)
	cam = require("cam")
	background = love.graphics.newImage("img/background.png")
end

function love.update(deltaTime)
	player:update(deltaTime)
	cam:setPosition(player.x, player.y)
end

function love.draw()
	-- NOTE: Graphics in LÖVE are sorted front to back
	love.graphics.clear()

	-- Everything in this function is drawn relative to the cam
	cam:draw(function (l, t, w, h)

		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(background, 0, 0)
		player:draw()
	end)
end