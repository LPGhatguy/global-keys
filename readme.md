# Global Keys for LÖVE
Global Keys is a library that lets you catch keypresses from other applications from within LÖVE!

It has the following limitations presently:
- Windows
- US key layout (others may work, but are untested)

Have a sample:

```lua
local gkeys = require("gkeys")

function love.load()
	gkeys.start()
end

function love.gkeypressed(key)
	print("DOWN:", key)
end

function love.gkeyreleased(key)
	print("UP:", key)
end

function love.update(dt)
	gkeys.update()
end
```