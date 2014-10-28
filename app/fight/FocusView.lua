
--[[--

“准星”的视图

]]

--import
import("..includes.functionUtils")
local Hero = import(".Hero")
local Gun = import(".Gun")

local FocusView = class("FocusView", function()
    return display.newNode()
end)

function FocusView:ctor(properties)
	
	--instance
	self.hero = app:getInstance(Hero)
	self.gun = app:getInstance(Gun)

	--focus
	local gunId = 1   -- todo 外界传 Gun
	local focusId = gunId+11
    local src = "Fight/gunsAnim/anim_zunxin_sq/anim_zunxin_sq.ExportJson"
    local armature = getArmature("anim_zunxin_sq", src) 
	self.focus = armature
	self.focus:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
	self:addChild(armature)    
	self:playIdle()
	self:setFocusRange(cc.size(100, 100))
	self.playIndex = "stand"

    --test
    self:test()
end

function FocusView:playIdle()
	self.playIndex = "stand"
	self.focus:getAnimation():play("stand" , -1, 1) 
end

function FocusView:playFire()
	if self.playIndex == "stand" then 
		self.focus:getAnimation():play("fire01" , -1, 0) 
		self.playIndex = "fire01"
	elseif self.playIndex == "fire01" or self.playIndex == "fire02" then 
		print("fire02")
		self.focus:getAnimation():play("fire02" , -1, 0) 
		self.playIndex = "fire02"
	end
end

function FocusView:animationEvent(movementType,movementID,armatureBack)
	if movementType == ccs.MovementEventType.loopComplete then
		if id == "fire01" then

    	elseif id == "fire02" then

    	end
	end
end

function FocusView:stopFire()
	self.playIndex = "stand"
end

function FocusView:setFocusRange(size)
    self.focusRange = display.newScale9Sprite()
    self.focusRange:setContentSize(size)
    addChildCenter(self.focusRange, self)
end

function FocusView:getFocusRect()
	local bound = self.focusRange:getBoundingBox()
	local nodePoint = self.focusRange:convertToWorldSpace(
	cc.p(bound.x, bound.y))
	bound.x = nodePoint.x
	bound.y = nodePoint.y	
	return bound
end

function FocusView:test()
    drawBoundingBox(self, self.focusRange, cc.c4f(1.0, 0.0, 0, 1.0))
end

return FocusView