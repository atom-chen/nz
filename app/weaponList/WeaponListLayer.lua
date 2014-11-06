local WeaponListCell = import(".WeaponListCell")
local WeaponListModel = import(".WeaponListModel")

local WeaponListLayer = class("WeaponListLayer", function()
	return display.newLayer()
end)


function WeaponListLayer:ctor()
    --instance
    self.selectedContent = nil

	cc.FileUtils:getInstance():addSearchPath("res/WeaponList/")
	local ccs = cc.uiloader:load("gunzb_1.ExportJson")
    self:addChild(ccs)
	self:initUI()
    -- 点开页面默认选择某个武器
    self:selectCell(2)
end

function WeaponListLayer:initUI()
    self.weaponLV = cc.uiloader:seekNodeByName(self, "ListView_49")
    self.weaponLV:onTouch(handler(self,self.touchListener))
    self:loadWeaponList(self.weaponLV, getConfig("config/weapon.json"))
    self.labelName = cc.uiloader:seekNodeByName(self, "label_name")
    self.labelDescribe = cc.uiloader:seekNodeByName(self, "label_describe")
    self.layerGun = cc.uiloader:seekNodeByName(self, "panel_gun")
    self.progBullet=cc.uiloader:seekNodeByName(self, "progress_bullet")
    self.progAccuracy=cc.uiloader:seekNodeByName(self, "progress_accuracy")
    self.progReload=cc.uiloader:seekNodeByName(self, "progress_reload")
    self.labelDamage = cc.uiloader:seekNodeByName(self, "Label_damage")
    self.labelPercent = cc.uiloader:seekNodeByName(self, "Label_percent")
end

-- 初始化ListView
function WeaponListLayer:loadWeaponList(weaponListView, weaponTable)
	for i=1, #weaponTable do
		local weaponRecord = getConfigByID("config/weapon.json", i)
		local item = weaponListView:newItem()
		-- local item
		local content
		if weaponTable[i] then
			content = WeaponListCell.new(weaponRecord)
		end
		item:addContent(content)
		item:setItemSize(120, 140)
		
		weaponListView:addItem(item)
	end
	weaponListView:reload()
end

-- ListView 点击事件
function WeaponListLayer:touchListener(event)
    if "clicked" == event.name then
     self:selectCell(event.itemPos)
    end
end

-- 通过index选择Cell
function WeaponListLayer:selectCell( index )
    -- 选择状态
    local itemContent = self.weaponLV.items_[index]:getContent()
    if self.selectedContent == nil then
        self.selectedContent = itemContent
    else
        self.selectedContent:setSelected(false)
        self.selectedContent = itemContent
    end
    itemContent:setSelected(true)

    -- 详情内容
    self:getWeaponOfCell(index)
end

-- 从列表cell索引index获取显示武器详情
function WeaponListLayer:getWeaponOfCell( index )
	self.layerGun:removeAllChildren()
    local weaponrecord = WeaponListModel:getWeaponRecord(index)
    self.labelName:setString(weaponrecord["name"])
    self.labelDescribe:setString(weaponrecord["describe"])
	local weaponImg = cc.ui.UIImage.new("WeaponList/"..weaponrecord["imgName"]..".png")
	weaponImg:setLayoutSize(430, 180)
	addChildCenter(weaponImg, self.layerGun)
    self.progBullet:setPercent(weaponrecord["bulletNum"]/85*100)
    self.progAccuracy:setPercent(weaponrecord["accuracy"]/99*100)
    self.progReload:setPercent((1-weaponrecord["reloadTime"]/4.2)*100)
    self.labelDamage:setString(weaponrecord["demage"])
end

return WeaponListLayer