--[[ ��Ѩ: [Ы��][ʳ��][��Ӱ][����][�ҽ�][����][�ȹ�][����][��Ϣ][��Ƭ��][����][��Ե��]
�ؼ�:
Ы��  2�˺� 2����
��Ӱ  1���� 1���� 2�˺�
����  3��Ϣ(����) 1�˺�
���  1���� 3�˺�
�׼�  2��Ϣ(����)

������ж�������ֶ�, [�ҽ�]���Ի�[�ع�]
����15���ڴ�, ���������ڼ乥���򲻵�Ŀ��
����������Ŀ��4��, �������������Ŀ���ʱ�����ʧ����dps, �Լ����������
�Ƽ�1�μ���, װ�����л��Ļ�Ч
--]]

--�ر��Զ�����
setglobal("�Զ�����", false)

--��ѡ��
addopt("����������", false)
addopt("���", false)
addopt("�Զ��Զ�", false)
addopt("�Զ������鵤", false)
addopt("�Զ���Ч��׹", true)

--������
local v = {}
v["��¼��Ϣ"] = true

--��ѭ��
function Main()
	--�����Զ����ݼ�1�ҷ�ҡ, ע���ǿ�ݼ��趨�������Ŀ�ݼ�1ָ���İ��������Ǽ����ϵ�1
	if keydown(1) then
		cast("��ҡֱ��")
	end

	--����
	if fight() and pet() and life() < 0.6 then
		cast("��ˮ��")
	end

	--��¼��������
	if casting("�����ƶ�") and castleft() < 0.13 then
		settimer("�Զ���������")
	end
	if casting("��Ե��") and castleft() < 0.13 then
		settimer("��Ե��������")
	end

	--��ʼ������
	v["GCD���"] = cdinterval(16)
	v["����CD"] = scdtime("����")
	v["�ХCD"] = scdtime("�Х")
	v["������CD"] = scdtime("������")
	v["�׼�CD"] = scdtime("�Ƴ��׼�")
	v["����&�׼�CD"] = math.max(v["������CD"], v["�׼�CD"])
	v["�û�CD"] = scdtime(36292)
	v["��Ƭ��CD"] = scdtime("��Ƭ��")
	v["��Ե��CD"] = scdtime("��Ե��")
	v["��Ե�ƶ���ʱ��"] = casttime("��Ե��")
	
	v["Ы��ʱ��"] = tbufftime("Ы��", id())	--12��
	v["��Ӱʱ��"] = tbufftime("��Ӱ", id())	--18��
	v["��Ӱ����"] = tbuffsn("��Ӱ", id())
	v["����ʱ��"] = tbufftime("����", id())	--18��
	v["�Хʱ��"] = tbufftime("�Х", id())	--14��
	v["�׼�ʱ��"] = bufftime("�����׼�")	--12
	v["�ȹ�ʱ��"] = bufftime("�ȹ�")	--15��
	v["����ʱ��"] = bufftime("����")	--10��
	v["����"] = mana() * 100

	
	--����
	if nopet("����") then
		CastX("������")
	end

	--Ŀ�겻�ǵжԽ���
	if not rela("�ж�") then return end

	--��˹�
	if qixue("��Ϣ") then
		if dis() < 30 then
			if nobuff("��˹�") or nofight() then
				CastX("��˹�")
			end
		end
	end

	--����������
	if getopt("����������") and dungeon() and nofight() then return end

	--���
	v["�����"] = false
	if qixue("�ع�") and tbufftime("������") < 5 then
		v["�����"] = true
	end
	if cn("���") > 1 then
		v["�����"] = true
	end
	if getopt("���") and tbuffstate("�ɴ��") then
		v["�����"] = true
	end
	if v["�����"] then
		local bLog = setglobal("��¼�����ͷ�", false)
		cast("���")
		if bLog then setglobal("��¼�����ͷ�", true) end
	end

	--���﹥��
	if pet() then
		local bLog = setglobal("��¼�����ͷ�", false)
		cast("����")
		if bLog then setglobal("��¼�����ͷ�", true) end
	end

	--�û�
	if pet() and v["��Ӱ����"] >= 2 then
		if v["��Ե��CD"] > v["GCD���"] * 5 then
			CastX("�û�")
		end
	end

	--��Ե��, ��ʼ�ͷ�ʱ�ж�dot����, ÿ���ж�dot����, buff 19513 �ȼ�����dot����
	v["�ƶ���������"] = keydown("MOVEFORWARD") or keydown("MOVEBACKWARD") or keydown("STRAFELEFT") or keydown("STRAFERIGHT") or keydown("JUMP")
	v["���dotʱ��"] = math.min(v["Ы��ʱ��"], v["��Ӱʱ��"], v["����ʱ��"], v["�Хʱ��"])
	if not v["�ƶ���������"] and v["���dotʱ��"] > v["��Ե�ƶ���ʱ��"] then	--û���ƶ�, ��4dot
		if CastX("��Ե��") then
			stopmove()		--ֹͣ�ƶ�
			--nomove(true)	--��ֹ�ƶ�
			exit()
		end
	end

	--��Ӱ ��Եǰ5GCD
	if v["��Ե��CD"] <= v["GCD���"] * 5 and v["��Ӱʱ��"] <= v["GCD���"] * 5 + v["��Ե�ƶ���ʱ��"] and getopt("�Զ���Ч��׹") then
            use(8,37717) --ĺ���� 12450
			use(8,38788) --������ 13950
		CastX("��Ӱ")
	end

	--��Ƭ�� ��Եǰ4GCD
	if v["��Ե��CD"] <= v["GCD���"] * 4 then
		CastX("��Ƭ��")
	end

	--�׼����� ��Եǰ3GCD
	if pet() and v["��Ե��CD"] <= v["GCD���"] * 3 then
		if cdtime("������") <= 0 then
			if CastX("�Ƴ��׼�") then
				if CastX("������") then
					self().ClearCDTime(16)
				end
			end
		end
	end

	--���� ��Եǰ3GCD
	if v["��Ե��CD"] <= v["GCD���"] * 3 or v["��Ե��CD"] > 15 + v["GCD���"] * 2 then
		CastX("����")
		if v["����CD"] < 0.5 then	--�Ȱ���CD
			if cdleft(16) <= 0 then
				PrintInfo("---------- �Ȱ���CD")
			end
			return
		end
	end

	-- �Х ��Եǰ2GCD
	if v["��Ե��CD"] <= v["GCD���"] * 2 then
		if not v["�Ѿ������Х��ʾ"] then
			play("YuanDiBuDong_P")  -- �����Х��ʾ
			v["�Ѿ������Х��ʾ"] = true  -- ����Ѳ���
		end
		CastX("�Х")
	elseif v["�Ѿ������Х��ʾ"] then
		v["�Ѿ������Х��ʾ"] = false  -- �����Ѳ��ű��
	end
	
	--Ы�� ��Եǰ1GCD
	if v["��Ե��CD"] <= v["GCD���"] and v["Ы��ʱ��"] <= v["GCD���"] + v["��Ե�ƶ���ʱ��"] then
		CastX("Ы��")
	end

	--��Ӱ 1��
	if v["��Ӱ����"] < 1 or v["��Ӱʱ��"] < 2.5 then
		CastX("��Ӱ")
	end

	--�Х
	if v["��Ե��CD"] > 12 + v["GCD���"] * 2 then
		CastX("�Х")
	end

	--Ы��
	if bufftime("24479") > 0 then	--������
		CastX("Ы��")
	end
	
	--��Ӱ
	CastX("��Ӱ")

	--�Զ�
	if getopt("�Զ��Զ�") and gettimer("�Զ���������") > 0.5 and nobuff("��ʱ") and cdleft(16) > 0.5 then
		if life() < 0.7 or mana() < 0.8 then
			-- interact("�����ƶ�")
			interact(doodad("����:�����ƶ�"))
		end
	end
	
	--10%�������鵤
	if getopt("�Զ������鵤") and v["����"] < 10 then
			use(5,47610) --���ˡ���Ʒ���鵤
	end

	--û�ż��ܼ�¼��Ϣ
	if fight() and rela("�ж�") and dis() < 20 and visible() and state("վ��|��·|�ܲ�|��Ծ") and face() < 90 and cdleft(16) <= 0 and castleft() <= 0 and gettimer("��Ե��") > 0.3 and gettimer("��Ե��������") > 0.3 then
		PrintInfo("---------- û�ż���")
	end
