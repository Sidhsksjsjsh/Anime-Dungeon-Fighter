local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - powered by Turtle Team & Turtle Secure")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Server Manipulator")
local T3 = wndw:Tab("Draw")
local T4 = wndw:Tab("Defense mode")
local T5 = wndw:Tab("XRAY - TEST")
local T6 = wndw:Tab("Codes list")

local workspace = game:GetService("Workspace")
local serverplayer = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local user = serverplayer.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local GC = getconnections or get_signal_cons
local VirtualUser = game:GetService("VirtualUser")

local vis = {
  a = 0,
  b = 30,
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
		"BOOSTGIFT"
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
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local rootPosition = rootPart.CFrame
    
    local bestNPC
    local maxDistance = 50 -- Change it to the maximum distance you want an NPC to be
    for _,model in next,npcsFolder:GetDescendants() do
        if model:IsA("Model") then
            local distance = (model.HumanoidRootPart.CFrame.Position - rootPosition).Magnitude
            if distance < maxDistance then
                --maxDistance = distance
                bestNPC = model.Name
            end
        end
    end
    
    return bestNPC
end

local function filterString(str)
	return str:gsub("Wave 1","1"):gsub("Wave 50","2"):gsub("Wave 100","3"):gsub("Wave 150","4"):gsub("Wave 200","5")
end

local wave = "Wave 1"
T4:Dropdown("Select wave",{"Wave 1","Wave 50","Wave 100","Wave 150","Wave 200"},function(value)
    wave = value
end)

T4:Toggle("Auto join defense mode ( World 1 & 2 )",false,function(value)
	_G.JDM = value
	while wait() do
		if _G.JDM == false then break end
			if wave == "Wave 1" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\229\161\148\233\152\178\230\168\161\229\188\143")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",1)
			elseif wave == "Wave 50" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\229\161\148\233\152\178\230\168\161\229\188\143")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",2)
			elseif wave == "Wave 100" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\229\161\148\233\152\178\230\168\161\229\188\143")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",3)
			elseif wave == "Wave 150" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\229\161\148\233\152\178\230\168\161\229\188\143")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",4)
			elseif wave == "Wave 200" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\229\161\148\233\152\178\230\168\161\229\188\143")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",5)
			else
				lib:WarnUser("Invalid wave!")
			end
	end
end)

T4:Toggle("Auto tp above the crystal",false,function(value)
	_G.tpac = value
	while wait() do
		if _G.tpac == false then break end
			for i,v in pairs(game:GetService("Workspace")["副本地图"]:GetDescendants()) do
				if v.Name == "碰撞" then
					tpabove(v)
				end
			end
	end
end)

--[[T4:Toggle("Auto tp above the crystal V2",false,function(value)
	_G.dvtst = value
	while wait() do
		if _G.dvtst == false then break end
			for i,v in pairs(game:GetService("Workspace")["副本地图"]:GetDescendants()) do
				if v.Name == "HumanoidRootPart" and v.Parent == "守护物" then
					tpabove(v)
				end
			end
	end
end)
]]

T5:Colorpicker("V-XRAY Color [ OUTLINE COLOR ] [ ENEMY ]",Color3.new(1,1,1),function(value)
    for i,v in pairs(workspace:GetDescendants()) do
      if v:FindFirstChild("XRAY") then
        v["XRAY"]["OutlineColor"] = value
      end
    end
end)

T5:Colorpicker("V-XRAY Color [ BOBY COLOR ] [ ENEMY ]",Color3.new(0,1,0),function(value)
    for i,v in pairs(workspace:GetDescendants()) do
      if v:FindFirstChild("XRAY") then
        v["XRAY"]["FillColor"] = value
      end
    end
end)

T5:Colorpicker("V-XRAY Color [ OUTLINE COLOR ] [ PLAYER ]",Color3.new(1,1,1),function(value)
    for i,v in pairs(serverplayer:GetPlayers()) do
      if v["Character"]:FindFirstChild("XRAY") then
        v["Character"]["XRAY"]["OutlineColor"] = value
      end
    end
end)

