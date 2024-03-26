local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - powered by Turtle Team & Turtle Secure")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Other features")
local T3 = wndw:Tab("Draw")
local T4 = wndw:Tab("Defense mode")
local T5 = wndw:Tab("Dungeon")
local T9 = wndw:Tab("Stats Upgrader")
local T6 = wndw:Tab("Codes list")
local T8 = wndw:Tab("Credits")
local T10 = wndw:Tab("Save")
local CnfgIndicators = T10:Label("Config Indicators\n{}")

local workspace = game:GetService("Workspace")
local serverplayer = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local user = serverplayer.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local GC = getconnections or get_signal_cons
local VirtualUser = game:GetService("VirtualUser")
local LogService = game:GetService("LogService")
local HttpService = game:GetService("HttpService")
local a = "Turtle Hub"
local b = "ConfigSaver.lua"
local configsystem = {
	JoinDefense = false,
	AboveCrystal = false,
	JoinDungeon = false,
	UpgradeStats = false,
	ClaimAndAcceptQuest = false,
	KillV1 = false,
	FastAutoKill = false,
	SlowAutoKill = false,
	CollectLootDrops = false,
	CollectMails = false,
	EquipBestEquipment = false,
	AutoDrawX1 = false,
	AutoDrawX10 = false,
	DrawWeaponX1 = false,
	DrawWeaponX3 = false,
	DrawHeroX1 = false,
	DrawHeroX10 = false,
	DrawCosmetics = false,
	JoinSoloDungeon = false,
	DefenseWave = "Wave 1",
	DungeonWave = "Skull Island [ Lv.60 ] [ World 2 ]",
	DungeonDifficult = "Easy",
	SelectedStats = "Health",
	SoloDungeonWave = "Wave 1"
} --configsystem. lib:hooksend(str)

local function saveSettings()
    local d = HttpService:JSONEncode(configsystem)
    if writefile then
        if isfolder(a) then
            writefile(a .. "-" .. b,d)
        else
            makefolder(a)
            writefile(a .. "-" .. b,d)
        end
    end
end

local function loadSettings()
    if isfile(a .. "-" .. b) then
        configsystem = HttpService:JSONDecode(readfile(a .. "-" .. b))
    end
end
loadSettings()

local vis = {
  a = 0,
  b = 10000,
  c = false,
  d = 1,
  e = 15030001,
  f = ""
}

local draw = {
  a = 7000000
}

local codes = {
	list = {
		"NEWGAME",
		"NEWGAME2",
		"WEEKENDGIFT1",
		"WEEKENDGIFT2",
		"FREEGIFT",
		"GOLDGIFT",
		"GEMGIFT",
		"BOOSTGIFT",
		"DISCORD"
	}
}

local espHD = false

local function setESP(trgt)
  if trgt:FindFirstChild("XRAY") then
    trgt["XRAY"]:Destroy()
  end

if espHD == true then
      local esp = Instance.new("Highlight")
      esp.Name = "XRAY"
      esp.FillColor = Color3.new(0,1,0)
      esp.OutlineColor = Color3.new(1,1,1)
      esp.FillTransparency = 0
      esp.OutlineTransparency = 0
      esp.Adornee = trgt
      esp.Parent = trgt
      esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  end
end

--game:GetService("Workspace")["副本地图"]["5"]["地图"]["Enemy"]["2_1"]["44018"]["UpperTorso"]
local function FindTarget()
  for _,tbl1 in pairs(workspace:GetChildren()) do
    if tbl1:FindFirstChild("副本地图") then
      for i,v in pairs(workspace["副本地图"]:GetDescendants()) do
        if v.Name == "UpperTorso" then
          setESP(v["UpperTorso"])
        end
      end
    end
  end
end

local function UserWarning(str,params)
	lib:WarnUser(str,{
		AutoClose = params[1],
		CanClick = params[2],
		Duration = params[3]
	})
end


local function getLevel()
	return user["leaderstats"]["Level"]["Value"]
end

