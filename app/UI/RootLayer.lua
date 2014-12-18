
local HomeBarLayer = import("..homeBar.HomeBarLayer")
local LayerColor_BLACK = cc.c4b(0, 122, 44, 0)

local RootLayer = class("RootLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function RootLayer:ctor()
	--instance
	
	--add res
	self:addArmatureFile()
	self:addSpriteFrames()
	
    --login
    self.curLayer = HomeBarLayer.new()
    -- self.curLayer = FightResultFailPopup.new()
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

function RootLayer:addSpriteFrames()
	display.addSpriteFrames("allImg0.plist", "allImg0.png")
    display.addSpriteFrames("weaponicon0.plist", "weaponicon0.png")
end

function RootLayer:addArmatureFile()
    --all enemys
    local enemyImgs = 
    {"anim_enemy_002", "jinzhanb", "zibaob", "boss01","boss02", "dunbing", 
        "sanbing01", "daodan", "zpbing"}
    local function dataLoaded(percent)
        print(" dataLoaded() percent:"..percent)
    end    

    local manager = ccs.ArmatureDataManager:getInstance()
    for i,v in ipairs(enemyImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, dataLoaded)
    end

    --all uiAnims
    local uiImgs = {"baotou", "hjwq", "huanzidan", "ruodiangj", "tanhao",
        "avatarhit", "blood1", "blood2", "gold", "shoulei"}
    for i,v in ipairs(uiImgs) do
        local src = "res/Fight/uiAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, dataLoaded)
    end
end

return RootLayer