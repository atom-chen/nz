local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 3,	
				num = 1,
				pos = {300},
				delay = {0.3},
				property = {
					placeName = "place2" ,
					id = 9,
					type = "bao",
				},
			},
			{
			
				time = 6,	
				num = 1,
				pos = {500},
				delay = {0.1},
				property = {
					placeName = "place2" ,
					id = 9,
					type = "bao",
				},
			},
			
			{
				time = 9,
				num = 6,
				delay = {0,1.4,0.7,0.8,1.6,2.4},
				pos = {450,470,500,960,1000,1080},
				property = {
					type = "jin",
					placeName = "place3",  
					id = 7,
				},
			},
			{
				time = 15,	
				num = 1,
				pos = {340},
				delay = {0.9},
				property = {
					placeName = "place2" ,
					id = 8,
					type = "jin",                                         --盾兵
				},
			},
			{
				time = 22,		
				num = 4,
				pos = {450,350,400,500},
				delay = {0,0.9,1.8,2.5,},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 26,		
				num = 2,
				pos = {100,200},
				delay = {1.8,2.3},
				property = { 
					placeName = "place2",
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},
			{
				time = 28,		
				num = 4,
				pos = {950,1050,1000,1250,},
				delay = {0,0.7,1.8,2.4,},
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 1,	
				},
			},
			{
				time = 29,		
				num = 2,
				pos = {500,530},
				delay = {0.8,1.6},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	                                       
				},
			},
			{
				time = 34,		
				num = 3,
				pos = {450,350,500},
				delay = {0,0.9,2.5,},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 36,		
				num = 2,
				pos = {450,550},
				delay = {1.8,2.3},
				property = { 
					placeName = "place2",
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},
			{
				time = 34,		
				num = 3,
				pos = {950,1050,1250,},
				delay = {0,0.7,2.4,},
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 1,	
				},
			},
			{
				time = 36,		
				num = 1,
				pos = {450},
				delay = {0.8},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	                                        --第30个怪
				},
			},
			
		},
	},

	{
		enemys = {
		   	{
				time = 2,
				num = 1,
				pos = {700},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		                                    --持续时间			
				},
			},
			{
				time = 6,
				num = 5,
				delay = {0.7,1.4, 2.1,2.8,3.1},
				pos = {350,400,600,750,800},					
				property = {
					placeName = "place3",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},	
			{
				time = 10,
				num = 5,
				delay = {0.7,1.4, 2.1,2.8,3.2},
				pos = {700,750,800,900,1000},					
				property = {
					placeName = "place4",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
			{
				time = 13,		
				num = 2,
				pos = {100,200},
				delay = {1.8,2.3},
				property = { 
					placeName = "place2",
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},	
			{
				time = 16,		
				num = 2,
				pos = {500,530},
				delay = {0.8,1.6},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	                                        
				},
			},
			{
				time = 19,
				num = 6,
				delay = {0,1.4,0.7,0.8,1.6,2.4},
				pos = {450,470,500,960,1000,1080},
				property = {
					type = "jin",
					placeName = "place3",                                
					id = 7,
				},
			},
			{
				time = 23,		
				num = 5,
				pos = {50,130,210,300,350},
				delay = {0.8,1.6,2.3,3.0,3.4},
				property = { 
					placeName = "place2",
					startState = "rollright",
					id = 1,                                        
				},
			},
			{
				time = 30,		
				num = 4,
				pos = {600,530,400,350},
				delay = {0.8,1.6,2.3,3.0},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,                                        
				},
			},                                                                        --30个怪
		},
	},

	{
		enemys = { 

			{
				time = 3,
				num = 5,
				delay = {0.1,0.5,0.8,1.2,1.5},
				pos = {330,550,660,760,1050},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 6,	
				num = 5,
				pos = {325,420,510,770,900},
				delay = {0.4,0.9,1.5,1.9,2.1},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 9,
				num = 5,
				delay = {2.0,2.5,3,2.5,2.0},
				pos = {380,680,960,720,888},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾 15
					id = 8,
				},
			},

			
			{
				time = 15,
				num = 10,
				delay = {0.5,0.9,1.3,1.8,2.1,2.60,2.4,3.0,3.3,3.6},
				pos = {350,460,600,1050,570,456,780,666,510,980},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},

			{
				time = 21,
				num = 1,
				delay = {1.6},
				pos = {670},
				property = { 
					placeName = "place11" ,
					type = "bao",                  --近战boss 15                                
					id = 16,
				},
			},
			{
				time = 26,
				num = 4,
				delay = {0.8,1.5,2.6,3},
				pos = {50,120,550,600},
				property = { 
					placeName = "place2" ,
					type = "dao",      --导
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},	
			{
				time = 31,
				num = 2,
				delay = {0.8,1.5},
				pos = {50,120},
				property = { 
					placeName = "place2" ,
					id = 1,
					startState = "rollright",	
				},                                                          
			},	
			{
				time = 33,
				num = 3,
				delay = {0.8,1.2,1.6},
				pos = {490,560,590},
				property = { 
					placeName = "place2" ,
					id = 1,
					startState = "rollleft",	
				},                                                          --30
			},	
			
		},
	},

	{
		waveType = "boss",                                      --强敌出现
		enemys = {                                                                -- 1-6 boss
			{
				time = 3,	
				num = 1,
				pos = {500},
				delay = {0.4},
				property = { 
					type = "boss",
					placeName = "place1",
					missileId = 6,            --BOSS导弹ID
					id = 1,            --boss里面id为1  ,以后有可能有很多boss         
				},
			},
		},
	},		

	{
		enemys = {                                                 -- 2-6 boss
			{
				time = 3,	
				num = 1,
				pos = {500},
				delay = {0.4},
				property = { 
					type = "duozuBoss",
					placeName = "place1",
					wangId    = 19,
					missileId = 6, 
					missileOffsets = {cc.p(-150,50) , cc.p(150, -50) , cc.p(150, 150)},
					id = 2,
				},
			},

		},
	},	
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级  dps大于等于7  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=21,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=3,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=28,hp=211,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=10000,
	weak1=2},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=25000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=35,hp=1000,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=30000,fireRate=180,fireCd=4,speed=40,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=90000,fireRate=180,fireCd=5,speed=35,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=25,hp=20000,fireRate=30,speed=120,
	weak1=2},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=150000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=150000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=2,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=2,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=2,award = 30},	--award = 30  金币数量为30
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=120,hp=90000,fireRate=60,fireCd=2,speed=40,scale = 2.5 ,
	weak1=2},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=40,hp=50000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=8000}, 
	
	--蜘蛛网
	{id=19,image="zzw",demage=10,hp=12500},  
	--盾兵BOSS         --type = "jin",
	{id=20,image="dunbing",demage=21,hp=100000,fireRate=60,fireCd= 3 ,speed= 80, scale = 2.6,
	weak1=2},                           
}



