require("classic")
require("Player")
require("TextBubble")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	player = Player(
		love.graphics.getWidth() / 2, -- X
		love.graphics.getHeight() / 2 -- Y
	)
	gamera = require("gamera")
	camera = gamera.new(0, 0, 2000, 2000)
end

function love.update(deltaTime)
	player:update(deltaTime)
	camera:setPosition(player.x, player.y)
end

function love.draw()
	-- NOTE: Graphics in LÖVE are sorted front to back
	love.graphics.clear()

	-- Everything in this function is drawn relative to the camera
	camera:draw(function (l, t, w, h)

		player:draw()
	end)
end