T5:Colorpicker("V-XRAY Color [ BOBY COLOR ] [ PLAYER ]",Color3.new(0,1,0),function(value)
    for i,v in pairs(serverplayer:GetPlayers()) do
      if v["Character"]:FindFirstChild("XRAY") then
        v["Character"]["XRAY"]["FillColor"] = value
      end
    end
end)

T5:Toggle("Enable V-XRAY",false,function(value)
    espHD = value
    FindTarget()
    getPlayerESP()
end)
--lib:ColorFonts(str,color)
T5:Button("Visual XRAY [ " .. lib:ColorFonts("ENEMY","Red") .. " ]",function()
    FindTarget()
end)

T5:Button("Visual XRAY [ " .. lib:ColorFonts("PLAYER","Green") .. " ]",function()
    getPlayerESP()
end)

T2:Button("Infinite Coins",function()
    game:GetService("ReplicatedStorage")["Msg"]["DrawWeapon"]:InvokeServer(7000003,math.huge)
end)

T2:Button("Infinite Gems - TEST",function()
    --game:GetService("ReplicatedStorage")["Msg"]["DrawFruit"]:InvokeServer(-math.huge)
    game:GetService("ReplicatedStorage")["Msg"]["DrawHero"]:InvokeServer(-math.huge,1)
    game:GetService("ReplicatedStorage")["Msg"]["DrawHero"]:InvokeServer(math.huge,1)
end)

T2:Button("Claim all Battle Pass reward",function()
    for array = 1,50 do
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\162\134\229\143\150\228\184\128\228\184\170\229\173\163\231\165\168\229\165\150\229\138\177",{["id"] = array,["isPay"] = false})
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\162\134\229\143\150\228\184\128\228\184\170\229\173\163\231\165\168\229\165\150\229\138\177",{["id"] = array,["isPay"] = true})
    end
end)

T2:Button(lib:ColorFonts("Bypass","Red") .. " cooldown",function()
    lib:WarnUser('This feature is currently under maintenance\nmaintenance will end from now until it is finished\n( 14:29 PM - finished ) ( Indonesian Timezone )')
end)

T2:Button("Get all fruits",function()
    lib:WarnUser('This feature is currently under maintenance\nmaintenance will end from now until it is finished\n( 14:29 PM - finished ) ( Indonesian Timezone )')
end)

T2:Button("Claim daily XP boost",function()
    game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\162\134\229\143\150\229\143\140\229\128\141\231\187\143\233\170\140")
end)

T1:Toggle("Auto " .. lib:ColorFonts("kill","Red") .. " V1 [ " .. lib:ColorFonts("Hit","Red") .. " the " .. lib:ColorFonts("enemy","Red") .. " first ]",false,function(value)
    _G.killv1 = value
    while wait() do
      if _G.killv1 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["HitEvent"]:FireServer({["castPercent"] = vis.a,["damage"] = vis.b,["isSetNetworkOwnerEnemy"] = vis.c,["hitID"] = vis.d,["skillID"] = vis.e},vis.f)
    end
end)

--[[if table.find({Enum.Platform.IOS,Enum.Platform.Android},UserInputService:GetPlatform()) then
T1:Toggle("Auto " .. lib:ColorFonts("kill","Red") .. " V2 [ Raycast ] [ " .. lib:ColorFonts("Hit","Red") .. " first ] [ Delay 1s ]",false,function(value)
    _G.killv2 = value
    while wait(1) do
      if _G.killv2 == false then break end
	for i,v in pairs(workspace["副本地图"]:GetDescendants()) do
		if v:IsA("Model") and v.Name ~= "Model" then
			game:GetService("ReplicatedStorage")["Msg"]["HitEvent"]:FireServer({["castPercent"] = vis.a,["damage"] = vis.b,["isSetNetworkOwnerEnemy"] = vis.c,["hitID"] = vis.d,["skillID"] = vis.e},v.Name)
		end
	end
    end
end)
else]]
T1:Toggle("Auto " .. lib:ColorFonts("kill","Red") .. " V2 [ Raycast ] [ " .. lib:ColorFonts("Hit","Red") .. " first ]",false,function(value)
    _G.killv2 = value
    while wait() do
      if _G.killv2 == false then break end
	for i,v in pairs(workspace["副本地图"]:GetDescendants()) do
		if v:IsA("Model") and v.Name ~= "Model" then
			game:GetService("ReplicatedStorage")["Msg"]["HitEvent"]:FireServer({["castPercent"] = vis.a,["damage"] = vis.b,["isSetNetworkOwnerEnemy"] = vis.c,["hitID"] = vis.d,["skillID"] = vis.e},v.Name)
		end
	end
    end
end)
--end

