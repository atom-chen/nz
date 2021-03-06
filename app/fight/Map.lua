 --[[--

“map”的实体

]]

--includes
local Map = class("Map", cc.mvc.ModelBase)
--events
Map.EFFECT_LEI_BOMB_EVENT = "EFFECT_LEI_BOMB_EVENT"
Map.EFFECT_SHAKE_EVENT 	  = "EFFECT_SHAKE_EVENT"
Map.EFFECT_JUSHAKE_EVENT  = "EFFECT_JUSHAKE_EVENT"
Map.EFFECT_DANDAO_EVENT   = "EFFECT_DANDAO_EVENT"
Map.EFFECT_FOCUS_EVENT 	  = "EFFECT_FOCUS_EVENT"

Map.MAP_ZOOM_OPEN_EVENT   = "MAP_ZOOM_OPEN_EVENT"
Map.MAP_ZOOM_RESUME_EVENT = "MAP_ZOOM_RESUME_EVENT"

Map.GUN_OPEN_JU_EVENT	  = "GUN_OPEN_JU_EVENT"
Map.GUN_CLOSE_JU_EVENT    = "GUN_CLOSE_JU_EVENT"

Map.AWARD_PROP_EVENT 	  = "AWARD_PROP_EVENT" 	  

Map.WAVE_UPDATE_EVENT 	  = "WAVE_UPDATE_EVENT" 

function Map:ctor()
    Map.super.ctor(self)
    self.isJuAble  = true
    self.isOpenJu_ = false
    self.waveIndex = 1
    local fightFactory  = md:getInstance("FightFactory")
    self.fight 		    = fightFactory:getFight()
    self:setCurWaveConfig()
end

function Map:setCurWaveConfig()
	local fightConfigs  = md:getInstance("FightConfigs")
	local waveConfig = fightConfigs:getWaveConfig()
	self.curWaveCfg = waveConfig
end

function Map:getCurWaveConfig()
	return self.curWaveCfg 
end

function Map:setWaveIndex(index)
	assert(index)
	self.waveIndex = index
	self:dispatchEvent({name = Map.WAVE_UPDATE_EVENT, 
		waveIndex = self.waveIndex})
end

function Map:getWaveNum()
	local num = #(self.curWaveCfg.waves)
	return num
end

function Map:getWaveIndex()
	return self.waveIndex
end

function Map:setIsOpenJu(isOpenJu_, pos)
	self.isOpenJu = isOpenJu_
	if self.isOpenJu then 
		assert(pos, "pos is nil")
		self:dispatchEvent({name = Map.GUN_OPEN_JU_EVENT, pos = pos})	
	else
		self:dispatchEvent({name = Map.GUN_CLOSE_JU_EVENT})
		self.fight:dispatchEvent({name = self.fight.FIGHT_RESUMEPOS_EVENT})
	end
end

function Map:getIsOpenJu()
	return self.isOpenJu
end

function Map:setIsJuAble(able)
	self.isJuAble = able
end

function Map:getIsJuAble()
	return self.isJuAble
end

-- function Map:changeJuStatus()
	-- self.isJu = not self.isJu
	-- local data = {gunView = not self.isJu, btnLei = not self.isJu, 
	-- 		label_leiNum = not self.isJu }
	-- self.fight:dispatchEvent({name = self.fight.CONTROL_SET_EVENT,comps = data})
-- end

function Map:playEffect(name)
	if name == "shake" then
		self:dispatchEvent({name = Map.EFFECT_SHAKE_EVENT})
	else

	end
end

function Map:isNotMoveMap()
	local notmove = self.curWaveCfg:getIsNotMoveMap()
	return notmove
end

function Map:getMapBgNode()
	return self.mapBgNode 
end

function Map:setMapBgNode(mapBgNode)
	self.mapBgNode = mapBgNode
end

function Map:getDandaoRotate(enemyPos)
	--rotate
	local rotateRight = math.random(15, 50)
	local rotateLeft  = math.random(130, 165)	
	local rotate
	if enemyPos.x < display.width / 2 then 
		rotate = rotateRight
	else
		rotate = rotateLeft
	end

	return rotate	
end

return Map