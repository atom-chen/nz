local BuyConfigs = class("BuyConfigs", cc.mvc.ModelBase)

local dir = "res/GiftBag/GiftBag/GiftBag_"
local configs = {
	armedMecha     = {				--机甲
			ccsPath = dir.."ArmedMecha.json",
			isGift = true,
	},
	changshuang    = {				--畅爽
			ccsPath = dir.."ChangShuang.json",
			isGift = true,
	},
	goldGiftBag    = {				--土豪金
			ccsPath = dir.."goldGiftBag.json",
			isGift = true,
	},
	novicesBag     = {              --新手礼包
			ccsPath = dir.."NovicesBag.json",
			isGift = true,
	}, 
	weaponGiftBag  = {           --武器大礼包
			ccsPath = dir.."WeaponGiftBag.json",
			isGift = true,
	},
	timeGiftBag= {           --武器大礼包
			ccsPath = dir.."timeGiftBag.json",
			isGift = true,
	},
	handGrenade    = {             --手雷
			-- ccsPath = dir.."HandGrenade.json",
			isGift = false,
	},
	unlockWeapon   = {            --解锁武器
			-- ccsPath = dir.."UnlockWeapon.json",
			isGift = false,
	},
	goldWeapon     = {				--金武
			-- ccsPath = dir.."GoldWeapon.json",
			isGift = true,
	},
	onceFull       = {
			isGift = false,
	},
	resurrection   = {
			isGift = false,
	},
	stone1         = {
			isGift = false,
	},
	stone2         = {
			isGift = false,
	},
	stone3         = {
			isGift = false,
	},
	stone4         = {
			isGift = false,
	},
	stone5         = {
			isGift = false,
	}


		-- --礼包
		-- config["novicesBag"]       = "30000883682301"
		-- config["weaponGiftBag"]    = "30000883682302"
		-- config["goldGiftBag"]      = "30000883682303"
		-- config["xianshitejia"]     = "30000883682304"
		-- config["changshuang"]      = "30000883682305"
		-- config["goldWeapon"]       = "30000883682306"
		-- config["handGrenade"]      = "30000883682307"
		-- config["armedMecha"]       = "30000883682308"

		-- --单件
		-- config["onceFull"]         = "30000883682309"
		-- config["resurrection"]     = "30000883682310"
		-- config["stone1"]           = "30000883682311"
		-- config["stone2"]           = "30000883682312"
		-- config["stone3"]           = "30000883682313"
		-- config["stone4"]           = "30000883682314"
		-- config["stone5"]           = "30000883682315"	
}


function BuyConfigs.getConfig(name)
	assert(configs[name], "invalid name :"..name)
	return configs[name]
end

return BuyConfigs