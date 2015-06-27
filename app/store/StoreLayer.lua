import("..includes.functionUtils")

local StoreCell       = import(".StoreCell")
local StoreBankNode   = import(".StoreBankNode")
local StoreMoneyNode  = import(".StoreMoneyNode")
local StorePropNode   = import(".StorePropNode")

local StoreLayer = class("StoreLayer", function()
    return display.newLayer()
end)

function StoreLayer:ctor()
    --instance
    self.storeModel = md:getInstance("StoreModel")
    self.selectType = ""
end

function StoreLayer:onShow()
    --load ccs
    if self.ui == nil then
        self:loadCCS()
        self:initUI()
    end

    -- refresh
    -- self:refreshUI("prop")
    self:refreshUI("bank")
    
    --event
    cc.EventProxy.new(self.storeModel , self)
        :addEventListener("REFRESH_STORE_EVENT", handler(self, self.refresh))
end

function StoreLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/Store")
	local controlNode = cc.uiloader:load("shangcheng.ExportJson")
    if self.ui then
        return
    end

    self.ui = controlNode
    self:addChild(controlNode)
    display.addSpriteFrames("shangcheng0.plist", "shangcheng0.png")
end

function StoreLayer:initUI()
    local panelBtn      = cc.uiloader:seekNodeByName(self.ui, "panelbtn")
	self.layerContent   = cc.uiloader:seekNodeByName(self.ui, "layerContent")
	self.btnprop        = cc.uiloader:seekNodeByName(panelBtn, "btnprop")
	self.btnbank        = cc.uiloader:seekNodeByName(panelBtn, "btnbank")
	self.btnmoney       = cc.uiloader:seekNodeByName(panelBtn, "btnmoney")
	self.btnprop:setTouchEnabled(true)
	self.btnbank:setTouchEnabled(true)
	self.btnmoney:setTouchEnabled(true)
    self.btnprop:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then                
                return true
            elseif event.name=='ended' then
                self:refreshUI("prop")
            end
        end)
     self.btnbank:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then 
            return true
        elseif event.name=='ended' then
            self:refreshUI("bank")
        end
    end)
     self.btnmoney:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then                
            return true
        elseif event.name=='ended' then
            self:refreshUI("money")
        end
    end)
end

function StoreLayer:refresh(event)
    local type = event.typename
    self:refreshUI(type)
end

function StoreLayer:refreshListView(type)
    self.layerContent:removeAllChildren()

    local contentNode = nil
    if type == "prop" then 
        contentNode = StorePropNode.new()
    elseif type == "bank" then 
        contentNode = StoreBankNode.new()
    elseif type == "money" then 
        contentNode = StoreMoneyNode.new()
    else
        assert(false, "type is invalid" .. type)
    end

    self.layerContent:addChild(contentNode)
end


function StoreLayer:refreshUI(type)
    self:refreshListView(type)
    self.btnprop:setColor(cc.c3b(80, 80, 80))
    self.btnbank:setColor(cc.c3b(80, 80, 80))
    self.btnmoney:setColor(cc.c3b(80, 80, 80))
    if type == "money" then
        self.btnmoney:setColor(cc.c3b(255, 255, 255))
    elseif type == "bank" then
        self.btnbank:setColor(cc.c3b(255, 255, 255))
    elseif type == "prop" then
        self.btnprop:setColor(cc.c3b(255, 255, 255))
    end
end

return StoreLayer