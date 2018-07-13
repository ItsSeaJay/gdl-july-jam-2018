function love.load()
	player = require("player")
	tile = love.graphics.newImage("img/tile.png")
	gamera = require("gamera")
	camera = gamera.new(0, 0, 2000, 2000)
end

function love.update(deltaTime)
	player:update(deltaTime)
	camera:setPosition(player.x, player.y)
end

function love.draw()
	love.graphics.clear()

	-- NOTE: Graphics in LÖVE are sorted front to back
	-- Draw an example grid of tiles
	-- TODO: find out what l and t mean
	camera:draw(function (l, t, width, height)
		local tileSize = 21

		for x = 1, 32 do
			for y = 1, 32 do
				love.graphics.draw(tile, x * tileSize, y * tileSize)
			end
		end

		player:draw()
	end)
end