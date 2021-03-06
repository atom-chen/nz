
--[[--

“关卡详情”类

]]
local WeaponListModel = import("..weaponList.WeaponListModel")

local LevelDetailModel = class("LevelDetailModel", cc.mvc.ModelBase)

function LevelDetailModel:ctor(properties)
	LevelDetailModel.super.ctor(self, properties)
	self.config 	= nil 

	self:initConfigTable()
	self.weaponListModel = md:getInstance("WeaponListModel")
end

function LevelDetailModel:initConfigTable()
	self.config = getConfig("config/guanqia.json")
end

function LevelDetailModel:getConfig(groupId,levelId)
	assert(groupId and levelId, "param is nil")
	local config = nil
	local records = getRecordFromTable(self.config, "groupId", groupId)
	for k,v in pairs(records) do
		if v.levelId == levelId then
			config = v
		end
	end
	assert(config, "config is nil groupId is " .. groupId .. 
			"levelId is " .. levelId)
	return config
end

function LevelDetailModel:getCurLevelType(groupId,levelId)
    local record = self:getConfig(groupId, levelId)
    -- assert(record, "")
    if record == nil then return nil end
    local type = record["type"]
    -- assert(type, "")
    return type	
end

function LevelDetailModel:isJujiFight(groupId,levelId)
	assert(groupId and levelId, "groupId or levelId is nil")
	return self:getCurLevelType(groupId,levelId) == "juji" 
end

function LevelDetailModel:getNeedSuipianNum(weaponId)
	local weaponListModel = md:getInstance("WeaponListModel")
	local record = weaponListModel:getWeaponRecord(weaponId)
	if record["partNum"] then
		return record["partNum"]
	end
	return false
end

function LevelDetailModel:setsuipian(weaponId)
	local needNum = self:getNeedSuipianNum(weaponId)
	local data = getUserData()
	if self.weaponListModel:isWeaponExist(weaponId) then
		print("已拥有武器，你的碎片没的用")
	else
		if self:isBagsExistSuipian(weaponId)  then
			for k,v in pairs(data.weaponsuipian) do
				if v.weaponid == weaponId then
					data.weaponsuipian[k].number = data.weaponsuipian[k].number + 1
					if data.weaponsuipian[k].number == needNum then
						self:setWeaponTogether(weaponId)
					end
				end
			end
		else
			local weaponsuipian = {weaponid = weaponId, number = 1}
		    table.insert(data.weaponsuipian, weaponsuipian)
		end
	    setUserData(data)
	    dump(data.weaponsuipian)
	end
end

function LevelDetailModel:isBagsExistSuipian(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weaponsuipian) do
		if v.weaponid == weaponid then
			return true
		end
	end
	return false
end

function LevelDetailModel:getSuiPianNum(weaponid)
	local data = getUserData()
	if self:isBagsExistSuipian(weaponid)  then
		for k,v in pairs(data.weaponsuipian) do
			if v.weaponid == weaponid then
				return data.weaponsuipian[k].number
			end
		end
	else
		return 0
	end
end

function LevelDetailModel:setWeaponTogether(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weaponsuipian) do
		if v.weaponid == weaponid then
			table.remove(data.weaponsuipian,k)
			self.weaponListModel:buyWeapon(weaponid)
		end
	end
end

return LevelDetailModel