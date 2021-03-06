local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {  		
			{
				time = 2,
				num = 2,
				delay = {0,0.2},
				pos = {100,175},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0,0.5},
				pos = {200,575},
				property = { 
					placeName = "place5",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {200},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0,0.2},
				pos = {50,140},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},					
		},
	},
	{
		enemys = {
			{
				time = 2,
				num = 2,
				delay ={0,0.5},
				pos = {0,80},		
				property = { 
					placeName = "place8",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0,0.2},
				pos = {50,150},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 6,
				num = 2,
				delay = {0,0.2},
				pos = {50,150},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 6,
				num = 2,
				delay = {0.3,0.5},
				pos = {150,400},
				property = { 
					placeName = "place6", 
					startState = "rollright",
					id = 1,
				},
			},						
		},
	},	
	{

		enemys = {
			{
				time = 1,	                                               --奖励箱子
				num = 1,
				pos = {600},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 31,
					award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					isStand = true,
					placeName = "place5",
				},
			},
			{
				time = 2,
				num = 3,
				delay = {0.3,0.5,0.7},
				pos = {100,400,700},
				property = { 
					placeName = "place5", 
					startState = "rollright",
					id = 1,
				},
			},					
			{
				time = 4,
				num = 2,
				delay = {0,0.3},
				pos = {80,220},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 6,
				num = 2,
				delay = {0, 0.3},
				pos = {200,400},
				property = {
					placeName = "place6", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 7,
				num = 1,
				delay = {0},
				pos = {30},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},						
			{
				time = 8,
				num = 2,
				delay = {0, 0.3},
				pos = {300,550},
				property = { 
					placeName = "place5", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0},
				pos = {0,60},
				property = { 
					placeName = "place8", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 10,
				num = 2,
				delay = {0,0.3},
				pos = {80,420},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 11,
				num = 1,
				delay = {0},
				pos = {100},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 13,
				num = 1,
				delay = {0},
				pos = {130},
				property = { 
					placeName = "place3", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 14,
				num = 1,
				delay = {0},
				pos = {80},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
		},
	},				
}

--enemy的关卡配置                         无镶嵌 mp5伤害55  dps大于等于1 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=4,hp=490,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=390,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=4,hp=160,
	weak1=1},

	-- 金武箱子奖励  type = "awardSan",
	{id=31,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励


}


local mapId = "map_1_7"
local limit = 10

local isNotMoveMap = true  		--此关不能移动 

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = 10
	-- self.isNotMoveMap = isNotMoveMap

	self.fightMode =  {
		 type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 40,                   --限时模式时长

		-- type 	  = "taoFan",
		-- limitNums = 3,                      --逃跑逃犯数量
	}
	
end

return waveClass