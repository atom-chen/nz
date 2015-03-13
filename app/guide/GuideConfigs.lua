--[[
	备注：1. id不能重复

]]

local GuideConfigs = class("GuideConfigs", cc.mvc.ModelBase)

local configs = {}

--[[
	skipMode: { 
				condition, : 条件判断 外界指定doGuideNext
		   		clickScreen,:点击屏幕跳过
		   		auto		:时间到了自动跳过
		   		默认： 点击指定区域跳过 
	}

	skipDelay: {
				skipDelay = 1.0 代表引导层消失1.0秒, 且可以移动
	} 
	touchType： {
				all = 接受所有事件
				
	}
	skipMode;  {
				condition = 满足条件才能跳过
				clickScreen = 点击屏幕任意一点跳过
	}
]]

----第0关 移动----
configs["fight01_move"] = {
	preGuideId = nil,
	steps = {
		{id = "fight_move", msg = "", hand = "move",rolepos = "hide"},
	}
}

--第0关 开火
configs["fight01_fire"] = {
	preGuideId = nil,
	str = "第0关",
	steps = {
		{id = "fight_fire", msg = "", hand = "fire", rolepos = "hide"},
	}
}

---- 第0关 扔雷----
configs["fight01_lei"] = {
	preGuideId = nil,
	steps = {
		{id = "fight_lei", msg = "在高亮区域点击，将会投掷手雷"},
	}
}

---- 第0关 换枪(rpg)----
configs["fight01_change"] = {
	preGuideId = nil,
	steps = {
		{id = "fight_change", msg = "在高亮区域点击，将会更换枪械"},
	}
}

---- 第0关 黄金枪----
configs["fight01_gold"] = {
	preGuideId = nil,
	steps = {
		{id = "fight_gold", msg = "敌人越来越多，快变身为黄金武器模式 ! "},
	}
}

--- 第0关毁灭者之后 ----
configs["fight01_jijia"] = {
	preGuideId = nil,
	steps = {
		--毁灭者掉剩下10% 血 机甲开
		{id = "fight01_jijia", msg = "开启机甲模式和毁灭者决一死战！！", }, 
	}
}

---- 第0关结算之后 ----
configs["afterfight01"] = {
	preGuideId = nil,
	steps = {
		{id = "afterfight01_award", msg = "中大奖了 ! 掉落了一把神狙雷明顿!  "}, 
		-- {id = "afterfight01_inlay", msg = "点击按钮，镶嵌道具" },		
		{id = "afterfight01_get", msg = "点击按钮，领取雷明顿和镶嵌道具"},	
		{id = "afterfight01_jixu", msg = "点击按钮，进入下一关"}, 
	}
}

--- 开启第2关之后 ----
configs["prefight02"] = {
	preGuideId = "fight01_jijia",
	steps = {
		{id = "prefight02_wuqiku", msg = "点击按钮进入武器界面", }, 
		{id = "prefight02_shengji1",contentOffset = {x = 100, y = 0}, msg = "点击左侧MP5", rolepos = "right"}, 
		{id = "prefight02_shengji2", msg = "点击右侧升级按钮", skipDelay = 2.0},
		{id = "prefight02_shengji3", msg = "恭喜杰哥 ， 升级成功！ ", skipMode = "clickScreen"},
		{id = "prefight02_back", msg = "点击按钮返回大地图",rolepos = "right", },		
		{id = "prefight02_nextlevel", msg = "点击关卡按钮进入下一关", rolepos = "left", },			
		{id = "prefight02_enter", contentOffset = {x = -100, y = 0}, msg = "点击开始游戏按钮，开始战斗！", },
	}
}

configs["afterfight02"] = {
	preGuideId = "prefight02",
	steps = {
		{id = "afterfight02_inlay", msg = "点击按钮，镶嵌道具" },
		{id = "afterfight02_next", msg = "点击按钮，回到主界面" },		
	}
}

---- 开启第3关之后  ----
configs["xiangqian"] = {
	preGuideId = "afterfight02",
	steps = {
		--进镶嵌页面  一套青铜 
		{id = "xiangqian_xiangqian", msg = "点击按钮进入镶嵌界面", }, 
		{id = "xiangqian_xiangqian1", msg = "点击左侧按钮选择镶嵌属性", }, 
		{id = "xiangqian_xiangqian2", msg = "点击购买",},
		{id = "xiangqian_xiangqian3", msg = "点击装备", },
		{id = "xiangqian_xiangqian4", msg = "也可点击快速镶嵌，镶嵌背包内最好的道具", },
		{id = "xiangqian_xiangqian5", msg = "镶嵌是消耗性道具，要节省使用哦", skipMode = "clickScreen" },
		{id = "xiangqian_back", msg = "点击按钮返回大地图", },		
		{id = "xiangqian_nextLevel", msg = "点击按钮进入下一关",  contentOffset = {x = 0, y = -165},},		
	}
}

---- 第四关战斗开始之后 ----
configs["fight04"] = {
	preGuideId = nil,
	steps = {
		{id = "fight04_open", msg = "         点击开镜", }, 
		{id = "fight04_fire", msg = "         点击开火", }, 
		{id = "fight04_close", msg = "         点击关镜", }, 
		{id = "fight04_finish", msg = "消灭剩下来的敌人", skipMode = "clickScreen", opacity = 0.0},
	}	
}


function GuideConfigs.getConfig(groupId)
	assert(configs[groupId], "configs is nil groupId: "..groupId )
	return configs[groupId]
end

return GuideConfigs