local function bypassAFK()
if GC then
	for i,v in pairs(GC(user.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	user.Idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end
end

local function Bring(part)
	TweenService:Create(part,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{CFrame = user.Character.HumanoidRootPart.CFrame}):Play()
end

local function getPlayerESP()
  for i,v in pairs(serverplayer:GetPlayers()) do
    setESP(v["Character"])
  end
end

local function tpabove(prt)
        user["Character"]:SetPrimaryPartCFrame(CFrame.new(prt.Position + Vector3.new(0,prt.Size.Y/2 + user["Character"]["HumanoidRootPart"].Size.Y/2 + 2,0)))
end

local function getNearestNPC(character,npcsFolder) -- Your character and the folder containing all the NPCs
    local rootPart = character["HumanoidRootPart"]
    local rootPosition = rootPart.Position
    
    local maxDistance = 50 -- Change it to the maximum distance you want an NPC to be
    for _,model in ipairs(workspace["副本地图"]:GetDescendants()) do
        if model:IsA("Model") and model.Name ~= "Model" then
            local distance = (model.Position - user.Character.HumanoidRootPart.Position).Magnitude
            if distance < maxDistance then
                game:GetService("ReplicatedStorage")["Msg"]["HitEvent"]:FireServer({["castPercent"] = vis.a,["damage"] = vis.b,["isSetNetworkOwnerEnemy"] = vis.c,["hitID"] = vis.d,["skillID"] = vis.e},model.Name)
            end
        end
    end
end

local function getEnemyById(name)
	if name:sub(1,1) == "1" or name:sub(1,1) == "2" or name:sub(1,1) == "3" or name:sub(1,1) == "4" or name:sub(1,1) == "5" or name:sub(1,1) == "6" or name:sub(1,1) == "7" or name:sub(1,1) == "8" or name:sub(1,1) == "9" or name:sub(1,1) == "0" and name:sub(2,2) == "_" and name:sub(3,3) == "1" or name:sub(3,3) == "2" or name:sub(3,3) == "3" or name:sub(3,3) == "4" or name:sub(3,3) == "5" or name:sub(3,3) == "6" or name:sub(3,3) == "7" or name:sub(3,3) == "8" or name:sub(3,3) == "9" or name:sub(3,3) == "0" then
		return true
	else
		return false
	end
end

local function DungeonTrigger(str,dsct)
	if dsct == "trigger" then
		game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180",str)
	elseif dsct == "untrigger" then
		game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\128\128\229\135\186\231\187\132\233\152\159\230\136\191\233\151\180",str)
	end
end

local function filterString(str)
	return str:gsub("Wave 1","1"):gsub("Wave 50","2"):gsub("Wave 100","3"):gsub("Wave 150","4"):gsub("Wave 200","5"):gsub("Skull Island [ Lv.60 ]","2_1"):gsub("Desert City [ Lv.80 ]","2_2"):gsub("Frozen Fortress [ Lv.100 ]","2_3"):gsub("Seven Sea [ Lv.120 ]","2_4"):gsub("Graveyard [ Lv.140 ]","2_5")
end

local wave = "Wave 1"
T4:Dropdown("Select wave",{"Wave 1","Wave 50","Wave 100","Wave 150","Wave 200"},function(value)
    configsystem.DefenseWave = value
end)

T4:Toggle("Auto join defense mode ( World 1, 2 & 3)",configsystem.JoinDefense,function(value)
	_G.JDM = value
	configsystem.JoinDefense = value
	while wait() do
		if _G.JDM == false then break end
			if configsystem.DefenseWave == "Wave 1" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\229\161\148\233\152\178\230\168\161\229\188\143")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",1)
			elseif configsystem.DefenseWave == "Wave 50" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\229\161\148\233\152\178\230\168\161\229\188\143")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",2)
			elseif configsystem.DefenseWave == "Wave 100" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\229\161\148\233\152\178\230\168\161\229\188\143")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",3)
			elseif configsystem.DefenseWave == "Wave 150" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\229\161\148\233\152\178\230\168\161\229\188\143")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",4)
			elseif configsystem.DefenseWave == "Wave 200" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\229\161\148\233\152\178\230\168\161\229\188\143")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",5)
			else
				UserWarning("Invalid wave!",{false,true,10})
			end
	end
