local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {150},
				property = { 
					placeName = "place3",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 2,
				num = 2,
				delay = {0,0.2},
				pos = {100,175},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0,0.5},
				pos = {100,175},
				property = { 
					placeName = "place5",
					startState = "rollright",
					id = 1,
				},
			},					

			{
				time = 6,
				num = 2,
				delay ={0,0.5},
				pos = {0,100},		
				property = { 
					placeName = "place3",
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 8,
				num = 1,
				delay = {0.1},
				pos = {50},
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
				time = 10,
				num = 2,
				delay = {0.3,0.5},
				pos = {80,400},
				property = { 
					placeName = "place6", 
					startState = "rollright",
					id = 1,
				},
			},						
			{
				time = 12,
				num = 2,
				delay = {0, 0.6},
				pos = {100,400},
				property = {
					placeName = "place5", 
					startState = "rollleft",
					id = 1,
				},
			},
					
			{
				time = 14,
				num = 2,
				delay = {0,0.3},
				pos = {40,120},
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
				time = 18,
				num = 1,
				delay = {0},
				pos = {60},
				property = { 
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},						
			{
				time = 19,
				num = 2,
				delay = {0, 0.3},
				pos = {170,430},
				property = { 
					placeName = "place5", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 21,
				num = 2,
				delay = {0, 0.6},
				pos = {80,400},
				property = {
					placeName = "place6", 
					startState = "rollleft",
					id = 1,
				},
			},
					
			{
				time = 23,
				num = 1,
				delay = {0},
				pos = {200},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},						
			{
				time = 25,
				num = 2,
				delay = {0, 0.3},
				pos = {260,730},
				property = { 
					placeName = "place5", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 27,
				num = 2,
				delay = {0,0.5},
				pos = {20,120},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 29,
				num = 1,
				delay = {0},
				pos = {90},
				property = { 
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 30,
				num = 2,
				delay = {0,0.5},
				pos = {120,360},
				property = { 
					placeName = "place6", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 31,
				num = 1,
				delay = {0,},
				pos = {100},
				property = { 
					placeName = "place8",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 36,
				num = 2,
				delay = {0,0.5},
				pos = {300,650},
				property = { 
					placeName = "place5", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 38,
				num = 2,
				delay = {0,0.5},
				pos = {100,220},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 39,
				num = 1,
				delay = {0,},
				pos = {150},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 41,
				num = 2,
				delay = {0,0.5},
				pos = {200,400},
				property = { 
					placeName = "place6", 
					startState = "rollleft",
					id = 1,
				},
			},
		},
	},				
}

--enemy的关卡配置                         无镶嵌 mp5伤害55  dps大于等于1 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=1,hp=380,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=3,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=290,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},
	
	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=2,hp=110,
	weak1=1},

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
		-- type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		 type 	  = "xianShi",
		 limitTime = 50,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
	
end

return waveClass