T1:Toggle("Auto " .. lib:ColorFonts("kill","Red") .. " V3 [ Nearest ] [ " .. lib:ColorFonts("Hit","Red") .. " first ] [ 50 ]",false,function(value)
    _G.killv3 = value
    while wait() do
      if _G.killv3 == false then break end
	local closestNPC = getNearestNPC(user["Character"],workspace["副本地图"])
		if closestNPC then
			game:GetService("ReplicatedStorage")["Msg"]["HitEvent"]:FireServer({["castPercent"] = vis.a,["damage"] = vis.b,["isSetNetworkOwnerEnemy"] = vis.c,["hitID"] = vis.d,["skillID"] = vis.e},closestNPC)
		end
    end
end)

T1:Toggle("Auto level max hero [ Feed ]",false,function(value)
    _G.maxh = value
end)

T1:Toggle("Auto collect loot drops",false,function(value)
    _G.tfurteaw = value
    for i,v in pairs(workspace["DropFolder"]:GetChildren()) do
	if v.Name ~= "掉落模板" then
		Bring(v)
	end
    end
end)

T1:Toggle("Auto tp above the crystal",false,function(value)
	_G.mails = value
	for array = 1,9e9 do
		if _G.mails == false then break end
		wait(0.5)
		game:GetService("ReplicatedStorage")["Msg"]["RemoteEvent"]:FireServer("\233\162\134\229\143\150\233\130\174\228\187\182\229\165\150\229\138\177",array)
	end
end)

if user.Name == "Rivanda_Cheater" then
T1:Toggle("Staff test feature [1] [ Akbar ]",false,function(value)
    _G.FD1 = value
end)

T1:Toggle("Staff test feature [2] [ Akbar ]",false,function(value)
    _G.FD2 = value
end)
end

T3:Toggle("Auto draw fruit [ X1 ]",false,function(value)
    _G.df = value
    while wait() do
      if _G.df == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawFruit"]:InvokeServer(1)
    end
end)

T3:Toggle("Auto draw fruit [ X10 ]",false,function(value)
    _G.dfn = value
    while wait() do
      if _G.dfn == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawFruit"]:InvokeServer(10)
    end
end)

T3:Toggle("Draw weapon [ Draw before enabling this ] [ X1 ]",false,function(value)
    _G.dw1 = value
    while wait() do
      if _G.dw1 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawWeapon"]:InvokeServer(draw.a,1)
    end
end)

T3:Toggle("Draw weapon [ Draw before enabling this ] [ X3 ]",false,function(value)
    _G.dw2 = value
    while wait() do
      if _G.dw2 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawWeapon"]:InvokeServer(draw.a,3)
    end
end)

T3:Toggle("Draw hero [ X1 ] [ World 1 ]",false,function(value)
    _G.dh1 = value
    while wait() do
      if _G.dh1 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawHero"]:InvokeServer(1,1)
    end
end)

T3:Toggle("Draw hero [ X10 ] [ World 1 ]",false,function(value)
    _G.dh2 = value
    while wait() do
      if _G.dh2 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawHero"]:InvokeServer(1,10)
    end
end)

T3:Toggle("Draw hero [ X1 ] [ World 2 ]",false,function(value)
    _G.dh3 = value
    while wait() do
      if _G.dh3 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawHero"]:InvokeServer(2,1)
    end
end)