end)

T4:Toggle("Auto tp above the crystal",configsystem.AboveCrystal,function(value)
	_G.tpac = value
	configsystem.AboveCrystal = value
	while wait() do
		if _G.tpac == false then break end
			for i,v in pairs(game:GetService("Workspace")["副本地图"]:GetDescendants()) do
				if v.Name == "碰撞" then
					tpabove(v)
				end
			end
	end
end)


local function getDungeon(str,gst)
	if str == "Skull Island [ Lv.60 ] [ World 2 ]" then
		DungeonTrigger("2_1",gst)
	elseif str == "Desert City [ Lv.80 ] [ World 2 ]" then
		DungeonTrigger("2_2",gst)
	elseif str == "Frozen Fortress [ Lv.100 ] [ World 2 ]" then
		DungeonTrigger("2_3",gst)
	elseif str == "Seven Sea [ Lv.120 ] [ World 2 ]" then
		DungeonTrigger("2_4",gst)
	elseif str == "Graveyard [ Lv.140 ] [ World 2 ]" then
		DungeonTrigger("2_5",gst)
	elseif str == "Snow Village [ Lv.160 ] [ World 3 ]" then
		DungeonTrigger("3_1",gst)
	elseif str == "Spiders Mountain [ Lv.180 ] [ World 3 ]" then
		DungeonTrigger("3_2",gst)
	elseif str == "Infinite Train[ Lv.200 ] [ World 3 ]" then
		DungeonTrigger("3_3",gst)
	elseif str == "Sakura Street [ Lv.220 ] [ World 3 ]" then
		DungeonTrigger("3_4",gst)
	end
end

T5:Dropdown("Select dungeon",{"Skull Island [ Lv.60 ] [ World 2 ]","Desert City [ Lv.80 ] [ World 2 ]","Frozen Fortress [ Lv.100 ] [ World 2 ]","Seven Sea [ Lv.120 ] [ World 2 ]","Graveyard [ Lv.140 ] [ World 2 ]","Snow Village [ Lv.160 ] [ World 3 ]","Spiders Mountain [ Lv.180 ] [ World 3 ]","Infinite Train [ Lv.200 ] [ World 3 ]","Sakura Street [ Lv.220 ] [ World 3 ]"},function(value)
	configsystem.DungeonWave = value
end)

T5:Dropdown("Select difficulty",{"Easy","Normal","Hard","Hell"},function(value)
	configsystem.DungeonDifficult = value
end)

T5:Toggle("Auto join dungeon ( 2nd & 3rd world only )",configsystem.JoinDungeon,function(value)
	_G.ajdscrt = value
	configsystem.JoinDungeon = value
	getDungeon(configsystem.DungeonWave,"untrigger")
	while wait() do
		if _G.ajdscrt == false then break end
			getDungeon(configsystem.DungeonWave,"trigger")
			if configsystem.DungeonDifficult == "Easy" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",1)
			elseif configsystem.DungeonDifficult == "Normal" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",2)
			elseif configsystem.DungeonDifficult == "Hard" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",3)
			elseif configsystem.DungeonDifficult == "Hell" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",4)
			end
	end
end)

T5:Button("Join dungeon ( 2nd and 3rd world only )",function()
	getDungeon(configsystem.DungeonWave,"trigger")
	if configsystem.DungeonDifficult == "Easy" then
		game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",1)
	elseif configsystem.DungeonDifficult == "Normal" then
		game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",2)
	elseif configsystem.DungeonDifficult == "Hard" then
		game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",3)
	elseif configsystem.DungeonDifficult == "Hell" then
		game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",4)
	end
end)