end

-------------------------------------------------

--�����Ϣ
function PrintInfo(s)
	local t = {}
	if s then t[#t+1] = s end
	t[#t+1] = "Ы��:"..v["Ы��ʱ��"]
	t[#t+1] = "��Ӱ:"..v["��Ӱ����"]..", "..v["��Ӱʱ��"]
	t[#t+1] = "����:"..v["����ʱ��"]
	t[#t+1] = "�Х:"..v["�Хʱ��"]
	t[#t+1] = "����:"..v["����ʱ��"]
	t[#t+1] = "�׼�:"..v["�׼�ʱ��"]
	t[#t+1] = "�ȹ�:"..v["�ȹ�ʱ��"]

	t[#t+1] = "��Ե��CD:"..v["��Ե��CD"]
	t[#t+1] = "����&�׼�CD:"..v["����&�׼�CD"]
	t[#t+1] = "����CD:"..v["����CD"]
	t[#t+1] = "�ХCD:"..v["�ХCD"]
	t[#t+1] = "�û�CD:"..v["�û�CD"]
	
	print(table.concat(t, ", "))
end

--ʹ�ü��ܲ������Ϣ
function CastX(szSkill, bSelf)
	if cast(szSkill, bSelf) then
		settimer(szSkill)
		if v["��¼��Ϣ"] then PrintInfo() end
		return true
	end
	return false
end

-------------------------------------------------

--�ͷż���
function OnCast(CasterID, SkillName, SkillID, SkillLevel, TargetType, TargetID, PosY, PosZ, StartFrame, FrameCount)
	if CasterID == id() then
		if SkillID == 2226 then
			print("------------------------------ �Ƴ��׼�")	--��ӡ�ָ��߷���鿴ÿ��ѭ�������ͷ����
		end

		if SkillID == 29573 then	--��Ƭ��
			if SkillID < 5 or v["����ʱ��"] <= 0 then
				print("----------��Ƭ�Ʋ���5����û�������ڼ�", SkillName, SkillID, SkillLevel)
			end
		end
	end
end

--��¼ս��״̬�ı�
function OnFight(bFight)
	if bFight then
		print("--------------------����ս��")
	else
		print("--------------------�뿪ս��")
	end
end

-- ��Ӱ - ��Ƭ - �׼����߰��� - �Х - Ы�� - ��Ե - ��Ӱ �û� - ��Ӱ - Ы�� ...
