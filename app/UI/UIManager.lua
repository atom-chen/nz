local UI = class("UIManager",cc.mvc.ModelBase)

local PauseScene = require("app.pause.PauseScene")

-- 定义事件
UI.LAYER_CHANGE_EVENT 	= "LAYER_CHANGE_EVENT"
UI.POPUP_SHOW_EVENT   	= "POPUP_SHOW_EVENT"
UI.POPUP_CLOSE_EVENT   	= "POPUP_CLOSE_EVENT"
UI.POPUP_CLOSEALL_EVENT = "POPUP_CLOSEALL_EVENT"
UI.LOAD_SHOW_EVENT 		= "LOAD_SHOW_EVENT"
UI.LOAD_HIDE_EVENT 		= "LOAD_HIDE_EVENT"
UI.PAUSESCENE_SHOW_EVENT     = "SCENE_SHOW_EVENT"
UI.PAUSESCENE_CLOSE_EVENT    = "SCENE_CLOSE_EVENT"

--保存layer
local layerClasses = {}
-- layerClasses["LoadingLayer"] 		 = import("..load.LoadingLayer")
layerClasses["FightPlayer"] 		 = import("..fight.FightPlayer")
layerClasses["WeaponBag"] 		     = import("..weaponList.WeaponBag")
layerClasses["HomeBarLayer"]		 = import("..homeBar.HomeBarLayer")
layerClasses["FightResultLayer"]     = import("..fightResult.FightResultLayer")
layerClasses["LevelDetailLayer"] 	 = import("..levelDetail.LevelDetailLayer")
layerClasses["DialogLayer"] 		 = import("..dialog.DialogLayer")
layerClasses["StartLayer"]           = import("..start.StartLayer")

layerClasses["storyLayer"]           = import("..start.StoryLayer")

layerClasses["DailyLoginLayer"]      = import("..dailyLogin.DailyLoginLayer")

--popup
layerClasses["FightResultPopup"] 	 = import("..fightResult.FightResultPopup")
layerClasses["FightResultFailPopup"] = import("..fightResult.FightResultFailPopup")
layerClasses["commonPopup"] 		 = import("..commonPopup.commonPopup")

-- 关于Popup
layerClasses["AboutPopup"]           = import("..start.AboutPopup")

-- giftBag
layerClasses["GiftBagPopup"]      	 = import("..buy.GiftBagPopup")

-- pausePopup
layerClasses["pausePopup"]           = import("..pause.PausePopup")


function UI:ctor(properties)
    UI.super.ctor(self, properties) 
	--instance
end

function UI:changeLayer(layerId, properties)
	print("function UI:changeLayer(layerId)")
	local loadingType = nil
	if properties then loadingType = properties.loadingType end
	if loadingType == nil and layerId ==  "FightPlayer" then 
		loadingType = "fight" 
	elseif loadingType == nil and layerId == "HomeBarLayer" then 
		loadingType = "home"
	else
		
	end

	local layerCls = self:getLayerCls(layerId)
	self:dispatchEvent({name = UI.LAYER_CHANGE_EVENT, layerCls = layerCls,
		 loadingType = loadingType, properties = properties})
end

function UI:showPopup(layerId, properties, extra)
	local opacity 
	local anim
	local animName
	local isPauseScene
	local isPauseSecond
	if extra then 
		opacity = extra.opacity
		anim = extra.anim
		animName = extra.animName
		isPauseScene = extra.isPauseScene
		isPauseSecond = extra.isPauseSecond
		isNotScrenCapture = extra.isNotScrenCapture
		properties.isPauseScene = extra.isPauseScene
		properties.isFight = extra.isFight
	end

	local layerCls = self:getLayerCls(layerId)

	print("UI:showPopup(layerId, properties, extra)")
	
	if not isPauseScene then
		print("1UI:showPopup isPauseScene:",isPauseScene)
		self:dispatchEvent({name = UI.POPUP_SHOW_EVENT, layerCls = layerCls, 
			opacity = opacity, anim = anim, animName = animName,
			properties = properties})
	else
		print("2UI:showPopup isPauseScene:",isPauseScene)
		if not isPauseSecond then 
			local pauseScene = PauseScene.new()
		end
		print(type(pauseScene))
		self:dispatchEvent({name = UI.PAUSESCENE_SHOW_EVENT, layerCls = layerCls,
			opacity = opacity, anim = anim,isPauseSecond = isPauseSecond,isNotScrenCapture = isNotScrenCapture,
			properties = properties})
	end
end

function UI:closePopup(layerId,extra)
	local isCancelAnim
	if extra then
		isCancelAnim = extra.isCancelAnim
	end
	self:dispatchEvent({name = UI.POPUP_CLOSE_EVENT, layerId = layerId, isCancelAnim = isCancelAnim})
end

function UI:closeAllPopups()
	self:dispatchEvent({name = UI.POPUP_CLOSEALL_EVENT})
end

function UI:getLayerCls(layerId)
	local cls = layerClasses[layerId]
	assert(cls, "cls is nil cls id:"..layerId)
	return cls
end

function UI:showLoad(type)
	self:dispatchEvent({name = UI.LOAD_SHOW_EVENT,type = type})
end

function UI:hideLoad()
	self:dispatchEvent({name = UI.LOAD_HIDE_EVENT})
end

function UI:setIsPause()
	self.isPauseScene
end

return UI