T3:Toggle("Draw hero [ X10 ] [ World 2 ]",false,function(value)
    _G.dh4 = value
    while wait() do
      if _G.dh4 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawHero"]:InvokeServer(2,10)
    end
end)

T3:Toggle("Auto draw cosmetics [ Cos Coin ]",false,function(value)
    _G.dc = value
    while wait() do
      if _G.dc == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\231\154\174\232\130\164\229\184\129\230\138\189\231\154\174\232\130\164")
    end
end) --https://www.roblox.com/games/12135640403/SOLO-LEVELING-Anime-Dungeon-Fighters?gameSetTypeId=100000003&homePageSessionInfo=acabe681-fcae-435d-a03f-5c7d09501a92&isAd=false&numberOfLoadedTiles=6&page=homePage&placeId=12135640403&position=0&sortPos=0&universeId=4280744785

game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",1)

local dwave = "Wave 1"
if game.PlaceId == 12135640403 then
local T7 = wndw:Tab("Solo Dungeon")

T7:Dropdown("Select wave",{"Wave 1","Wave 50","Wave 100"},function(value)
    dwave = value
end)

T7:Toggle("Auto join solo dungeon",false,function(value)
	_G.JSD = value
	while wait() do
		if _G.JSD == false then break end
			if wave == "Wave 1" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\231\139\172\232\135\170\229\141\135\231\186\167\229\137\175\230\156\172")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",1)
			elseif wave == "Wave 50" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\231\139\172\232\135\170\229\141\135\231\186\167\229\137\175\230\156\172")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",2)
			elseif wave == "Wave 100" then
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180","\231\139\172\232\135\170\229\141\135\231\186\167\229\137\175\230\156\172")
				game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",3)
			else
				lib:WarnUser("Invalid wave!")
			end
	end
end)
end

task.spawn(function()
for array = 1,#codes.list do
	T6:Button(codes.list[array] .. " ( click to copy )",function()
		setclipboard(codes.list[array])
	end)
end
end)

lib:HookFunction(function(method,self,args)
    if self == "HitEvent" and method == "FireServer" then
      vis.a = args[1]["castPercent"]
      vis.b = args[1]["damage"]
      vis.c = args[1]["isSetNetworkOwnerEnemy"]
      vis.d = args[1]["hitID"]
      vis.e = args[1]["skillID"]
      vis.f = args[2]
    elseif self == "DrawWeapon" and method == "InvokeServer" then
      draw.a = args[1]
    end
end)

