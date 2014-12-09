import("..includes.functionUtils")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local FightResultModel = import(".FightResultModel")
local InlayModel = import("..inlay.InlayModel")

local FightResultLayer = class("FightResultLayer", function()
	return display.newLayer()
end)

function FightResultLayer:ctor()
    self.fightResultModel = app:getInstance(FightResultModel)
    self.inlayModel = app:getInstance(InlayModel)

    self.quickinlay = {}
    self.probaTable = {}
    self.showTable = {}
    self:initData()
	self:loadCCS()
	self:initUI()
	
	self:playstar(5)
	-- self:showCard(self.probaTable)
	self:playcard(self.probaTable)
end

function FightResultLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/LevelDetail/guanqiapingjia")
	local controlNode = cc.uiloader:load("guanqiapingjia.ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)

    --anim
    local src = "res/fightResult/anim/guangkajl/guangkajl.ExportJson"
    local starsrc = "res/fightResult/anim/gkjs_xing/gkjs_xing.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    manager:addArmatureFileInfo(starsrc)

    --play 发牌

end

function FightResultLayer:initData()
	self.probaTable = self:getinlayfall()
	for k,v in pairs(self.probaTable) do
		self.showTable[k] = v
	end
	local ran = math.random(#self.showTable)
	table.insert(self.showTable,ran,self.showTable[#self.showTable])
	table.remove(self.showTable,#self.showTable)
end
    
function FightResultLayer:playcard(showTable)
	--开牌 洗牌 扣牌
	local function playanim()

		
		self.armature:getAnimation():play("kaichixu" , -1, 1)
	end

	self.armature = ccs.Armature:create("guangkajl")	
    self.armature:setAnchorPoint(0.5,0.5)
    self.armature:setPosition(display.cx,display.cy-40)
    -- self.panelcard:addChild(self.armature)
    addChildCenter(self.armature, self.panelcard)
	self.armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))	
	
	for k,v in pairs(showTable) do
		local randomRecordID = v.inlayid
		local inlayrecord = self.fightResultModel:getInlayrecordByID(randomRecordID)
		
		local skin = ccs.Skin:createWithSpriteFrameName(inlayrecord["imgnam"]..".png")
	    self.armature:getBone("icon00"..k):addDisplay(skin, 1)
	    self.armature:getBone("icon00"..k):changeDisplayWithIndex(1, true)


		local node = cc.ui.UILabel.new({
        UILabelType = 2, text = inlayrecord["describe2"], size = 20})
		node:setAnchorPoint(cc.p(0.5,0.5))
 	    self.armature:getBone("label00"..k):addDisplay(node, 1)
	    self.armature:getBone("label00"..k):changeDisplayWithIndex(0, true)
	end

	-- self.armature:getAnimation():play("kaichixu" , -1, 1)

	scheduler.performWithDelayGlobal(playanim, 2)
end

function FightResultLayer:playstar(numStar)
	local posXinterval = 112
	for i=1,numStar do
		local delay = i * 0.5
		local function starcall()
		    local starArmature = ccs.Armature:create("gkjs_xing")
		    -- starArmature:setAnchorPoint(0,0)
		    -- display.cx+112*(i-3)
		    starArmature:setPosition(43.5,42)
		    self.star[i]:addChild(starArmature)
		    -- addChildCenter(starArmature,self.star[i])
			starArmature:getAnimation():play("gkjs_xing" , -1, 0)
		end
		scheduler.performWithDelayGlobal(starcall, delay)
	end
end

function FightResultLayer:initUI()
    local btnreplay = cc.uiloader:seekNodeByName(self, "btnreplay")
    local btnback = cc.uiloader:seekNodeByName(self, "btnback")
    local btnnext = cc.uiloader:seekNodeByName(self, "btnnext")
    local btninlay = cc.uiloader:seekNodeByName(self, "btninlay")
	btninlay:setTouchEnabled(true)
    addBtnEventListener(btninlay, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        	self:quickInlay()
        end
    end)
    self.card = {}
    for i=1,6 do
    	self.card[i] = cc.uiloader:seekNodeByName(self, "card"..i)
    	self.card[i]:setTouchEnabled(true)
    	self.card[i]:setVisible(false)
    	self.card[i]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then                
                return true
            elseif event.name=='ended' then
                	self:turnOverCard(i)
                	-- print("self:turnOverCar")
            end
        end)
    end
    self.cardover = {}
    self.cardtouch = {}
    self.cardicon = {}
    self.cardlabel = {}
    self.star = {}
    for i=1,6 do
    	self.cardover[i] = cc.uiloader:seekNodeByName(self, "cardover"..i)
    	self.cardicon[i] = cc.uiloader:seekNodeByName(self, "icon"..i)
    	self.cardlabel[i] = cc.uiloader:seekNodeByName(self, "labelcard"..i)
    	self.cardover[i]:setVisible(false)
    end
    for i=1,5 do
    	self.star[i] = cc.uiloader:seekNodeByName(self, "panelstar"..i)
	end
	self.panelcard = cc.uiloader:seekNodeByName(self, "panelcard")
end

function FightResultLayer:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		armatureBack:stopAllActions()
		if movementID == "kaichixu" then
				armatureBack:stopAllActions()
				armatureBack:getAnimation():play("koupai" , -1, 1)
    	elseif movementID == "fouchixu" then

    	elseif movementID == "koupai" then
    		armatureBack:getAnimation():play("xipai",-1,1)
		elseif movementID == "xipai" then
			    		print("caa")

			-- armatureBack:pause()
			-- self.armature:setVisible(false)
			self.armature:removeFromParent()
			for k,v in pairs(self.card) do
				v:setVisible(true)
			end
		elseif movementID == "fanpai00" then

    	end
	end
end

function FightResultLayer:star( LeftPersent )
	if LeftPersent < 0.2 then
		-- 1
		return 1
	elseif LeftPersent < 0.4 then
		-- 2
		return 2
	elseif LeftPersent < 0.6 then
		-- 3
		return 3
	elseif LeftPersent < 0.95 then
		-- 4
		return 4
	else
		-- 5
		return 5
	end
end

function FightResultLayer:getinlayfall()
	math.randomseed(os.time())
	
	local probaTable = {}
    local config = getConfig("config/inlayfall.json")

	for i=1,5 do
		local ran = math.random( 100)
		local total = 0
		for k,v in pairs(config) do
			total = total + v["probability"]
			if total > ran then
				table.insert(probaTable,{inlayid = v["inlayid"]})
				break
			end
		end
	end

	local rans = math.random(100)
	local table = getRecord(config,"type","special")
	local totals = 0
	for k,v in pairs(table) do
		totals = totals + v["probability"]
		if totals > rans then
			probaTable[6]={inlayid = v["inlayid"]}
			break
		end
	end
	-- dump(probaTable)
    return probaTable
end

function FightResultLayer:showCard(showTable)

	for k,v in pairs(showTable) do
		local randomRecordID = v.inlayid
		local inlayrecord = self.fightResultModel:getInlayrecordByID(randomRecordID)


		self.cardover[k]:setVisible(true)
		self.cardlabel[k]:setString(inlayrecord["describe2"])
		local icon = display.newSprite("#"..inlayrecord["imgnam"]..".png")
		addChildCenter(icon, self.cardicon[k]) 
	end
end

function FightResultLayer:turnOverCard(index)


	dump(self.probaTable)
	local ran = math.random(1, 100)
	local record
	if ran < 4 then
		local randomRecord = self.probaTable[#self.probaTable]
		local randomRecordID = randomRecord["inlayid"]
		local inlayrecord = self.fightResultModel:getInlayrecordByID(randomRecordID)
		record = inlayrecord
		table.insert(self.quickinlay, {inlayid = inlayrecord["id"]})
		self.inlayModel:buyInlay(inlayrecord["id"])
		table.remove(self.probaTable,#self.probaTable)
	else
		local rans = math.random(1, #self.probaTable-1)
		local randomRecord = self.probaTable[rans]
		local randomRecordID = randomRecord["inlayid"]
		local inlayrecord = self.fightResultModel:getInlayrecordByID(randomRecordID)
		record = inlayrecord
		table.insert(self.quickinlay, {inlayid = inlayrecord["id"]})
		self.inlayModel:buyInlay(inlayrecord["id"])
		table.remove(self.probaTable,rans)
	end

	transition.scaleTo(self.card[index], {scaleX = 0, time = 0.2})
	self.cardover[index]:setVisible(true)
	self.cardover[index]:setScaleX(0)
	self.cardlabel[index]:setString(record["describe2"])
	local icon = display.newSprite("#"..record["imgnam"]..".png")
	addChildCenter(icon, self.cardicon[index]) 
	local sequence = transition.sequence({cc.ScaleTo:create(0.2,0,1),cc.ScaleTo:create(0.2,1,1)})
	self.cardover[index]:runAction(sequence)
end

function FightResultLayer:quickInlay()
	dump(self.quickinlay)
	self.inlayModel:BestInlayInTable(self.quickinlay)
end

return FightResultLayer