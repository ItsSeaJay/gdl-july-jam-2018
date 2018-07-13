function love.load()
	player = require("player")
	tile = love.graphics.newImage("img/tile.png")
end

function love.update(deltaTime)
	player:update(deltaTime)
end

function love.draw()
	love.graphics.clear()

	-- NOTE: Graphics in LÖVE are sorted front to back
	-- Draw an example grid of tiles
	local tileSize = 21

	for x = 1, 32 do
		for y = 1, 32 do
			love.graphics.draw(tile, x * tileSize, y * tileSize)
		end
	end

	player:draw()
end