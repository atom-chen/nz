
--[[--

“伞兵”的视图
1. desc: a.指定出生地和x坐标 x控制释放位置 b.开始释放 c.降落到出生地的y 则伞消失
2. 伞兵落地 换为enemyview
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local SanEnemyView = class("SanEnemyView", Attackable)  


function SanEnemyView:ctor(property)
	--instance
	SanEnemyView.super.ctor(self, property) 
    self.isFalling = true
	-- dump(property, "property")
    
    --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    --
    self:playFall() 
end

function SanEnemyView:tick()
    if self.isFalling then 
        local enemy = self.armature:getBone("enemy"):getDisplayRenderNode()
        local pWorld = enemy:convertToWorldSpace(cc.p(0,0))

        local placeNode = self:getParent()
        local pWorld2 = placeNode:convertToWorldSpace(cc.p(0,0))
        if pWorld.y <= pWorld2.y then 
            self.isFalling = false
            self:stopFall()
        end
    end
end

function SanEnemyView:playFall()
	--start
	self.armature:setPositionY(display.height)
	
    --action
	local speed = -2 * 60
	local action = cc.MoveBy:create(1, cc.p(0, speed))
    local seq = cc.Sequence:create(action)	
    self.armature:runAction(cc.RepeatForever:create(seq))

    --play
    self.armature:getAnimation():play("jiangluo" , -1, 1) 
end

function SanEnemyView:stopFall()
	--stop action
	self.armature:stopAllActions()
    self:setWillRemoved()  

    -- 召唤
    -- dump(self.property, "self.property")
    local data = {
        pos = cc.p(self:getPositionX(), self:getPlaceBound().y),
        delay = 0,
        property = {
                id = self.property.enemyId,
                placeName = self.property.placeName,
                },
        }
    self.hero:dispatchEvent({name = "ENEMY_ADD_EVENT", enemys = {data}})    
end

--Attackable interface
function SanEnemyView:playHitted(event)
    -- print("SanEnemyView:playHitted")
end

function SanEnemyView:playKill(event)
    -- print("SanEnemyView:playKill")
    self:setDeadDone()

    --屏幕动画
end

function SanEnemyView:onHitted(targetData)
    local demage     = targetData.demage 
    local scale      = targetData.demageScale or 1.0
    local demageType = targetData.demageType or "body"
    if not self.enemy:canHitted()  then return end
    self.enemy:decreaseHp(demage * scale)

    --爆头
    if self.enemy:getHp() == 0 then 
        if demageType == "head" then 
            local soundSrc  = "res/Music/fight/btts.wav"
            self.audioId =  audio.playSound(soundSrc,false)             
            self.hero:dispatchEvent({
                name = self.hero.ENEMY_KILL_HEAD_EVENT})
        end
    end          
end


function SanEnemyView:animationEvent(armatureBack,movementType,movementID)

end


function SanEnemyView:getModel(property)
    return Enemy.new(property)
end

return SanEnemyView