--fire1 dao1 dao2 发闪光弹
--fire2 dao3 dao4 dao5 --多发导弹
--fire3 dao6  --发蜘蛛网


	--boss的关卡配置
local bosses = {	
	--第1个出场的boss
	{
		image = "boss01", --图片名字
		-- hp = 150000,
		award = 50000,                   --boss产出金币数量
		hp = 160000,
		demage = 3,
		fireRate = 60,
		fireCd = 3,  		
		walkRate = 120,
		walkCd = 2,         --移动cd	
		wudiTime = 6 , 	
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 20, 			--一次扫射10下
		weak1 = 1.1,					--手  弱点伤害倍数
		weak2 = 1.1,					--腹  弱点伤害倍数
		weak3 = 1.1,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)


                                    
			wudi = {0.91,0.71,0.51,0.31,0.11            --无敌
			},                                        

			saoShe = { 0.90, 0.70, 0.50, 0.30 , 0.10   --调用普通攻击的伤害  扫射
			}, 

			-- zhaohuan = {0.95,0.65,0.35},                                        --召唤 

			moveLeftFire = {
				0.80, 0.40, 
			},
			moveRightFire = {
				0.60, 0.20,
			},
			
			daoDan = {                                   --两发导弹
				0.999,0.96,0.85,0.64, 0.45, 0.34, 0.22,
			},
			weak1 = {
				0.85,0.70,0.60,0.50,0.35
			},	
			weak2 = {
				0.95,0.80,0.65,0.30,0.40
			},	
			weak3 = {
				0.90,0.75,0.55,0.45,0.20
			},

			

			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.95,
			},	
			demage400 = {  
				0.70,
			},	
			demage600 = {  
				0.20,
			},							
		},
