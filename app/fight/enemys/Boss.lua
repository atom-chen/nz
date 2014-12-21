-- local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

-- --[[--
--[[--
“敵人”的实体

]]

local Actor = import("..Actor")
local Boss = class("Boss", Actor)
local FightConfigs = import("..fightConfigs.FightConfigs")

function Boss:ctor(properties)
    --super
    dump(properties, "properties")
    local id = properties.id
    local waveConfig = FightConfigs:getWaveConfig()
    self.config = waveConfig:getBoss(id)
    dump(self.config, " Boss config")
    local property = {
        id = "boss",
        maxHp = self.config["hp"],
        demage = self.config["demage"],
    }
    Boss.super.ctor(self, property)

    --
end

function Boss:getConfig()
    return self.config
end

function Boss:getFireRate()
	return self.config["fireRate"] 
end

function Boss:getMoveRate()
	return self.config["walkRate"]
end

function Boss:getDemageScale(rangeStr)

    assert(self.config.demageScale[rangeStr], "wave config is invalid:"..rangeStr)
    return self.config.demageScale[rangeStr]
end

function Boss:getSkillTrigger()
    return self.config.skilltrigger
end

function Boss:getFireOffset()
    return self.config.fireOffset 
end

return Boss