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
	scene = "house" -- 'house' is the gameplay bit

	credits = {}
	credits.file = io.open("credits.txt", "rb")
	credits.content = credits.file:read("*all")
	credits.speed = 64
	credits.x = 0
	credits.y = love.graphics.getHeight()
	credits.file:close()
end

function love.update(deltaTime)
	if scene == "house" then
		player:update(deltaTime)
		cam:setPosition(player.x, player.y)
	elseif scene == "credits" then
		credits.y = credits.y - credits.speed * deltaTime

		if credits.y < -love.graphics.getHeight() then
			love.event.quit()
		end
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
		love.graphics.printf(
			credits.content,
			credits.x,
			credits.y,
			love.graphics.getWidth(),
			"center"
		)
	end
end