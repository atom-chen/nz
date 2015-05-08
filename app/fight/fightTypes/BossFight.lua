local Fight   = import(".Fight") 

local BossFight = class("BossFight", Fight)
function BossFight:ctor(properties)
	dump(properties, "properties")
	BossFight.super.ctor(self, properties)

	--instance
	self.chapterIndex = properties.chapterIndex
end

function BossFight:startFightResult()
	--closeFunc
	local function closeFunc()
		local resultData = self:getResultData()
	    ui:changeLayer("HomeBarLayer",{fightData = resultData})
	end

	--desc
	local map = md:getInstance("Map")
	local waveIndex = map:getWaveIndex()
	local curWaveIndex = waveIndex - 1
    local fightDescModel = md:getInstance("FightDescModel")
    local data = {
	    name         = fightDescModel.BOSSGIFT_ANIM_EVENT,
    	chapterIndex = self.chapterIndex,
    	waveIndex    = curWaveIndex,
    	closeFunc    = closeFunc,
	}
    fightDescModel:dispatchEvent(data)

    --data
	local bossModeModel = md:getInstance("BossModeModel")
	bossModeModel:setBossModeWave(self.chapterIndex, curWaveIndex)    
end

function BossFight:getResultData()
	local levelMapModel = md:getInstance("LevelMapModel")
    local groupId, levelId = levelMapModel:getConfig()
	local resultData = {}
	resultData["fightType"] = self:getFightType()
	resultData["chapterIndex"] = 1 
	resultData["groupId"]   = groupId
	resultData["levelId"]   = self:getLevelId()
	resultData["result"]    = self:getResult() 
	return resultData   
end

function BossFight:isJujiFight()
    return false 
end

function BossFight:getFightType()
	return "bossFight"
end

function BossFight:waveUpdate(nextWaveIndex, waveType)
	if nextWaveIndex == 1 then return end
	--award

	local curWaveIndex = nextWaveIndex - 1
	local bossModeModel = md:getInstance("BossModeModel")
	bossModeModel:setBossModeWave(self.chapterIndex, curWaveIndex)

	--desc
	local function closeFunc()
		print("closeFunc!")
		self:pauseFight(false)
	end

	local map = md:getInstance("Map")
	local waveIndex = map:getWaveIndex()
    local fightDescModel = md:getInstance("FightDescModel")
    local data = {
	    name         = fightDescModel.BOSSGIFT_ANIM_EVENT,
    	chapterIndex = self.chapterIndex,
    	waveIndex    = curWaveIndex,
    	closeFunc    = closeFunc,
	}

    fightDescModel:dispatchEvent(data)
    self:pauseFight(true)
end


return BossFight