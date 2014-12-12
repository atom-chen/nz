local layers = {}

layers["FightPlayer"]  = import("..fight.FightPlayer")
local HomeBarLayer = import("..homeBar.HomeBarLayer")
local FightResultLayer = import("..fightResult.FightResultLayer")
local LayerColor_BLACK = cc.c4b(0, 122, 44, 0)

local RootLayer = class("RootLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function RootLayer:ctor()
	--instance

    --login
    self.curLayer = HomeBarLayer.new()
    self:addChild(self.curLayer)

	--event
	cc.EventProxy.new(ui, self)
		:addEventListener(ui.LAYER_CHANGE_EVENT, handler(self, self.switchLayer))
end

function RootLayer:switchLayer(event)
	-- dump(event, "event")
	local layer = event.layer
	self:removeAllChildren()
	self:addChild(layer)
end

function RootLayer:checkLoadLayer()
	
end


return RootLayer