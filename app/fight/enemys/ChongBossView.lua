

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local BaseBossView = import(".BaseBossView")
local FightConfigs = import("..fightConfigs.FightConfigs")
local ChongBossView = class("ChongBossView", BaseBossView)

function ChongBossView:ctor(property)
	ChongBossView.super.ctor(self, property) 
end

function ChongBossView:playFire()
	-- 2 3
	-- 1 4 
	print("发射导弹")
	self.armature:getAnimation():play("daodan" , -1, 1) 
	local offsetPoses ={cc.p(-100,-100), cc.p(-100, 100), cc.p(100, 100), cc.p(100,-100) }
	for i=1,4 do
		local boneName = "dao"..i
		local bone = self.armature:getBone(boneName):getDisplayRenderNode()		
		local delay = 0.3 + 0.10 * i 
		local property = {
			type = "missile",
			srcScale = self:getScale() * 0.3, --导弹view用
			id = self.property["enemyId"], 
			demageScale = self.enemy:getDemageScale(),
			offset = offsetPoses[i],
		}
		local function callfuncAddDao()
			local srcPos = bone:convertToWorldSpace(cc.p(0.0,0.0))
			property.srcPos = srcPos
			property.destPos = srcPos
			self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, 
				property = property})
		end
		local sch = scheduler.performWithDelayGlobal(callfuncAddDao, delay)
	    self:addScheduler(sch)
	end
end

function ChongBossView:playTieQiu()
	self.armature:getAnimation():play("reng", -1, 1)

	local kDelayAnim = 1.0 		-- 导弹动画播放0.6s 再发导弹
	--导弹
	for i=1,1 do
		local boneName = "qiu"..i
		local bone = self.armature:getBone(boneName):getDisplayRenderNode()
		local delay = kDelayAnim
		local property = {
			type = "missile",
			missileType = "tie",
			srcScale = self:getScale(), --导弹view用
			demageScale = self.enemy:getDemageScale(),
			animName = "bls",
			destScale = 3.0,
			id = self.property["qiuId"], 
		}
		local function callfuncAddDao()
			local srcPos = bone:convertToWorldSpace(cc.p(0.0,0.0))
			property.srcPos = srcPos
			property.destPos = srcPos			
			self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, 
				property = property})
		end
		local sch = scheduler.performWithDelayGlobal(callfuncAddDao, delay)
	    self:addScheduler(sch)    
	end		
end

return ChongBossView