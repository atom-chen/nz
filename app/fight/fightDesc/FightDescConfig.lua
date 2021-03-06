local EnemyDescConfig = class("EnemyDescConfig", cc.mvc.ModelBase)

local configs = {}

configs["boss02"] = {                  --蓝色(扔汽车)
	title = "BOSS信息！",
	name = "毁灭者",
	spc = "技能：",
	skill = {"粉碎投掷","野蛮冲撞","火箭弹"},
	weakness = "头部，手部",
	describe = "眼镜蛇研发的二代机甲战士，残酷冷血，据说有三兄弟。",
	playanim = "stand",
}

configs["boss02_1"] = {                  --cf红色肌肉男(扔铁球)
	title = "BOSS信息！",
	name = "毁灭者三号",
	spc = "技能：",
	skill = {"铁球投掷","野蛮冲撞","召唤医疗"},
	weakness = "头部，手部",
	describe = "眼镜蛇研发的二代机甲战士，残酷冷血，据说有三兄弟。",
	playanim = "stand",
}

configs["boss02_2"] = {                --黄色(扔汽油桶)
	title = "BOSS信息！",
	name = "毁灭者二号",
	spc = "技能：",
	skill = {"粉碎投掷","野蛮冲撞","烟雾弹"},
	weakness = "头部，手部",
	describe = "眼镜蛇研发的二代机甲战士，残酷冷血，据说有三兄弟。",
	playanim = "stand",
}

configs["boss01"] = {                              --盾牌红boss原型
	title = "BOSS信息！",
	name = "黑暗金刚",
	spc = "技能：",
	skill = {"狂热射击","召唤自爆","连续飞弹"},
	weakness = "头部，手部，腹部",
	describe = "新型试验机甲的杰作，厚装甲护盾使其拥有超高的防御。",
	playanim = "stand",
}

configs["boss01_1"] = {                            --红色机甲开枪为主
	title = "BOSS信息！",
	name = "烈火金刚",
	spc = "技能：",
	skill = {"狂热射击","召唤狙击","连续飞弹"},
	weakness = "头部，手部，腹部",
	describe = "新型试验机甲的杰作，厚装甲护盾使其拥有超高的防御。",
	playanim = "stand",
}

configs["boss01_2"] = {                            --银灰冷色终结者            
	title = "BOSS信息！",
	name = "地狱终结者",
	spc = "技能：",
	skill = {"激光扫射","召唤人质","连续飞弹"},
	weakness = "头部，手部，腹部",
	describe = "新型试验机甲的杰作，厚装甲护盾使其拥有超高的防御。",
	playanim = "stand",
}

configs["zpbing"] = {
	title = "出现新兵种！",
	name = "导弹兵",
	spc = "特性：",
	skill = {"攻击慢","伤害高"},
	weakness = "头部",
	describe = "眼镜蛇高级佣兵，伤害恐怖。",
	playanim = "stand",
}

configs["jujib"] = {
	title = "出现新兵种！",
	name = "狙击兵",
	spc = "特性：",
	skill = {"攻击慢","伤害高"},
	weakness = "头部",
	describe = "伤害恐怖的远程兵种",
	playanim = "stand",
}

configs["dunbing"] = {
	title = "出现新兵种！",
	name = "盾牌兵",
	spc = "特性：",
	skill = {"血量高","防御高","行动慢"},
	weakness = "头部",
	describe = "合金盾牌使其拥有超高的血量和防御。",
	playanim = "stand",
}

configs["zibaob"] = {
	title = "出现新兵种！",
	name = "自爆兵",
	spc = "特性：",
	skill = {"移动快","近身自爆","血量低"},
	weakness = "瓦斯罐",
	describe = "疯狂的自杀式攻击。",
	playanim = "stand",
}

configs["hs"] = {
	title = "解救人质！",
	name = "人质",
	spc = "特性：",
	skill = {"不要误伤人质！"},
	weakness = "胸",
	describe = "不要打我的脸！人家很爱漂亮的！",
	playanim = "speak1",
}

configs["yiliaob"] = {
	title = "出现新兵种！",
	name = "医疗兵",
	spc = "特性：",
	skill = {"恢复生命"},
	weakness = "头部",
	describe = "不要打我的脸！人家很爱漂亮的！",
	playanim = "stand",
}

configs["qiufan"] = {
	title = "击毙逃犯",
	name = "逃犯",
	spc = "特性：",
	skill = {"逃犯逃走会任务失败"},
	weakness = "头部",
	describe = "越狱的逃犯",
	playanim = "runright",
}
configs["feiji"] = {
	title = "出现新兵种！",
	name = "飞机",
	spc = "特性：",
	skill = {"空投伞兵","发射导弹"},
	weakness = "螺旋桨",
	describe = "高机动,高伤害。",
	playanim = "fireright",
}
configs["yyc"] = {
	title = "出现新兵种！",
	name = "越野车",
	spc = "特性：",
	skill = {"烟雾弹"},
	weakness = "导弹发射器",
	describe = "攻击高,血量高。",
	playanim = "fireright",
}
configs["dzboss"] = {
	title = "BOSS信息！",
	name = "巨炮泰坦",
	spc = "技能：",
	skill = {"核弹攻击","无敌","狂野召唤",},
	weakness = "头部、手部、腹部",
	describe = "行动缓慢，暴力伤害的象征。",
	playanim = "stand",
}
configs["dzboss_1"] = {
	title = "BOSS信息！",
	name = "剧毒之牙",
	spc = "技能：",
	skill = {"烟雾弹","召唤蛛海","恐怖蛛网"},
	weakness = "头部、手部、腹部",
	describe = "蜘蛛的毒液是致命的。",
	playanim = "stand",
}
configs["renzb"] = {
	title = "BOSS信息！",
	name = "鬼眼",
	spc = "技能：",
	skill = {"影分身","旋风斩","风魔手里剑"},
	weakness = "头部、腿部",
	describe = "行动敏捷的伊贺忍者后裔，眼镜蛇三号人物。擅长伪装、暗杀。",
	playanim = "stand",
}
configs["renzb_01"] = {
	title = "BOSS信息！",
	name = "魔化鬼眼",
	spc = "技能：",
	skill = {"影分身","狂野召唤","风魔手里剑"},
	weakness = "头部、腿部",
	describe = "魔化后的鬼眼，拥有恐怖的战斗力。",
	playanim = "stand",
}
configs["nvrenzb"] = {
	title = "BOSS信息！",
	name = "魔女贝娜",
	spc = "技能：",
	skill = {"召唤","旋风斩","漫花飞舞"},
	weakness = "头部、腿部",
	describe = "鬼眼的义女,美颜值爆表的伊贺女忍。",
	playanim = "stand",
}

configs["xiaorz"] = {
	title = "出现新兵种！",
	name = "伊贺忍者",
	spc = "技能：",
	skill = {"旋风斩","手里剑"},
	weakness = "头部、腿部",
	describe = "伊贺忍者，行动敏捷，擅长暗杀。",
	playanim = "stand",
}

configs["jinzhanb"] = {
	title = "出现新兵种！",
	name = "近战兵",
	spc = "特性：",
	skill = {"血量高","近身攻击"},
	weakness = "头部",
	describe = "疯狂的野蛮战士,近战嗜血",
	playanim = "stand",
}

function EnemyDescConfig.getConfig(enemyID)
	local enemyDescTable = configs[enemyID]
	return enemyDescTable
end

return EnemyDescConfig