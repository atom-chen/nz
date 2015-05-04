
--EnemyManager
local EnemyManager = class("EnemyManager", cc.mvc.ModelBase)

--event
EnemyManager.ENEMY_KILL_BANGFEI_EVENT      = "ENEMY_KILL_BANGFEI_EVENT"   --杀死召唤 
EnemyManager.ENEMY_SKILL_ADDHP_EVENT       = "ENEMY_SKILL_ADDHP_EVENT"    --全体回血

function EnemyManager:ctor(properties)
    EnemyManager.super.ctor(self, properties)
    self.enemys = {}
end

function EnemyManager:addEnemy(enemyView)
	self.enemys[#self.enemys + 1] = enemyView
end

function EnemyManager:removeEnemy(enemy)
	for i,v in ipairs(self.enemys) do
		if v == enemy then 
			local name = enemy:getNickname() 
			table.remove(self.enemys, i)
			enemy:removeFromParent()
			enemy = nil
		end
	end
end

function EnemyManager:getAllEnemys()
	return self.enemys
end

function EnemyManager:getEnemysByBuff(name)
	return self.enemys
end

function EnemyManager:doBuff(buffFuncStr, buffData)
	print("buffFuncStr", buffFuncStr)
	self[buffFuncStr](self, buffData)
end

function EnemyManager:doBuffAll_increaseHp(buffData)
	local value   = buffData.value
	local times  = buffData.times
	local name  = buffData.buffAnimName

	local enemys = self:getEnemysByBuff(name)
	for i,enemy in ipairs(enemys) do
		local enemyModel = enemy:getEnemyModel()
		local maxhp      = enemyModel:getMaxHp()
		local value      = maxhp * value
		if not enemyModel:isDead() then 
			enemyModel:increaseHp(value)
			enemy:playBuff(name)
		end
	end
end

function EnemyManager:doBuffAll_decreaseHp(buffData)
	local value   = buffData.value
	local times  = buffData.times
	local name  = buffData.buffAnimName

	local enemys = self:getEnemysByBuff(name)
	for i,enemy in ipairs(enemys) do
		local enemyModel = enemy:getEnemyModel()
		if not enemyModel:isDead() then 
			enemyModel:decreaseHp(value)
			enemy:playBuff(name)
		end
	end		
end

function EnemyManager:doBuffAll_pause(buffData)
	local value   = buffData.value
	local name  = buffData.buffAnimName

	print("function EnemyManager:doBuffAll_pause(buffData)")
	local enemys = self:getEnemysByBuff(name)
	for i,enemy in ipairs(enemys) do
		local enemyModel = enemy:getEnemyModel()
		if not enemyModel:isDead() then 
			print("		if not enemyModel:isDead() then ")
			enemy:setPause({isPause = true}) 
		end
	end		
end

return EnemyManager