--[[local args = {
    [1] = "\229\144\140\230\173\165\231\142\169\229\174\182\233\188\160\230\160\135\228\189\141\231\189\174",
    [2] = {
        [1] = CFrame.new(30.441062927246094, 23.52494239807129, 260.5985107421875, 0.6233587861061096, -0.17701369524002075, 0.7616364359855652, 4.41700898079489e-10, 0.9740394353866577, 0.22637875378131866, -0.78193598985672, -0.1411151885986328, 0.6071760058403015),
        [2] = CFrame.new(63.006187438964844, 33.20424270629883, 286.5592956542969, 0.9873019456863403, -0.06899712979793549, 0.14308865368366241, 4.804313391559845e-09, 0.900749146938324, 0.43433982133865356, -0.15885517001152039, -0.4288245439529419, 0.8893113136291504)
    }
}

game:GetService("ReplicatedStorage")["Msg"]["RemoteEvent"]:FireServer(unpack(args))

local args = {
    [1] = {
        ["eventId"] = 1,
        ["modelName"] = "KeyEvent",
        ["isNPC"] = false,
        ["skillName"] = "\231\136\177\228\185\139\232\131\189\229\138\155-\231\136\177\230\132\143\229\176\129\233\148\129",
        ["arg"] = {
            ["humanoid"] = game:GetService("Players").LocalPlayer.Character.Humanoid,
            ["Caster"] = workspace["Rivanda_Cheater"],
            ["castTime"] = 0,
            ["humanoidRootPart"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
            ["character"] = workspace["Rivanda_Cheater"],
            ["hitBox"] = {
                [1] = getNil("HitBox", "Part"),
                [2] = getNil("HitBox", "Part"),
                [3] = getNil("HitBox", "Part"),
                [4] = getNil("HitBox", "Part"),
                [5] = getNil("HitBox", "Part"),
                [6] = getNil("HitBox", "Part"),
                [7] = getNil("HitBox", "Part"),
                [8] = getNil("HitBox", "Part"),
                [9] = getNil("HitBox", "Part"),
                [10] = getNil("HitBox", "Part"),
                [11] = getNil("HitBox", "Part"),
                [12] = getNil("HitBox", "Part")
            },
            ["player"] = game:GetService("Players").LocalPlayer,
            ["handle"] = game:GetService("Players").LocalPlayer.Character.RightHand,
            ["Releaser"] = game:GetService("Players").LocalPlayer,
            ["animator"] = game:GetService("Players").LocalPlayer.Character.Humanoid.Animator,
            ["AtkedEnemy"] = {
                [1] = "27283",
                [2] = "27284",
                [3] = "27285",
                [4] = "27301",
                [5] = "27302"
            },
            ["castMinTime"] = 0,
            ["animationPlayer"] = {
                ["PlayNPCName"] = function PlayNPCName() end -- Function Called: PlayNPCName,
                ["StopName"] = function StopName() end -- Function Called: StopName,
                ["Stop"] = function Stop() end -- Function Called: Stop,
                ["Play"] = function Play() end -- Function Called: Play
            }
        },
        ["nowIndex"] = 3,
        ["skillId"] = "15070303"
    }
}

game:GetService("ReplicatedStorage")["Msg"]["Performance"]:FireServer(unpack(args))

local args = {
    [1] = "\229\144\140\230\173\165\231\142\169\229\174\182\233\188\160\230\160\135\228\189\141\231\189\174",
    [2] = {
        [1] = CFrame.new(30.441062927246094, 23.52494239807129, 260.5985107421875, 0.6233587861061096, -0.17701369524002075, 0.7616364359855652, 4.41700898079489e-10, 0.9740394353866577, 0.22637875378131866, -0.78193598985672, -0.1411151885986328, 0.6071760058403015),
        [2] = CFrame.new(63.006187438964844, 33.20424270629883, 286.5592956542969, 0.9873019456863403, -0.06899712979793549, 0.14308865368366241, 4.804313391559845e-09, 0.900749146938324, 0.43433982133865356, -0.15885517001152039, -0.4288245439529419, 0.8893113136291504)
    }
}

game:GetService("ReplicatedStorage")["Msg"]["RemoteEvent"]:FireServer(unpack(args))
]]

lib:HookCalled(function(self,args)
     if self.Name == "HitEvent" then
        args[1]["damage"] = math.huge
        --args[1]["phsic"]["Power"] = math.huge
        --args[1]["phsic"]["Time"] = 0
        return self.FireServer(self,unpack(args))
    elseif self.Name == "RemoteFunction" and args[1] == "\229\150\130\229\133\187\229\174\160\231\137\169" and _G.maxh == true then
        args[2]["FeedItemVt"]["1002"] = math.huge
        return self.InvokeServer(self,unpack(args))
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

lib:WarnUser("dm me on discord if u found any " .. lib:ColorFonts("bugs","Red") .. ".\nmy discord: fahriii._\nhttps://discord.com/invite/FHrVDCUv (Copied)")
if user.Name ~= "Rivanda_Cheater" then
	setclipboard("https://discord.com/invite/FHrVDCUv")
end

bypassAFK()

task.spawn(function()
if workspace:WaitForChild("DropFolder") then
workspace["DropFolder"].ChildAdded:Connect(function(loot)
    if _G.tfurteaw == true then
	if v.Name ~= "掉落模板" then
		Bring(loot)
	end
    end
end)
user["Character"]["HumanoidRootPart"]:GetPropertyChangedSignal("CFrame"):Connect(function()
	for i,v in pairs(workspace["DropFolder"]:GetChildren()) do
		if v.Name ~= "掉落模板" then
			Bring(v)
		end
	end
end)
end
end)