local function UpgStats(str,usage)
	if type(usage) == "number" or typeof(usage) == "number" then
		game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\177\158\230\128\167\231\130\185\229\138\160\231\130\185",{["attr"] = str,["addonce"] = usage})
	else
		UserWarning("[ Turtle Client Debugging ]\nThe second argument in the function 'turtle:UpgradeStatsTrigger()' is not a number type.\nPlease change the argument to a number before using this feature",{false,true,10})
	end
end

T9:Dropdown("Select Stats",{"Health","Attack","Defense","Critical"},function(value)
	configsystem.SelectedStats = value
end)

T9:Toggle("Auto upgrade selected stats",configsystem.UpgradeStats,function(value)
	_G.Auss = value
	configsystem.UpgradeStats = value
		while wait() do
			if _G.Auss == false then break end
			if configsystem.SelectedStats == "Health" then
				UpgStats("3",1)
			elseif configsystem.SelectedStats == "Attack" then
				UpgStats("1",1)
			elseif configsystem.SelectedStats == "Defense" then
				UpgStats("2",1)
			elseif configsystem.SelectedStats == "Critical" then
				UpgStats("6",1)
			else
				UserWarning("Invalid stats name",{false,true,10})
			end
		end
end)


T2:Button("Claim unlocked Battle Pass reward",function()
    for array = 1,50 do
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\162\134\229\143\150\228\184\128\228\184\170\229\173\163\231\165\168\229\165\150\229\138\177",{["id"] = array,["isPay"] = false})
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\162\134\229\143\150\228\184\128\228\184\170\229\173\163\231\165\168\229\165\150\229\138\177",{["id"] = array,["isPay"] = true})
    end
end)

T2:Button("Claim daily XP boost",function()
    game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\162\134\229\143\150\229\143\140\229\128\141\231\187\143\233\170\140")
end)

T2:Toggle("Auto claim & accept quest",configsystem.ClaimAndAcceptQuest,function(value)
	_G.autotask = value
	configsystem.ClaimAndAcceptQuest = value
	while wait() do
		if _G.autotask == false then break end
			game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\162\134\229\143\150NPC\228\187\187\229\138\161\229\165\150\229\138\177")
			game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\162\134\229\143\150NPC\228\187\187\229\138\161")
	end
end)

T2:Button("Vanguard RemoteDetection ( RemoteSpy )",function()
	UserWarning("Loading",{false,true,10})
	lib:RemoteSpy()
end)

T1:Toggle("Auto " .. lib:ColorFonts("kill","Red") .. " V1 [ " .. lib:ColorFonts("Hit","Red") .. " the " .. lib:ColorFonts("enemy","Red") .. " first ]",configsystem.KillV1,function(value)
    _G.killv1 = value
    configsystem.KillV1 = value
    while wait() do
      if _G.killv1 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["HitEvent"]:FireServer({["castPercent"] = vis.a,["damage"] = vis.b,["isSetNetworkOwnerEnemy"] = vis.c,["hitID"] = vis.d,["skillID"] = vis.e},vis.f)
    end
end)

T1:Toggle("Auto " .. lib:ColorFonts("kill","Red") .. " [ Faster ] [ For Bosses ]",configsystem.FastAutoKill,function(value)
    _G.killv2 = value
    configsystem.FastAutoKill = value
    while wait() do
      if _G.killv2 == false then break end
	for i,v in pairs(workspace["副本地图"]:GetDescendants()) do
		if v:IsA("Model") and v.Name ~= "Model" and getEnemyById(v.Parent.Name) then
			game:GetService("ReplicatedStorage")["Msg"]["HitEvent"]:FireServer({["castPercent"] = vis.a,["damage"] = vis.b,["isSetNetworkOwnerEnemy"] = vis.c,["hitID"] = vis.d,["skillID"] = vis.e},v.Name)
		end
	end
    end
end)

