
--[[--

“enemy”的视图
1. 根据enemyModel的状态机来更新view的动画
2. enemy的移动范围判断
]]

--import
import("...includes.functionUtils")
local AbstractEnemyView = import(".AbstractEnemyView")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local EnemyView = class("EnemyView", AbstractEnemyView)

function EnemyView:ctor(property)
	EnemyView.super.ctor(self, property) 

    --blood
    self:initBlood() 

	--play
	self:playStartState(property.startState)

    cc.EventProxy.new(self.enemy, self)
    	:addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill))  
        -- :addEventListener(Actor.FIRE_EVENT, handler(self, self.playFire))  
    --test
    self:test()
end

--ui
function EnemyView:initBlood()
    --add blood
    cc.FileUtils:getInstance():addSearchPath("res/Fight/fightLayer/ui")
    local node = cc.uiloader:load("UI.json")    
    self.blood = cc.uiloader:seekNodeByName(node, "enemyBlood")
    self.blood:removeFromParent()
    local bound = self.armature:getBoundingBox()
    self.blood:setPosition(0, bound.height/2 + 100)
    self.armature:addChild(self.blood) 
	self.bloodValueNode = cc.uiloader:seekNodeByName(self.blood , "blood")
	self:setBlood(1.0)
end

function EnemyView:setBlood(scale)
    local bloodBg = cc.uiloader:seekNodeByName(self.blood, "bloodBg")
    local oSize = bloodBg:getContentSize()
    self.bloodValueNode:setLayoutSize(oSize.width * scale, oSize.height)	
end

---- state ----
function EnemyView:playStartState(state)
	if state == "rollleft" then 
		self:playRollLeft()
	elseif state == "rollright" then
		self:playRollRight()
	else 
		self:playStand()
	end
end

function EnemyView:playStand()
	if not self:canChangeState("stand") then return end
	self.armature:getAnimation():play("stand" , -1, 1)  
end

function EnemyView:playFire()
	if not self:canChangeState("fire") then return end
	self.armature:getAnimation():play("fire" , -1, 1) 

	--fire 
	print("self.hero:getHp()", self.hero:getHp())
	print("self.enemy:getDemage()", self.enemy:getDemage())
	self.enemy:hit(self.hero)
end

function EnemyView:playWalk()
	if not self:canChangeState("walk") then return end
	local isLeft = 1
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then isLeft = -1 end
	local dis = 2 * isLeft
    local widthOffset = 100 * isLeft
    local isAble = self:checkPlace(widthOffset)

    if not isAble then return end
	self.armature:getAnimation():play("walk" , -1, 1)
	local action = cc.MoveBy:create(1/60, cc.p(dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))	
end

function EnemyView:playRoll()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:playRollLeft()
	else
		self:playRollRight()
	end
end

function EnemyView:playRollLeft()
	if not self:canChangeState("rollleft") then return end
	if not self:checkPlace(-150) then return end
	self.armature:getAnimation():play("rollleft" , -1, 1) 
	local dis = 5 

	local action = cc.MoveBy:create(1/60, cc.p(-dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))	
end

function EnemyView:playRollRight()
	if not self:canChangeState("rollright") then return end
	if not self:checkPlace(150) then return end
	self.armature:getAnimation():play("rollright" , -1, 1) 
	local dis = 5

	local action = cc.MoveBy:create(1/60, cc.p(dis, 0))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))			
end

function EnemyView:playHitted(event)
	if not self:canChangeState("hit") then return end
	if not self.enemy:isDead()  then
		self.armature:getAnimation():play("hit" ,-1 , 1)
	end
end

function EnemyView:playKill(event)
	if not self:canChangeState("die") then return end
	self.armature:getAnimation():play("die" ,-1 , 1)
end



function EnemyView:test()
	--body
	local weakNode = self.armature:getBone("weak1"):getDisplayRenderNode()
	local bodyNode = self.armature:getBone("body1"):getDisplayRenderNode()
	drawBoundingBox(self.armature, weakNode, "red") 
	drawBoundingBox(self.armature, bodyNode, "yellow") 
    -- drawBoundingBox(self, self, "white") 
end

--接口

function EnemyView:tick(t)
	--change state
	--fire
	local fireRate = self.enemy:getFireRate()
	local randomSeed 
	randomSeed = math.random(1, fireRate)
	if randomSeed > fireRate - 1 then 
		self:playFire() 
		return
	end

	--walk
	local walkRate = self.enemy:getWalkRate()
	randomSeed =  math.random(1, walkRate)
	if randomSeed > walkRate - 1 then 
		self:playWalk()
		return 
	end

	--roll
	local rollRate = self.enemy:getRollRate()
	randomSeed =  math.random(1, rollRate)
	if randomSeed > rollRate - 1 then 
		self:playRoll() 
		return
	end

	--检测死亡
	if self.enemy:getHp() == 0 then
		self:playKill()
	end
end

function EnemyView:onHitted(demage)
	if self.enemy:canHitted() then
		self.enemy:decreaseHp(demage)
	end

	local maxHp = self.enemy:getMaxHp()
	local hp = self.enemy:getHp()
	self:setBlood(hp/maxHp)
end

function EnemyView:animationEvent(armatureBack,movementType,movementID)
	-- print("animationEvent id ", movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		armatureBack:stopAllActions()
		self.armature:stopAllActions()
		if movementID ~= "die" then
			self:playStand()
    	elseif movementID == "die" then 
    		self:setDeadDone()
    	end 
	end
end

function EnemyView:getEnemyArmature()
	if self.armature then return self.armature end 
	--armature
    local src = "Fight/enemys/anim_enemy_001/anim_enemy_001.ExportJson"
    local armature = getArmature("anim_enemy_001", src) 
	armature:getAnimation():setMovementEventCallFunc(handler(self,self.animationEvent))
	return armature
end

function EnemyView:getModel(id)
	return Enemy.new({id = id})
end

function EnemyView:getStateMatches()
	local stateMatches = {
		stand = {"rollleft", "rollright", "hit", "walk", "fire"},
		walk = {"stand"},
		rollleft = {"stand"},
		rollright = {"stand"},	
		fire = {"stand","hit",},
		hit = {"walk", "stand", "fire",
			checkFunc = function(self) 
				return self.enemy:canHitted()  
			end,},
		die = {"stand", "rollleft", "rollright", "hit", "walk", "fire"},
	}	
	return stateMatches
end

return EnemyView