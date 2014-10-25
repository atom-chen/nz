

local FightPlayer = import("..fight.FightPlayer")
local LevelMapLayer = import("..levelMap.LevelMapLayer")
local LevelDetailLayer = import("..levelDetail.LevelDetailLayer")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    -- local levelMapLayer = LevelMapLayer.new()
    -- self:addChild(levelMapLayer)
    -- local FightPlayer = FightPlayer.new()
    -- self:addChild(FightPlayer)
    local DetailLayer=LevelDetailLayer.new()
    self:addChild(DetailLayer)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
