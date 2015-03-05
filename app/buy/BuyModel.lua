
--[[
“购买”的实体

]]
local BuyConfigs = import(".BuyConfigs")
local BuyModel = class("BuyModel", cc.mvc.ModelBase)

-- 定义事件


function BuyModel:ctor(properties)
    BuyModel.super.ctor(self, properties) 
	
	--instance
	-- self:buy("weaponGiftBag", {a=1})
end

--
function BuyModel:clearData()
    self.curId = nil
    self.curBuydata =  nil
end

function BuyModel:buy(configid, buydata)
	self:clearData()
    self.curId = configid
    self.curBuydata =  buydata
	local config  = BuyConfigs.getConfig(configid)
	local isGift = config.isGift --todo
	self.isFight = buydata.isFight

	if isGift then
		-- if self.isFight then
		-- 	print("BuyModel, configid:",configid)
  --       	ui:showPopup("GiftBagPopup",{popupName = configid},{isPauseScene = true, isFight = self.isFight, isPauseSecond = buydata.isPauseSecond})
  --       else 
        	ui:showPopup("GiftBagPopup",{popupName = configid})
        -- end
    else
    	--mm
    	iap:pay(configid)
    end
end

function BuyModel:payDone(result)
	print("function BuyModel:payDone():"..self.curId)
	local funcStr = "buy_"..self.curId
	self[funcStr](self, self.curBuydata)
	dump(self.curBuydata, "self.curBuydata")
	local payDoneFunc = self.curBuydata.payDoneFunc
	if payDoneFunc then payDoneFunc() end
end

function BuyModel:deneyPay()
	print("function BuyModel:deneyBuy()"..self.curId)
	local deneyBuyFunc = self.curBuydata.deneyBuyFunc
	if deneyBuyFunc then  deneyBuyFunc() end
end

function BuyModel:buy_weaponGiftBag(buydata)
	local weaponListModel = md:getInstance("WeaponListModel")
	local StoreModel = md:getInstance("StoreModel")
	-- local weapontable = weaponListModel:getAllWeapon()
	local propModel = md:getInstance("propModel")
	local weapontable = {3,4,5,7,8}
	for k,v in pairs(weapontable) do
		weaponListModel:buyWeapon(v)
		weaponListModel:onceFull(v)
	end
	self:setBought("weaponGiftBag")

	--手雷*10
	propModel:buyProp("lei",10)
	StoreModel:refreshInfo("prop")
	um:payProps(20,5,"buy_weapongiftbag",1,0)
end

function BuyModel:buy_novicesBag( buydata )
	print("BuyModel:buy_novicesBag(buydata)")
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	local UserModel = md:getInstance("UserModel")
	--黄武*1
	InlayModel:buyGoldsInlay(1)
    InlayModel:refreshInfo("speed")
	--机甲*1
	propModel:buyProp("jijia",1)
	--手雷*10
	propModel:buyProp("lei",10)
	--金币*188888
	UserModel:addMoney(188888)
	StoreModel:refreshInfo("prop")
	self:setBought("novicesBag")
	um:payProps(1,5,"buy_novicesbag",1,0)
end

function BuyModel:buy_goldGiftBag( buydata )
	print("BuyModel:buy_goldGiftBag(buydata)")
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	--黄武*15
	InlayModel:buyGoldsInlay(15)
    InlayModel:refreshInfo("speed")

	--机甲*15
	propModel:buyProp("jijia",15)
	--手雷*30
	propModel:buyProp("lei",30)
	StoreModel:refreshInfo("prop")
	um:payProps(30,5,"buy_goldgiftbag",1,0)
end

function BuyModel:buy_changshuang( buydata )
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	--黄武*4
	InlayModel:buyGoldsInlay(4)
    InlayModel:refreshInfo("speed")
	--机甲*3
	propModel:buyProp("jijia",3)
	--手雷*10
	propModel:buyProp("lei",10)
	StoreModel:refreshInfo("prop")
	um:payProps(6,5,"buy_changshuang",1,0)
end

function BuyModel:buy_timeGiftBag( buydata )
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	local UserModel = md:getInstance("UserModel")
	--黄武*4
	InlayModel:buyGoldsInlay(4)
    InlayModel:refreshInfo("speed")
	--机甲*3
	propModel:buyProp("jijia",3)
	--手雷*10
	propModel:buyProp("lei",10)
	--金币*188888
	--zuanshi*260
	UserModel:buyDiamond(260)
	UserModel:addMoney(188888)
	StoreModel:refreshInfo("prop")
	um:payProps(25,5,"buy_timegiftbag",1,0)
end

function BuyModel:buy_handGrenade( buydata )
	local propModel = md:getInstance("propModel")
	local StoreModel = md:getInstance("StoreModel")
	--手雷*20
	propModel:buyProp("lei",20)
	StoreModel:refreshInfo("prop")
	um:payProps(4,5,"buy_handgrenade",1,0)
end

function BuyModel:buy_armedMecha( buydata )
	local propModel = md:getInstance("propModel")
	local StoreModel = md:getInstance("StoreModel")
	--jijia*2
	propModel:buyProp("jijia",2)
	StoreModel:refreshInfo("prop")
	um:payProps(4,5,"buy_armedmecha",1,0)
end

function BuyModel:buy_unlockWeapon( buydata )
	print("BuyModel:buy_unlockWeapon( buydata )")
	local weaponListModel = md:getInstance("WeaponListModel")
	weaponListModel:buyWeapon(buydata.weaponid)
	um:payProps(6,5,"buy_unlockweapon",1,0)
end

function BuyModel:buy_goldWeapon( buydata )
	print("BuyModel:buy_goldWeapon( buydata )")
	--黄武*2
	local InlayModel = md:getInstance("InlayModel")
	local StoreModel = md:getInstance("StoreModel")
	local propModel = md:getInstance("propModel")
	InlayModel:buyGoldsInlay(2)
	InlayModel:refreshInfo("speed")
	StoreModel:refreshInfo("prop")
	um:payProps(4,5,"buy_goldweapon",1,0)
end

function BuyModel:buy_onceFull( buydata )
	local weaponListModel = md:getInstance("WeaponListModel")
	weaponListModel:onceFull(buydata.weaponid)
	um:payProps(2,5,"buy_oncefull",1,0)
end

function BuyModel:buy_resurrection( buydata )
	print("BuyModel:buy_resurrection( buydata )")
	um:payProps(2,5,"buy_resurrection",1,0)
	--yby todo
end

function BuyModel:buy_stone10( buydata )
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(10)
    um:payVirtualCurrency(1,5,10)
end
function BuyModel:buy_stone45( buydata )
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(45)
    um:payVirtualCurrency(4,5,45)
end
function BuyModel:buy_stone120( buydata )
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(120)
	um:payVirtualCurrency(10,5,120)
end
function BuyModel:buy_stone260( buydata )
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(260)
    um:payVirtualCurrency(20,5,260)
end
function BuyModel:buy_stone450( buydata )
	local UserModel = md:getInstance("UserModel")
	UserModel:buyDiamond(450)
    um:payVirtualCurrency(30,5,450)
end

function BuyModel:checkBought(giftId)
	local data = getUserData()
	local isDone = data.giftBag[giftId] 
	return isDone
end

function BuyModel:setBought(giftId)
	local data = getUserData()
	data.giftBag[giftId] = true
	setUserData(data)
end

return BuyModel