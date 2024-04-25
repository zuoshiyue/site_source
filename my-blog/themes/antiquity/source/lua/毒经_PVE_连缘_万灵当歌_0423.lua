--[[ 奇穴: [蝎毒][食髓][黯影][虫兽][桃僵][忘情][嗜蛊][曲致][荒息][篾片蛊][引魂][连缘蛊]
秘籍:
蝎心  2伤害 2会心
蛇影  1会心 1持续 2伤害
百足  3调息(必须) 1伤害
灵蛊  1距离 3伤害
献祭  2调息(必须)

如果你有额外回蓝手段, [桃僵]可以换[重蛊]
靠近15尺内打, 否则引魂期间攻击打不到目标
条件允许靠近目标4尺, 引魂结束蛇跑向目标的时间会损失少量dps, 自己看情况处理
推荐1段加速, 装备破招会心会效
--]]

--关闭自动面向
setglobal("自动面向", false)

--宏选项
addopt("副本防开怪", false)
addopt("打断", false)
addopt("自动吃鼎", false)
addopt("自动吃万灵丹", false)
addopt("自动特效腰坠", true)

--变量表
local v = {}
v["记录信息"] = true

--主循环
function Main()
	--按下自定义快捷键1挂扶摇, 注意是快捷键设定里面插件的快捷键1指定的按键，不是键盘上的1
	if keydown(1) then
		cast("扶摇直上")
	end

	--减伤
	if fight() and pet() and life() < 0.6 then
		cast("玄水蛊")
	end

	--记录读条结束
	if casting("仙王蛊鼎") and castleft() < 0.13 then
		settimer("吃鼎读条结束")
	end
	if casting("连缘蛊") and castleft() < 0.13 then
		settimer("连缘读条结束")
	end

	--初始化变量
	v["GCD间隔"] = cdinterval(16)
	v["百足CD"] = scdtime("百足")
	v["蟾啸CD"] = scdtime("蟾啸")
	v["灵蛇引CD"] = scdtime("灵蛇引")
	v["献祭CD"] = scdtime("蛊虫献祭")
	v["灵蛇&献祭CD"] = math.max(v["灵蛇引CD"], v["献祭CD"])
	v["幻击CD"] = scdtime(36292)
	v["篾片蛊CD"] = scdtime("篾片蛊")
	v["连缘蛊CD"] = scdtime("连缘蛊")
	v["连缘蛊读条时间"] = casttime("连缘蛊")
	
	v["蝎心时间"] = tbufftime("蝎心", id())	--12秒
	v["蛇影时间"] = tbufftime("蛇影", id())	--18秒
	v["蛇影层数"] = tbuffsn("蛇影", id())
	v["百足时间"] = tbufftime("百足", id())	--18秒
	v["蟾啸时间"] = tbufftime("蟾啸", id())	--14秒
	v["献祭时间"] = bufftime("灵蛇献祭")	--12
	v["嗜蛊时间"] = bufftime("嗜蛊")	--15秒
	v["引魂时间"] = bufftime("引魂")	--10秒
	v["蓝量"] = mana() * 100

	
	--召蛇
	if nopet("灵蛇") then
		CastX("灵蛇引")
	end

	--目标不是敌对结束
	if not rela("敌对") then return end

	--凤凰蛊
	if qixue("荒息") then
		if dis() < 30 then
			if nobuff("凤凰蛊") or nofight() then
				CastX("凤凰蛊")
			end
		end
	end

	--副本防开怪
	if getopt("副本防开怪") and dungeon() and nofight() then return end

	--灵蛊
	v["放灵蛊"] = false
	if qixue("重蛊") and tbufftime("夺命蛊") < 5 then
		v["放灵蛊"] = true
	end
	if cn("灵蛊") > 1 then
		v["放灵蛊"] = true
	end
	if getopt("打断") and tbuffstate("可打断") then
		v["放灵蛊"] = true
	end
	if v["放灵蛊"] then
		local bLog = setglobal("记录技能释放", false)
		cast("灵蛊")
		if bLog then setglobal("记录技能释放", true) end
	end

	--宠物攻击
	if pet() then
		local bLog = setglobal("记录技能释放", false)
		cast("攻击")
		if bLog then setglobal("记录技能释放", true) end
	end

	--幻击
	if pet() and v["蛇影层数"] >= 2 then
		if v["连缘蛊CD"] > v["GCD间隔"] * 5 then
			CastX("幻击")
		end
	end

	--连缘蛊, 开始释放时判断dot数量, 每跳判断dot数量, buff 19513 等级代表dot数量
	v["移动键被按下"] = keydown("MOVEFORWARD") or keydown("MOVEBACKWARD") or keydown("STRAFELEFT") or keydown("STRAFERIGHT") or keydown("JUMP")
	v["最短dot时间"] = math.min(v["蝎心时间"], v["蛇影时间"], v["百足时间"], v["蟾啸时间"])
	if not v["移动键被按下"] and v["最短dot时间"] > v["连缘蛊读条时间"] then	--没在移动, 有4dot
		if CastX("连缘蛊") then
			stopmove()		--停止移动
			--nomove(true)	--禁止移动
			exit()
		end
	end

	--蛇影 连缘前5GCD
	if v["连缘蛊CD"] <= v["GCD间隔"] * 5 and v["蛇影时间"] <= v["GCD间隔"] * 5 + v["连缘蛊读条时间"] and getopt("自动特效腰坠") then
            use(8,37717) --暮天阳 12450
			use(8,38788) --池上雨 13950
		CastX("蛇影")
	end

	--篾片蛊 连缘前4GCD
	if v["连缘蛊CD"] <= v["GCD间隔"] * 4 then
		CastX("篾片蛊")
	end

	--献祭召蛇 连缘前3GCD
	if pet() and v["连缘蛊CD"] <= v["GCD间隔"] * 3 then
		if cdtime("灵蛇引") <= 0 then
			if CastX("蛊虫献祭") then
				if CastX("灵蛇引") then
					self().ClearCDTime(16)
				end
			end
		end
	end

	--百足 连缘前3GCD
	if v["连缘蛊CD"] <= v["GCD间隔"] * 3 or v["连缘蛊CD"] > 15 + v["GCD间隔"] * 2 then
		CastX("百足")
		if v["百足CD"] < 0.5 then	--等百足CD
			if cdleft(16) <= 0 then
				PrintInfo("---------- 等百足CD")
			end
			return
		end
	end

	-- 蟾啸 连缘前2GCD
	if v["连缘蛊CD"] <= v["GCD间隔"] * 2 then
		if not v["已经播放蟾啸提示"] then
			play("YuanDiBuDong_P")  -- 播放蟾啸提示
			v["已经播放蟾啸提示"] = true  -- 标记已播放
		end
		CastX("蟾啸")
	elseif v["已经播放蟾啸提示"] then
		v["已经播放蟾啸提示"] = false  -- 重置已播放标记
	end
	
	--蝎心 连缘前1GCD
	if v["连缘蛊CD"] <= v["GCD间隔"] and v["蝎心时间"] <= v["GCD间隔"] + v["连缘蛊读条时间"] then
		CastX("蝎心")
	end

	--蛇影 1层
	if v["蛇影层数"] < 1 or v["蛇影时间"] < 2.5 then
		CastX("蛇影")
	end

	--蟾啸
	if v["连缘蛊CD"] > 12 + v["GCD间隔"] * 2 then
		CastX("蟾啸")
	end

	--蝎心
	if bufftime("24479") > 0 then	--有破招
		CastX("蝎心")
	end
	
	--蛇影
	CastX("蛇影")

	--吃鼎
	if getopt("自动吃鼎") and gettimer("吃鼎读条结束") > 0.5 and nobuff("蛊时") and cdleft(16) > 0.5 then
		if life() < 0.7 or mana() < 0.8 then
			-- interact("仙王蛊鼎")
			interact(doodad("名字:仙王蛊鼎"))
		end
	end
	
	--10%蓝吃万灵丹
	if getopt("自动吃万灵丹") and v["蓝量"] < 10 then
			use(5,47610) --断浪·上品万灵丹
	end

	--没放技能记录信息
	if fight() and rela("敌对") and dis() < 20 and visible() and state("站立|走路|跑步|跳跃") and face() < 90 and cdleft(16) <= 0 and castleft() <= 0 and gettimer("连缘蛊") > 0.3 and gettimer("连缘读条结束") > 0.3 then
		PrintInfo("---------- 没放技能")
	end
