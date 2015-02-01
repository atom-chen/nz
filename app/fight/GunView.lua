
--[[--

“枪”的视图

]]
import("..includes.functionUtils")
local scheduler  = require(cc.PACKAGE_NAME .. ".scheduler")
local Gun  		 = import(".Gun")

local GunView = class("GunView", function()
    return display.newNode()
end)

function GunView:ctor()
	--instance
	-- dump(properties, "GunView properties")
	self.hero = md:getInstance("Hero")
	self.inlay = md:getInstance("FightInlay")
	self.isChanging = false
	self.isFiring = false
	self:refreshGun()

	--event
	cc.EventProxy.new(self.hero, self)
        :addEventListener(self.hero.GUN_CHANGE_EVENT, handler(self, self.playChange))
        :addEventListener(self.hero.FIRE_EVENT, handler(self, self.onHeroFire))

	cc.EventProxy.new(self.inlay, self)
        :addEventListener(self.inlay.INLAY_GOLD_BEGIN_EVENT, handler(self, self.onActiveGold))
        :addEventListener(self.inlay.INLAY_GOLD_END_EVENT,	 handler(self, self.onActiveGoldEnd))
end

function GunView:playIdle()
	--等动画播放完 todo
	self.armature:getAnimation():play("stand" , -1, 1) 
end

function GunView:fire()
	--bullet
	local num = self.gun:getCurBulletNum() - 1
	self.gun:setCurBulletNum(num)

	-- if self.isFiring == true then return end 	
	self.isFiring = true
	print("function GunView:playFire()")
	--枪火
	self.jqk   :setVisible(true)
	self.jqkzd :setVisible(true)
	self.dk    :setVisible(true)
	self.jqk:getAnimation()	 :play("fire" , -1, 0)
	self.jqkzd:getAnimation():play("qkzd" , -1, 0)
	self.dk:getAnimation()	 :play("danke", -1, 0)
	self.armature:getAnimation():play("fire" , -1, 0)	

	--sound
	local config = self.gun:getConfig()
	local soundName = config.imgName 			--动作特效	
	local soundSrc  = "res/Music/weapon/"..soundName.."fire.wav"
	self.audioId =  audio.playSound(soundSrc,false)		
end

function GunView:onHeroFire(event)
	-- print("function GunView:onHeroFire(event)")
	self:fire()
end

function GunView:stopFire()
	self.isFiring = false
	self.jqk  :setVisible(false)
	self.jqkzd:setVisible(false)
	self.dk   :setVisible(false)
	self:playIdle()
	-- audio.pauseSound(self.audioId)
end

function GunView:playChange(event)
	if self.isChanging then return end
	
	--clear
	self:setPosition(cc.p(0.0,0.0))

	-- print("GunView:playChange(event)")
	local disy = 150
	local actionDown = cc.MoveBy:create(0.2, cc.p(0.0, -disy))
	local actionUp 	 = cc.MoveBy:create(0.2, cc.p(0.0, disy))
	local function callFuncBeginChange()
		self.isChanging = true
	end

	local function callFuncChange()
		self:refreshGun()

	end 
	local function callFuncFinishChange()
		self.isChanging = false
	end

	local seq = cc.Sequence:create(
		cc.CallFunc:create(callFuncBeginChange),
		actionDown, 
		cc.CallFunc:create(callFuncChange), 
		actionUp,
		cc.CallFunc:create(callFuncFinishChange))

	self:runAction(seq)
end

function GunView:playReload()
	if self.hero:getIsReloading() then return end

	self.hero:setIsReloading(true)

	--effect
	local soundSrc  = "res/Music/fight/hzd.wav"
	self.audioId =  audio.playSound(soundSrc,false)	

	--回调 子弹full
	local reloadTime = self.gun:getReloadTime()
	local speedScale = 1 / reloadTime
	local function reloadDone()
		self.hero:setIsReloading(false)
		self.gun:setFullBulletNum()
	end
	scheduler.performWithDelayGlobal(reloadDone, reloadTime)
	
	--hero层reload动画
	-- print("GunView:playReload()")
	self.hero:dispatchEvent({
				name = self.hero.GUN_RELOAD_EVENT , speedScale = speedScale})