T1:Toggle("Auto " .. lib:ColorFonts("kill","Red") .. " every 1s [ For Non-Boss ]",configsystem.SlowAutoKill,function(value)
    _G.killv5 = value
    configsystem.SlowAutoKill = value
    while wait(1) do
      if _G.killv5 == false then break end
	for i,v in pairs(workspace["副本地图"]:GetDescendants()) do
		if v:IsA("Model") and v.Name ~= "Model" and getEnemyById(v.Parent.Name) then
			game:GetService("ReplicatedStorage")["Msg"]["HitEvent"]:FireServer({["castPercent"] = vis.a,["damage"] = vis.b,["isSetNetworkOwnerEnemy"] = vis.c,["hitID"] = vis.d,["skillID"] = vis.e},v.Name)
		end
	end
    end
end)

--[[T1:Toggle("Auto level max hero [ Feed ]",false,function(value)
    _G.maxh = value
end)
]]

T1:Toggle("Auto collect loot drops",configsystem.CollectLootDrops,function(value)
    _G.tfurteaw = value
    configsystem.CollectLootDrops = value
    for i,v in pairs(workspace["DropFolder"]:GetChildren()) do
	if v.Name ~= "掉落模板" then
		Bring(v)
	end
    end
end)

T1:Toggle("Auto claim mails every 0.001",configsystem.CollectMails,function(value)
	_G.mails = value
	configsystem.CollectMails = value
	for array = 1,9e9 do
		if _G.mails == false then break end
		wait(0.001)
		game:GetService("ReplicatedStorage")["Msg"]["RemoteEvent"]:FireServer("\233\162\134\229\143\150\233\130\174\228\187\182\229\165\150\229\138\177",array)
	end
end)
--[[for i,v in pairs(Workspace["2_1"]:GetDescendants()) do
if v:IsA("ProximityPrompt") then
fireproximityprompt(v)
end
end]]
T1:Toggle("Auto equip best equipment every 1s",configsystem.EquipBestEquipment,function(value)
    _G.ebees = value
    configsystem.EquipBestEquipment = value
    while wait(1) do
      if _G.ebees == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\232\163\133\229\164\135\230\156\128\228\189\179\232\163\133\229\164\135")
    end
end)

if user.Name == "Rivanda_Cheater" then
T1:Toggle("Auto claim nearest egg [ EASTER ]",configsystem.EquipBestEquipment,function(value)
    _G.easter = value
    while wait() do
      if _G.easter == false then break end
      for i,v in pairs(workspace:GetChildren()) do
	if v.Name:sub(1,2) == "2_" or v.Name:sub(1,2) == "1_" then
		for ind,array in pairs(v:GetDescendants()) do
			if array:IsA("ProximityPrompt") then
				fireproximityprompt(array)
			end
		end
	end
      end
    end
end)
end

if user.Name == "Rivanda_Cheater" then
T1:Toggle("Staff test feature [1] [ Akbar ]",false,function(value)
    _G.FD1 = value
end)

T1:Toggle("Staff test feature [2] [ Akbar ]",false,function(value)
    _G.FD2 = value
end)
end

T3:Toggle("Auto draw fruit [ X1 ]",configsystem.AutoDrawX1,function(value)
    _G.df = value
    configsystem.AutoDrawX1 = value
    while wait() do
      if _G.df == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawFruit"]:InvokeServer(1)
    end
end)

T3:Toggle("Auto draw fruit [ X10 ]",configsystem.AutoDrawX10,function(value)
    _G.dfn = value
    configsystem.AutoDrawX10 = value
    while wait() do
      if _G.dfn == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawFruit"]:InvokeServer(10)
    end
end)

T3:Toggle("Draw weapon [ Draw before enabling this ] [ X1 ]",configsystem.DrawWeaponX1,function(value)
    _G.dw1 = value
    configsystem.DrawWeaponX1 = value
    while wait() do
      if _G.dw1 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawWeapon"]:InvokeServer(draw.a,1)
    end
end)

T3:Toggle("Draw weapon [ Draw before enabling this ] [ X3 ]",configsystem.DrawWeaponX3,function(value)
    _G.dw2 = value
    configsystem.DrawWeaponX3 = value
    while wait() do
      if _G.dw2 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawWeapon"]:InvokeServer(draw.a,3)
    end
end)

