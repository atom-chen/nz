import("..includes.functionUtils")

local PropModel = class("PropModel", cc.mvc.ModelBase)

PropModel.PROP_UPDATE_EVENT = "PROP_UPDATE_EVENT"

function PropModel:ctor(properties, events, callbacks)
	PropModel.super.ctor(self, properties)
end

function PropModel:getPropNum(nameid)
	local data = getUserData()
	local prop = data.prop[nameid]
	assert(prop, "prop is nil nameid " .. nameid)
	local propnum = prop.num
	return propnum
end

--[[
	lei;jijia;hpBag
]]

function PropModel:addProp(nameid,buyNum)
	local data = getUserData()
	local prop = data.prop[nameid]
	assert(prop, "prop is nil invalid nameid:"..nameid)	
	local propnum = prop.num + buyNum
	data.prop[nameid].num = propnum
    setUserData(data)
    self:refreshInfo()
end

function PropModel:costProp(nameid,costNum)
	local data = getUserData()
	local prop = data.prop[nameid]
	assert(prop, "prop is nil invalid nameid:"..nameid)
	local propnum = prop.num - costNum
	data.prop[nameid].num = propnum
	setUserData(data)
	if nameid == "lei" then
		um:use("手雷", costNum, 0)
	elseif nameid == "jijia" then
		um:use("无敌机甲", costNum, 0)
	elseif nameid == "hpBag" then 
		um:use("医疗包", costNum, 0)
	end
	self:refreshInfo()
end

function PropModel:refreshInfo()
	print("function PropModel:refreshInfo()")
	self:dispatchEvent({name = PropModel.PROP_UPDATE_EVENT})
end

return PropModel