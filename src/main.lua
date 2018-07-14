require("classic")
require("Player")
require("Posessable")

function love.load()
	player = Player(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
	tile = love.graphics.newImage("img/tile.png")
	lever = Possessable(64, 64)
	gamera = require("gamera")
	camera = gamera.new(0, 0, 2000, 2000)

	love.test = "test"
	print(love.test)
end

function love.update(deltaTime)
	player:update(deltaTime)
	camera:setPosition(player.x, player.y)
end

function love.draw()
	love.graphics.clear()

	-- NOTE: Graphics in LÖVE are sorted front to back
	-- Draw an example grid of tiles
	camera:draw(function (l, t, w, h)
		-- Everything in this function is drawn relative to the camera
		local tileSize = 21

		for x = 1, 32 do
			for y = 1, 32 do
				love.graphics.draw(tile, x * tileSize, y * tileSize)
			end
		end

		lever:draw()
		player:draw()
	end)
end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
		love.event.quit()
	end
end