end

function GunView:canShot() 
	--bullets
	if self.gun:getCurBulletNum() <= 0 then 
		self:stopFire()
		self:playReload()
		local fight = md:getInstance("Fight")
		fight:dispatchEvent({name = fight.GUN_RELOAD_EVENT})
		return false 
	end
	
	--is changing
	return not self.isChanging
end

function GunView:setCoolDown(time)
	self.hero:setCooldown(time)
end

--hero层 发送换枪
function GunView:refreshGun()
	
	
	-- print("refreshGun")
	self.gun  = self.hero:getGun()
	--clear
	if self.armature then 
		self.armature:removeFromParent() 
	end

	--gun
	local config = self.gun:getConfig()
	-- dump(config, "config")
	
	--armature
	local animName = config.animName --动作特效
	local armature = ccs.Armature:create(animName)
    armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
	self.armature = armature
	self:playIdle()	
	self:addChild(armature)

	--isGold
	local isNativeGold = self.inlay:getIsNativeGold()
	local isGold = self.isGolding
	self:setGoldGun(isGold)

    --枪火 todo放在fp里
    local jqkName = config.jqkName --机枪口特效
    self.jqk = ccs.Armature:create(jqkName)
    self.jqk:setVisible(false)
    self.jqk:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent)) 
    local boneQk = armature:getBone("qk")
    local posBone = boneQk:convertToWorldSpace(cc.p(0, 0))
    local posArm = armature:convertToWorldSpace(cc.p(0, 0))
	local destpos = cc.p(posBone.x - posArm.x, posBone.y - posArm.y)
    self.jqk:setPosition(destpos.x, destpos.y)
    armature:addChild(self.jqk, -1)

    --枪火遮挡
    self.jqkzd = ccs.Armature:create(config.jqkzdName)
    self.jqkzd:setVisible(false)
   	self.jqkzd:setPosition(destpos.x, destpos.y)
    armature:addChild(self.jqkzd , 1)
    self.jqkzd:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent)) 
    
    --蛋壳
    self:addDanke()
end

function GunView:addDanke()
	self.dk = ccs.Armature:create("danke")
	self.dk:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
	--todo

	--special check
	local config = self.gun:getConfig()
	local animName = config["animName"]	
	local armature = self.armature
    local boneDk = armature:getBone("dk")
    local posBone = boneDk:convertToWorldSpace(cc.p(0, 0))
    local posArm = armature:convertToWorldSpace(cc.p(0, 0))
    local destpos = cc.p(posBone.x - posArm.x, posBone.y - posArm.y)
    self.dk:setVisible(false)
   	self.dk:setPosition(destpos.x, destpos.y)
    armature:addChild(self.dk , 3)	
end

function GunView:setGoldGun(isGold)
	local skinIndex = isGold and 1 or 0
	self.armature:getBone("gun"):changeDisplayWithIndex(skinIndex, true) 
	local boneIndex = 1
	while(true) do
		local boneStr = "gun"..boneIndex
		local bone = self.armature:getBone(boneStr)
		if bone == nil then break end
		bone:changeDisplayWithIndex(skinIndex, true)
		boneIndex = boneIndex + 1
	end
end

function GunView:onActiveGold(event)
	-- print("GunView:onActiveGold(event)")
	self.isGolding = true
	self.gun:setFullBulletNum()
	scheduler.performWithDelayGlobal(handler(self, self.playChange), 0.6)
end

function GunView:onActiveGoldEnd(event)
	self.isGolding = false
	self.gun:setFullBulletNum()
	scheduler.performWithDelayGlobal(handler(self, self.playChange), 0.6)
end

function GunView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		-- print("animationEvent id ", movementID)
		armatureBack:stopAllActions()
	end
end

return GunView