T3:Toggle("Draw hero [ X1 ] [ World 1 ]",configsystem.DrawHeroX1,function(value)
    _G.dh1 = value
    configsystem.DrawHeroX1 = value
    while wait() do
      if _G.dh1 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawHero"]:InvokeServer(1,1)
    end
end)

T3:Toggle("Draw hero [ X10 ] [ World 1 ]",configsystem.DrawHeroX10,function(value)
    _G.dh2 = value
    configsystem.DrawHeroX10 = value
    while wait() do
      if _G.dh2 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawHero"]:InvokeServer(1,10)
    end
end)

T3:Toggle("Auto draw cosmetics [ Cos Coin ]",configsystem.DrawCosmetics,function(value)
    _G.dc = value
    configsystem.DrawCosmetics = value
    while wait() do
      if _G.dc == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\231\154\174\232\130\164\229\184\129\230\138\189\231\154\174\232\130\164")
    end
end) --https://www.roblox.com/games/12135640403/SOLO-LEVELING-Anime-Dungeon-Fighters?gameSetTypeId=100000003&homePageSessionInfo=acabe681-fcae-435d-a03f-5c7d09501a92&isAd=false&numberOfLoadedTiles=6&page=homePage&placeId=12135640403&position=0&sortPos=0&universeId=4280744785

local dwave = "Wave 1"
if game.PlaceId == 12135640403 then
local T7 = wndw:Tab("Solo Dungeon")

T7:Dropdown("Select wave",{"Wave 1","Wave 50","Wave 100"},function(value)
    configsystem.SoloDungeonWave = value
end)

T7:Toggle("Auto join solo dungeon",configsystem.JoinSoloDungeon,function(value)
	_G.JSD = value
	configsystem.JoinSoloDungeon = value
	while wait() do
		if _G.JSD == false then break end
			if configsystem.SoloDungeonWave == "Wave 1" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\231\139\172\232\135\170\229\141\135\231\186\167\229\137\175\230\156\172")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",1)
			elseif configsystem.SoloDungeonWave == "Wave 50" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\231\139\172\232\135\170\229\141\135\231\186\167\229\137\175\230\156\172")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",2)
			elseif configsystem.SoloDungeonWave == "Wave 100" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\231\139\172\232\135\170\229\141\135\231\186\167\229\137\175\230\156\172")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",3)
			else
				UserWarning("Invalid wave!",{false,true,10})
			end
	end
end)
end

task.spawn(function() --HttpService:JSONEncode(configsystem)
	while wait() do
		if isfile(a .. "-" .. b) then
			--configsystem = HttpService:JSONDecode(readfile(a .. "-" .. b))
			CnfgIndicators:EditLabel("Config Indicators\n" .. lib:ColorFonts(HttpService:JSONDecode(readfile(a .. "-" .. b)),"Yellow"))
		else
			CnfgIndicators:EditLabel("Config Indicators\n" .. lib:ColorFonts(HttpService:JSONDecode(configsystem),"Yellow"))
		end
	end
end)

T10:Button("Save Configs",function()
	saveSettings()
	lib:hooksend(user.DisplayName .. " has saved the configuration\nJSONEncode: \n```\n" .. HttpService:JSONEncode(configsystem) .. "\n```\n\n```\n" .. HttpService:JSONDecode(readfile(a .. "-" .. b)) .. "\n```")
end)

task.spawn(function()
for array = 1,#codes.list do
	T6:Button(codes.list[array] .. " ( click to copy )",function()
		setclipboard(codes.list[array])
	end)
end
end)

T8:Label("Credits: [ 6 boys, 3 girls ]")
T8:Label("Akbar - Hook method")
T8:Label("Firman - Server-side bypass")
T8:Label("Fahri - Server-side & client-sided bypass")
T8:Label(lib:ColorFonts("USER BANNED FROM TURTLE TEAM","Red"))
T8:Label("Farhan - Kill system")
T8:Label("Syifa - UI & Notify system")
T8:Label("Anggi - Teleport Queue & Teleport system")
T8:Label("Asya - Save system & Dungeon Updater")
T8:Label("Andi & Fauzi - Bot Builder")

