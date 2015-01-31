local FightResultPopup = class("FightResultPopup", function()
	return display.newLayer()
end)

function FightResultPopup:ctor()
	self:loadCCS()
	self:playAnim()
    self:playSound()
end

function FightResultPopup:playSound()
    local rwwc   = "res/Music/ui/rwwc.wav"
    audio.playSound(rwwc,false)
end

function FightResultPopup:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/FightResult/fightResultAnim")
	local controlNode = cc.uiloader:load("fightResultSuccess.ExportJson")
    self:addChild(controlNode)

    local animLayer = cc.uiloader:seekNodeByName(self, "animlayer")

    local src = "res/FightResult/anim/renwuwc/renwuwc.csb"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    self.armature = ccs.Armature:create("renwuwc")
    self.armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
    addChildCenter(self.armature, animLayer)
end

function FightResultPopup:playAnim()
    self.armature:getAnimation():play("renwuwc" , -1, 1)
end

function FightResultPopup:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        armatureBack:stopAllActions()
        if movementID == "renwuwc" then
            armatureBack:pause()
            ui:closePopup("FightResultPopup")
            ui:changeLayer("FightResultLayer")
        end
    end
end

return FightResultPopup