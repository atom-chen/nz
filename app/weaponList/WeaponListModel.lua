import("..includes.functionUtils")
--[[--

“武器库”类

]]
local WeaponListModel = class("WeaponListModel", cc.mvc.ModelBase)

WeaponListModel.REFRESHBTN_EVENT = "REFRESHBTN_EVENT"

function WeaponListModel:ctor(properties, events, callbacks)
	WeaponListModel.super.ctor(self, properties)
	self:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function WeaponListModel:getWeaponRecord(index)
	local WeaponRecord = getRecordByID("config/weapon_weapon.json", index)
	return WeaponRecord
end

--已强化等级
function WeaponListModel:getIntenlevel(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponid then
				return v["intenlevel"]
			end
		end
	end
	return 0
end

function WeaponListModel:getWeaponNameByID(weaponid)
	local record = getRecordByKey("config/weapon_weapon.json", "id", weaponid)
	local WeaponName = record[1]["name"]
	return WeaponName
end

function WeaponListModel:getWeaponProperity(weaponid,level)
	--bullet accuracy reload damage
	local record = getRecordByKey("config/weapon_weapon.json", "id", weaponid)
	local growTableName = record[1]["growTable"]
	if level == nil then
		level = self:getIntenlevel(weaponid)
	elseif level == "nextLevel" then
		level = self:getIntenlevel(weaponid)
		if level == 10 then
			level = 10
		else
			level =self:getIntenlevel(weaponid)+1
		end
	end
	local growtableStr = "config/weapon_"..growTableName..".json"
	local intenlevelData = getRecordByKey(growtableStr,"level",level)[1]
	local bulletNum = intenlevelData["bulletNum"]
	local accuracy = intenlevelData["accuracy"]
	local reloadTime = intenlevelData["reloadTime"]
	local demage = intenlevelData["demage"]
	local property = {bulletNum = bulletNum,accuracy  = accuracy,reloadTime = reloadTime,demage = demage}
	return property
end

function WeaponListModel:setWeapon(weaponid)
	if self:isWeaponExist(weaponid)  then
        print("已拥有")
    else
    	local intensify = {weaponid = weaponid,intenlevel = 0}
	    local data = getUserData()
	    table.insert(data.weapons.bags, intensify)
	    setUserData(data)
	    -- dump(GameState.load())
    end 
end

function WeaponListModel:buyWeapon(weaponid)
	self:setWeapon(weaponid)
	self:dispatchEvent({name = WeaponListModel.REFRESHBTN_EVENT})
end

function WeaponListModel:intensify(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponid then
				if data.weapons.bags[k].intenlevel < 10 then
					--todo 成长表
					data.weapons.bags[k].intenlevel = data.weapons.bags[k].intenlevel + 1
				    setUserData(data)
			    else
			    	print("已满级")
				end
			end
		end
	end
	self:dispatchEvent({name = WeaponListModel.REFRESHBTN_EVENT})
end

function WeaponListModel:onceFull(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponid then
				if data.weapons.bags[k].intenlevel < 10 then
					data.weapons.bags[k].intenlevel = 10
					setUserData(data)
				else
			    	print("已满级")
				end
			end
		end
	end
	self:dispatchEvent({name = WeaponListModel.REFRESHBTN_EVENT})
end

--isWeInBag
function WeaponListModel:isWeaponExist(weaponid)
	local data = getUserData()
	for k,v in pairs(data.weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponid then
				return true
			end
		end
	end
	return false
end


--todo getWeaponStatus
--[[
	return 1(in bag1), 2(in bag2), 3(not in bag)
]]
function WeaponListModel:isWeaponed(weaponid)
	local data = getUserData()
	-- dump(data.weapons, "data.weapons")
	if data.weapons.weaponed.bag1.weaponid == weaponid then
		return 1
	elseif data.weapons.weaponed.bag2.weaponid == weaponid then
		return 2
	else
		return 0
	end
end

--isFullLevel
function WeaponListModel:isFull(weaponid)
	local data = getUserData()
	local kFullLevel = 10
	for k,v in pairs(data.weapons.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "weaponid" and v1 == weaponid then
				if data.weapons.bags[k].intenlevel == kFullLevel then
			    	return true
				end
			end
		end
	end
	return false
end


----- weaponBag 
function WeaponListModel:getWeaponInBag()
	local data = getUserData()
	-- dump(data)
	local twoWeapon={}
	table.insert(twoWeapon,data.weapons.weaponed.bag1)
	table.insert(twoWeapon,data.weapons.weaponed.bag2)
	return twoWeapon
end

function WeaponListModel:equipBag( weaponid, index )
	local data = getUserData()
	if self:isWeaponed(weaponid) == 0 then
		for k,v in pairs(data.weapons.bags) do
			for k1,v1 in pairs(v) do
				if k1 == "weaponid" and v1 == weaponid then
					if index == 1 then
						data.weapons.weaponed.bag1 = v
					else
						data.weapons.weaponed.bag2 = v
					end
					setUserData(data)
					-- dump(data)
				end
			end
		end
	elseif self:isWeaponed(weaponid) == index then
		print("已装备包1")
	else
		local x = nil
		x = data.weapons.weaponed.bag1
		data.weapons.weaponed.bag1 = data.weapons.weaponed.bag2
		data.weapons.weaponed.bag2 = x
	end
	self:dispatchEvent({name = WeaponListModel.REFRESHBTN_EVENT})
	-- dump(data)
end

function WeaponListModel:getFightWeaponValue(bagIndex)
	assert(bagIndex, "bagIndex is nil")
	local data = getUserData()
	local weapon = data.weapons.weaponed[bagIndex]
	local id = weapon["weaponid"]
	assert(id, "id is nil bagIndex is invalid:"..bagIndex)
	local weaponValue = self:getWeaponProperity(id) 

	--cooldown
	local record = getRecordByKey("config/weapon_weapon.json", "id", id)
	record = record[1]
	table.merge(weaponValue, record)
	return weaponValue
end

return WeaponListModel