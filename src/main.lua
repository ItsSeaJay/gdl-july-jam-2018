require("classic")
require("Player")
require("TextBubble")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	player = Player(
		570, -- X
		632 -- Y
	)
	cam = require("cam")
	background = love.graphics.newImage("img/background.png")
	scene = "house"
end

function love.update(deltaTime)
	if scene == "house" then
		player:update(deltaTime)
		cam:setPosition(player.x, player.y)
	end
end

function love.draw()
	-- NOTE: Graphics in LÖVE are sorted front to back
	love.graphics.clear()

	if scene == "house" then
		-- Everything in this function is drawn relative to the cam
		cam:draw(function (l, t, w, h)

			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(background, 0, 0)
			player:draw()
		end)
	elseif scene == "credits" then
		love.graphics.print("The End")
	end
end