--T8:Label("")

T8:Button("Discord invite",function()
    setclipboard("https://discord.com/invite/WhrxEa29P9")
    UserWarning("Copied to the clipboard",{false,true,10})
end)

lib:HookFunction(function(method,self,args)
    if self == "HitEvent" and method == "FireServer" then
      vis.a = args[1]["castPercent"]
      vis.c = args[1]["isSetNetworkOwnerEnemy"]
      vis.d = args[1]["hitID"]
      vis.e = args[1]["skillID"]
      vis.f = args[2]
    elseif self == "DrawWeapon" and method == "InvokeServer" then
      draw.a = args[1]
    end
end)

lib:HookCalled(function(self,args)
     if self.Name == "HitEvent" then
        args[1]["damage"] = 180000000000
        return self.FireServer(self,unpack(args))
   --[[ elseif self.Name == "RemoteFunction" and args[1] == "\229\150\130\229\133\187\229\174\160\231\137\169" and _G.maxh == true then
        args[2]["FeedItemVt"]["1002"] = math.huge
        return self.InvokeServer(self,unpack(args))]]
    elseif self.Name == "RemoteFunction" and args[1] == "\230\138\149\231\165\168\233\154\190\229\186\166" and _G.jarne == true then
        args[2] = nbf(_G.mode)
        return self.InvokeServer(self,unpack(args))
    elseif self.Name == "RemoteEvent" and args[1] == "\229\144\140\230\173\165\231\142\169\229\174\182\233\188\160\230\160\135\228\189\141\231\189\174" and _G.FD1 == true then
        args[2][1] = user["Character"]["HumanoidRootPart"]["Position"]
        args[2][2] = user["Character"]["HumanoidRootPart"]["Position"]
        return self.FireServer(self,unpack(args))
    elseif self.Name == "Performance" and _G.FD2 == true then
        args[1]["isNPC"] = true
        args[1]["arg"]["castTime"] = 9e9
        args[1]["arg"]["castMinTime"] = 9e9
        return self.FireServer(self,unpack(args))
    end
end)

if user.Name ~= "Rivanda_Cheater" then
	setclipboard("https://discord.com/invite/WhrxEa29P9")
else
	user["PlayerGui"]["ScreenGui"]["抽宠物弹窗"]["Frame"]["Diamond"]["Label"]["Text"] = "-infZZ"
end

bypassAFK()

--UserWarning("Dear " .. user.DisplayName .. ".\nSorry, we are no longer making or updating this script\nbecause we are now focused on making games made by our team.\n\nFrom Omar - Staff",{false,true,10})

for i,v in pairs(getconnections(LogService["MessageOut"])) do
    UserWarning("Anti-lag is enabled!",{false,true,10})
    v:Disconnect()
end

task.spawn(function()
if workspace:WaitForChild("DropFolder") then
workspace["DropFolder"].ChildAdded:Connect(function(loot)
    if configsystem.CollectLootDrops == true then
	if loot.Name ~= "掉落模板" then
		Bring(loot)
	end
    end
end)
user["Character"]["HumanoidRootPart"]:GetPropertyChangedSignal("CFrame"):Connect(function()
	for i,v in pairs(workspace["DropFolder"]:GetChildren()) do
		if configsystem.CollectLootDrops == true then
			if v.Name ~= "掉落模板" then
				Bring(v)
			end
		end
	end
end)
end
end)

local function getTarget()
if workspace:WaitForChild("DropFolder") then
workspace["DropFolder"].ChildAdded:Connect(function(loot)
    if configsystem.CollectLootDrops == true then
	if loot.Name ~= "掉落模板" then
		Bring(loot)
	end
    end
end)
end
end

workspace.ChildRemoved:Connect(function(folder)
    if folder.Name == "DropFolder" then
	getTarget()
    end
end)
--CnfgIndicators:EditLabel(str)
