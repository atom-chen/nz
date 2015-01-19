
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local CommonEnemyView = class("CommonEnemyView", BaseEnemyView)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

function CommonEnemyView:ctor(property)
	CommonEnemyView.super.ctor(self, property) 

    --test
    self:test()

    local function callStart()
    	self:playStartState(property.startState)
    end
    scheduler.performWithDelayGlobal(callStart, 0.01)
end

---- state ----
function CommonEnemyView:playStartState(state)
	if state == "rollleft" then 
		self:playRollLeft()
	elseif state == "rollright" then
		self:playRollRight()	
	else 
		self:playStand()
	end
end

function CommonEnemyView:playThrow()
	self.armature:getAnimation():play("throw", -1, 1)
	local pos = cc.p(self:getPositionX(), self:getPositionY() + 220)
	local function test( )
		print("hello world")
	end
	self.enemy:hit(self.hero)
end

function CommonEnemyView:playRoll()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:play("playRollLeft", handler(self, self.playRollLeft))
	else
		self:play("playRollRight", handler(self, self.playRollRight))
	end
end

function CommonEnemyView:playRollLeft()
	if not self:checkPlace(-define.kEnemyRollWidth * self:getScale()) then return end
	self.armature:getAnimation():play("rollleft" , -1, 1) 
	local speed = define.kEnemyRollSpeed  * self:getScale() 

	local action = cc.MoveBy:create(1/60, cc.p(-speed, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))	
end

function CommonEnemyView:playRollRight()
	if not self:checkPlace(define.kEnemyRollWidth * self:getScale()) then return end
	self.armature:getAnimation():play("rollright" , -1, 1) 
	local speed = define.kEnemyRollSpeed  * self:getScale() 

	local action = cc.MoveBy:create(1/60, cc.p(speed, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))			
end

function CommonEnemyView:test()
	--body
	local weakNode = self.armature:getBone("weak1"):getDisplayRenderNode()
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
	drawBoundingBox(self.armature, weakNode, "red") 
	drawBoundingBox(self.armature, bodyNode, "yellow") 
end

--Attackable interface
function CommonEnemyView:tick(t)
	--change state
	--fire
	local fireRate, isAble = self.enemy:getFireRate()
	assert(fireRate > 1, "invalid fireRate")
	if isAble then 
		randomSeed = math.random(1, fireRate)
		if randomSeed > fireRate - 1 then 
			self:playAfterAlert("playFire", handler(self, self.playFire))
			self.enemy:beginFireCd()
		end
	end


	--walk
	local walkRate, isAble = self.enemy:getWalkRate()
	assert(walkRate > 1, "invalid walkRate")

	if isAble then
		randomSeed =  math.random(1, walkRate)
		if randomSeed > walkRate - 1 then 
			self:play("playWalk", handler(self, self.playWalk))
			self.enemy:beginWalkCd()
		end
	end

	--roll
	local rollRate, isAble = self.enemy:getRollRate()
	assert(rollRate > 1, "invalid rollRate")

	if isAble then 
		randomSeed =  math.random(1, rollRate)
		if randomSeed > rollRate - 1 then 
			self:playRoll()
			self.enemy:beginRollCd()
		end
	end
end

--throw 
function CommonEnemyView:canHitted()
	local currentName = self.armature:getAnimation():getCurrentMovementID()
	
	--无敌
	if currentName == "rollleft" 
		or currentName == "rollright" then 
		return false
	end

	return true
end

function CommonEnemyView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		-- print("animationEvent id ", movementID)
		armatureBack:stopAllActions()
		if movementID ~= "die" then
			local playCache = self:getPlayCache()
			if playCache then 
				playCache()
			else 					
				self:playStand()
			end
    	elseif movementID == "die" then 
    		self:setDeadDone()
    	end 
	end
end


return CommonEnemyView