--[[
		enemys1 = {                                                   --第一波召唤的自爆兵
			{
				time = 2,	
				num = 3,
				pos = {560,660,760},
				delay = {0.2,0.4,0.5},
				property = {
					placeName = "place3" ,
					id = 16,
					type = "bao",
				},
			},
			{
				time = 9,	
				num = 4,
				pos = {520,620,830,950},
				delay = {0.8,0.6,0.4,0.2},
				property = {
					placeName = "place3" ,
					id = 16,
					type = "bao",
				},
			},
			{
				time = 16,	
				num = 5,
				pos = {400,480,660,860,1050},
				delay = {0.2,0.8,0.6,0.4,0.2},
				property = {
					placeName = "place3" ,
					id = 16,
					type = "bao",
				},
			},
		},


		enemys2 = {                                                      --第二波召唤的兵
			{
				time = 2,	
				num = 3,
				pos = {560,660,760},
				delay = {0.2,0.4,0.5},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "bao",
				},
			},
			{
				time = 7,	
				num = 4,
				pos = {520,620,830,950},
				delay = {0.8,0.6,0.4,0.2},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "bao",
				},
			},
			{
				time = 12,	
				num = 5,
				pos = {400,480,660,860,1050},
				delay = {0.2,0.8,0.6,0.4,0.2},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "bao",
				},
			},
		},


		
		enemys3 = {                                                      --第三波召唤的兵
			{
				time = 2,
				num = 1,
				pos = {300},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		                                    --持续时间			
				},
			},
			{
				time = 3,
				num = 1,
				pos = {400},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place9",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		                                    --持续时间			
				},
			},
			{
				time = 4,
				num = 1,
				pos = {900},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place9",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		                                    --持续时间			
				},
			},
		},		
]]
		getMoveLeftAction = function ()
			local move1 = cc.MoveBy:create(10/60, cc.p(0, 0))
			local move2 = cc.MoveBy:create(15/60, cc.p(-18, 0))
			local move3 = cc.MoveBy:create(13/60, cc.p(-45, 0))	
			local move4 = cc.MoveBy:create(7/60, cc.p(-12, 0))
			local move5 = cc.MoveBy:create(15/60, cc.p(-4, 0))
			return cc.Sequence:create(move1, move2, move3, move4, move5)
		end,

		getMoveRightAction = function ()
			local move1 = cc.MoveBy:create(10/60, cc.p(10, 0))
			local move2 = cc.MoveBy:create(15/60, cc.p(30, 0))
			local move3 = cc.MoveBy:create(10/60, cc.p(10, 0))	
			local move4 = cc.MoveBy:create(15/60, cc.p(12, 0))
			local move5 = cc.MoveBy:create(10/60, cc.p(4, 0))
			return cc.Sequence:create(move1, move2, move3, move4, move5)
		end,
	},
	--第2个出场的boss
	{
		image = "dzboss", --图片名字
		award = 50000,                   --boss产出金币数量
		hp = 250000,
		fireRate = 60,                  --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				    --
		walkRate = 180,                    --移动频率
		walkCd = 2,                         --移动cd				
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		wudiTime = 5.0,					--无敌时间
		skilltrigger = {   			          --技能触发(可以同时)
			wudi = { 0.91, 0.71, 0.51 , 0.31, 0.10               --召唤
			}, 

			zhaohuan = { 0.90, 0.70, 0.50, 0.30                     --召唤小兵
			},   

			wang = { 0.95,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15                    --网
			},

			-- yanwu = { 0.90,0.70,0.50,0.30,0.10                    --烟雾
			-- },  



			weak3 = { 0.85,0.65,0.45, 0.25,                                --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80,0.60,0.40, 0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90,0.70,0.50,0.30,0.10                              --头 技能触发(可以同时)	                        
			},
			demage125 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.85,
			},	
			demage250 = {  
				0.60,
			},	
			demage400 = {  
				0.50,
			},	
						
		},
		enemys1 = {                                                   --第一波召唤自爆兵
			{
				time = 2,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {350,600,1000},
				property = { 
					placeName = "place6" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.1,0.2,0.3,0.4},
				pos = {320,600,750,1000},
				property = { 
					placeName = "place5" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 8,
				num = 5,
				delay = {0.1,0.2,0.3,0.4,0.1},
				pos = {280,410,580,750,940},
				property = { 
					placeName = "place4" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			

		},	

		enemys2 = {                                                   --第二波召唤盾兵
			{
				time = 2,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {390,540,888},
				property = { 
					placeName = "place6" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.1,0.2,0.3,0.4},
				pos = {333,666,777,999},
				property = { 
					placeName = "place5" ,
					type = "jin",       --近
					id = 7,
				},
			},
			{
				time = 8,
				num = 5,
				delay = {0.1,0.2,0.3,0.4,0.1},
				pos = {288,338,558,668,998},
				property = { 
					placeName = "place4" ,
					type = "jin",       --盾
					id = 8,
				},
			},
			

	    },	

		enemys3 = {                                                   --第三波召唤的忍者兵
			{
				time = 2,
				num = 1,
				pos = {400},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		                                    --持续时间			
				},
			},
			{
				time = 5,
				num = 2,
				pos = {400,880},
				delay = {0.3,0.9},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place9",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		                                    --持续时间			
				},
			},
			{
				time = 8,
				num = 3,
				pos = {200,550,920},
				delay = {0.5,1.2,1.8},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		--持续时间
					--demageScale = 1.5                    --伤害翻1.5倍		

				},
			},
			
		},	

		enemys4 = {                                                   --第三波召唤的忍者兵
			{
				time = 2,
				num = 1,
				pos = {400},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		                                    --持续时间
					--demageScale = 1.5                    --伤害翻1.5倍			
				},
			},
			{
				time = 5,
				num = 2,
				pos = {400,880},
				delay = {0.3,0.9},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place9",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		                                    --持续时间
					--demageScale = 1.5                    --伤害翻1.5倍			
				},
			},
			{
				time = 8,
				num = 3,
				pos = {200,550,920},
				delay = {0.5,1.2,1.8},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		--持续时间
					--demageScale = 1.5                    --伤害翻1.5倍		

				},
			},
			
		},													
	},
}

local mapId = "map_1_6"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.goldLimits = {75,160,250}  --黄武激活所需杀人个数
	
end
return waveClass