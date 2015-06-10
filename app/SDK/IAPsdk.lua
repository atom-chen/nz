
local IAPsdk = class("IAPsdk", cc.mvc.ModelBase)

local className = "com/hgtt/com/IAPControl"

local sig = "(Ljava/lang/String;Ljava/lang/String;II)V"

function IAPsdk:ctor()
	self.iapName = getIapName()
	self:initConfigs()
	self.buyModel = md:getInstance("BuyModel")
end

function IAPsdk:initConfigs()
	self.config = {}
	local config = self.config
	-- assert(iapName, "iapName:")
	if self.iapName == "mm" then --mm
		--礼包
		config["novicesBag"]       = "30000899255201"		--新手礼包
		config["weaponGiftBag"]    = "30000899255207"		--武器礼包
		config["goldGiftBag"]      = "30000899255208"		--土豪金礼包

		--单件
		config["goldWeapon"]       = "30000899255202"		--黄武
		config["handGrenade"]      = "30000899255203"		--手雷
		config["armedMecha"]       = "30000899255209"		--机甲
		config["onceFull"]         = "30000899255210"		--一键满级
		config["stone120"]         = "30000899255204"		--一麻袋宝石
		config["stone260"]         = "30000899255205"		--一箱子宝石
		config["stone450"]         = "30000899255206"		--堆成山的宝石
	
	elseif self.iapName == 'jd' then --基地
		config["novicesBag"]       = "001"		--新手礼包1
		config["weaponGiftBag"]    = "007"		--武器到礼包1
		config["goldGiftBag"]      = "008"		--土豪金礼包1

		--单件
		config["goldWeapon"]       = "002"		--黄武
		config["handGrenade"]      = "003"		--手雷
		config["armedMecha"]       = "009"		--机甲1
		config["onceFull"]         = "010"		--一键满级1
		config["stone120"]         = "004"		--一麻袋宝石
		config["stone260"]         = "005"		--一箱子宝石
		config["stone450"]         = "006"		--堆成山的宝石

	elseif self.iapName == "lt" then --联通
		--礼包
		config["novicesBag"]       = "001"		--新手礼包1
		config["weaponGiftBag"]    = "018"		--武器到礼包1
		config["goldGiftBag"]      = "019"		--土豪金礼包1

		--单件
		config["goldWeapon"]       = "006"		--黄武
		config["handGrenade"]      = "007"		--手雷
		config["armedMecha"]       = "020"		--机甲1
		config["onceFull"]         = "021"		--一键满级1
		config["stone120"]         = "013"		--一麻袋宝石
		config["stone260"]         = "014"		--一箱子宝石
		config["stone450"]         = "015"		--堆成山的宝石

	elseif self.iapName == "dx" then -- 电信
		--礼包
		--游游共赢的
		config["novicesBag"]       = "5156701"		--新手礼包
		config["weaponGiftBag"]    = "5156712"		--武器到礼包
		config["goldGiftBag_dx"]   = "5156713"		--土豪金礼包

		--单件
		config["goldWeapon"]       = "5128230"		--黄武
		config["handGrenade"]      = "5128231"		--手雷
		config["armedMecha"]       = "5156714"		--机甲
		config["onceFull"]         = "5156715"		--一键满级
		config["stone120"]         = "5128237"		--一麻袋宝石
		config["stone260"]         = "5128238"		--一箱子宝石
		config["stone450"]         = "5128239"		--堆成山的宝石
	end
end

function IAPsdk:pay(name)
	if self.iapName == "noSim" then
		self:callbackFaild()
		ui:showPopup("commonPopup",
			 {type = "style2", content = "请在插有SIM卡的手机上支付！", delay = 1},
			 {opacity = 0})
		return
	elseif self.iapName == 'invalid' then
		self:callbackFaild()
		ui:showPopup("commonPopup",
			 {type = "style2", content = "请在插有移动卡的手机上支付！", delay = 1},
			 {opacity = 0})	
		 return	
	end
	print("self.iapName", self.iapName)
	assert(self.config[name], "self.config[name] is nil".. name)
	local args = {self.config[name], name, handler(self, self.callbackSuccess), handler(self, self.callbackFaild)}
	if device.platform ~= 'android' then
		self:callbackSuccess()
		print("请在手机上支付 傻逼！")
	else
		luaj.callStaticMethod(className, "pay", args, sig)
	end
end

function IAPsdk:callbackSuccess( result )
	-- body
	self.buyModel:payDone(result)
end

function IAPsdk:callbackFaild(result)

	self.buyModel:deneyPay()

end



return IAPsdk