end

-------------------------------------------------

--输出信息
function PrintInfo(s)
	local t = {}
	if s then t[#t+1] = s end
	t[#t+1] = "蝎心:"..v["蝎心时间"]
	t[#t+1] = "蛇影:"..v["蛇影层数"]..", "..v["蛇影时间"]
	t[#t+1] = "百足:"..v["百足时间"]
	t[#t+1] = "蟾啸:"..v["蟾啸时间"]
	t[#t+1] = "引魂:"..v["引魂时间"]
	t[#t+1] = "献祭:"..v["献祭时间"]
	t[#t+1] = "嗜蛊:"..v["嗜蛊时间"]

	t[#t+1] = "连缘蛊CD:"..v["连缘蛊CD"]
	t[#t+1] = "灵蛇&献祭CD:"..v["灵蛇&献祭CD"]
	t[#t+1] = "百足CD:"..v["百足CD"]
	t[#t+1] = "蟾啸CD:"..v["蟾啸CD"]
	t[#t+1] = "幻击CD:"..v["幻击CD"]
	
	print(table.concat(t, ", "))
end

--使用技能并输出信息
function CastX(szSkill, bSelf)
	if cast(szSkill, bSelf) then
		settimer(szSkill)
		if v["记录信息"] then PrintInfo() end
		return true
	end
	return false
end

-------------------------------------------------

--释放技能
function OnCast(CasterID, SkillName, SkillID, SkillLevel, TargetType, TargetID, PosY, PosZ, StartFrame, FrameCount)
	if CasterID == id() then
		if SkillID == 2226 then
			print("------------------------------ 蛊虫献祭")	--打印分割线方便查看每个循环技能释放情况
		end

		if SkillID == 29573 then	--篾片蛊
			if SkillID < 5 or v["引魂时间"] <= 0 then
				print("----------篾片蛊不是5级或没在引魂期间", SkillName, SkillID, SkillLevel)
			end
		end
	end
end

--记录战斗状态改变
function OnFight(bFight)
	if bFight then
		print("--------------------进入战斗")
	else
		print("--------------------离开战斗")
	end
end

-- 蛇影 - 篾片 - 献祭招蛇百足 - 蟾啸 - 蝎心 - 连缘 - 蛇影 幻击 - 蛇影 - 蝎心 ...
