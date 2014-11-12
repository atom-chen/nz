local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“我”的实体

]]

--import
local Actor = import(".Actor")
local Gun = import(".Gun")
local Hero = class("Hero", Actor)

--events

function Hero:ctor(properties, events, callbacks)
    --instance
    local property = {
    	id = "hero",
    	maxHp = 1000,
    	demage = 10,
	}
    Hero.super.ctor(self, property)       
    self.gun = app:getInstance(Gun)
    
    --property
    local coolDown = self.gun:getCooldown()
    self:setCooldown(coolDown)
end

return Hero