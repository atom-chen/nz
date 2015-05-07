-- local LayerColor_WHITE = cc.c4b(0, 0, 0, 180)
local commonPopup = class("commonPopup",function()
	return display.newLayer()
	-- return display.newColorLayer(LayerColor_WHITE)
end)

--[[
	style1:一个确定按钮，一个关闭按钮，content
		ui:showPopup("commonPopup",
			 {type = "style1",content = "必须装备狙击枪"},
			 {opacity = 0})
	style2:只有一个板，没有按钮，三秒消失
		ui:showPopup("commonPopup",
			 {type = "style2", content = "本关还没开启", delay = 0.5},
			 {opacity = 0})
	style3:俩按钮，确定取消，content
		ui:showPopup("commonPopup",
			 {type = "style3", content = "必须装备狙击枪"},
			 {opacity = 0})
	style4:仨按钮, 确定取消打电话
		ui:showPopup("commonPopup",
			 {type = "style4"},
			 {opacity = 0})
	style5:仨按钮：快速镶嵌，黄金武器，关闭
		ui:showPopup("commonPopup",
			 {type = "style5",
			 callfuncQuickInlay = handler(self,self.****),
			 callfuncGoldWeapon = handler(self,self.****)},
			 {opacity = 0})
	style6:关闭按钮，确定按钮，输入框，激活码
		ui:showPopup("commonPopup",
			 {type = "style6"},
			 {opacity = 0})
]]
function commonPopup:ctor(properties)
	self.commonPopModel = md:getInstance("commonPopModel")

	self.properties = properties
	local typeName = properties.type
	self:loadCCS(typeName)
	self:initUI(properties)
end

function commonPopup:loadCCS(typeName)
    cc.FileUtils:getInstance():addSearchPath("res/CommonPopup/erjijiemian")
    local controlNode = cc.uiloader:load(typeName..".ExportJson")
    self:addChild(controlNode)
end

function commonPopup:initUI(properties)
	local typeName = properties.type
	if typeName == "style1" then
		local content = cc.uiloader:seekNodeByName(self, "content")
		content:setString(properties.content)
	    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
	    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
    	btntrue:setTouchEnabled(true)
    	btnfalse:setTouchEnabled(true)
    	addBtnEventListener(btntrue, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self:onClickCofirm()

	        end
	    end)
    	addBtnEventListener(btnfalse, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self:onClickClose()
	        end
	    end)

	elseif typeName == "style2" then
		local delay = properties.delay
		if delay == nil then
			delay = 2
		end
	    local labelTip = cc.uiloader:seekNodeByName(self, "Label_tip")
	    local panl_style2 = cc.uiloader:seekNodeByName(self, "panl_style2")
	    labelTip:setString(properties.content)
	    panl_style2:setTouchEnabled(true)
	    panl_style2:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
	        if event.name=='began' then
	        	self:onClickCofirm()
	            ui:closePopup("commonPopup")
	            return true
	        end
	    end)

	    -- auto remove popup windows after 2 secs.
	    self:runAction(transition.sequence({cc.DelayTime:create(delay), cc.CallFunc:create(function()
            self:onClickCofirm()
            ui:closePopup("commonPopup")
        end)}))

	elseif typeName == "style3" then
		local content = cc.uiloader:seekNodeByName(self, "content")
		content:setString(properties.content)
	    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
	    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
    	btntrue:setTouchEnabled(true)
    	btnfalse:setTouchEnabled(true)
    	addBtnEventListener(btntrue, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self:onClickCofirm()
	        end
	    end)
    	addBtnEventListener(btnfalse, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		

		     self:onClickClose()
	        end
	    end)

	elseif typeName == "style4" then
		local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
		local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
		local btncall = cc.uiloader:seekNodeByName(self, "btncall")
		btntrue:setTouchEnabled(true)
		btnfalse:setTouchEnabled(true)
		btncall:setTouchEnabled(true)

		addBtnEventListener(btntrue, function( event )
			if event.name == "began" then
				return true
			elseif event.name == "ended" then
				print("btntrue is pressed!") 
				ui:closePopup("commonPopup")
			end
		end)

		addBtnEventListener(btnfalse, function( event )
			if event.name == "began" then
				return true
			elseif event.name == "ended" then
				print("btnfalse is pressed!")
				ui:closePopup("commonPopup")
			end
		end)

		btncall:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
			if event.name == "began" then
				print("btncall is pressed!")
				return true
			elseif event.name == "ended" then
				
				if device.platform == "android" then

					local className = "com/hgtt/com/IAPControl"
					luaj.callStaticMethod(className, "callPhone")
					print("btncall is pressed!")
				end
			end
		end)
	elseif typeName == "style5" then
		local btnQuickInlay = cc.uiloader:seekNodeByName(self, "btnquickinlay")
		local btnGoldWeapon = cc.uiloader:seekNodeByName(self, "btngoldweapon")
	    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
	    btnfalse:setTouchEnabled(true)
	    btnQuickInlay:setTouchEnabled(true)
	    btnGoldWeapon:setTouchEnabled(true)

	    addBtnEventListener(btnfalse, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then
			    self:onClickClose()
	        end
	    end)
	    addBtnEventListener(btnQuickInlay, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then
			    self:onClickQuickInlay()
	        end
	    end)
	    addBtnEventListener(btnGoldWeapon, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then
	            self:onClickGoldWeapon()
	        end
	    end)
    elseif typeName == "style6" then
    	local content = cc.uiloader:seekNodeByName(self, "content")
	    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
	    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
    	btntrue:setTouchEnabled(true)
    	btnfalse:setTouchEnabled(true)
    	content:addEventListener(function(editbox, eventType)
			print("CCSSample2Scene editbox input")
		end)
    	addBtnEventListener(btntrue, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self:onClickCofirm()

	        end
	    end)
    	addBtnEventListener(btnfalse, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self:onClickClose()
	        end
	    end)
	elseif typeName == "style7" then
		local content = cc.uiloader:seekNodeByName(self, "content")
		content:setString(properties.content)
		
	    local btntrue = cc.uiloader:seekNodeByName(self, "btntrue")
	    local btnfalse = cc.uiloader:seekNodeByName(self, "btnfalse")
    	btntrue:setTouchEnabled(true)
    	btnfalse:setTouchEnabled(true)
    	addBtnEventListener(btntrue, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		
		        self:onClickCofirm()
	        end
	    end)
    	addBtnEventListener(btnfalse, function(event)
	        if event.name=='began' then
	            return true
	        elseif event.name=='ended' then		

		     self:onClickClose()
	        end
	    end)
	end
end

function commonPopup:onClickCofirm()
	ui:closePopup("commonPopup")
	local func =  self.properties.callfuncCofirm
	if func ~= nil then
		print("callfuncCofirm")
		func()		
	end
end

function commonPopup:onClickClose()
	ui:closePopup("commonPopup")
	local func =  self.properties.callfuncClose
	if func ~= nil then
		print("callfuncClose")
		func()
	end	
end

function commonPopup:onClickQuickInlay()
	ui:closePopup("commonPopup")
	local func =  self.properties.callfuncQuickInlay
	if func ~= nil then
		print("callfuncClose")  
		func()
	end
end

function commonPopup:onClickGoldWeapon()
	ui:closePopup("commonPopup")
	local func =  self.properties.callfuncGoldWeapon
	if func ~= nil then
		print("callfuncClose")  
		func()
	end
end

return commonPopup