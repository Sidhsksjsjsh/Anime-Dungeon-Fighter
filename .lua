local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - powered by Turtle Team & Turtle Secure")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Server Manipulator")
local T3 = wndw:Tab("Draw")
local T4 = wndw:Tab("Join arena")
local T5 = wndw:Tab("XRAY - TEST")
local workspace = game:GetService("Workspace")
local serverplayer = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local user = serverplayer.LocalPlayer
local vis = {
  a = 0,
  b = 0,
  c = false,
  d = 0,
  e = 0,
  f = ""
}
local draw = {
  a = 7000000
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

local function Bring(part)
	TweenService:Create(part,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{CFrame = user.Character.HumanoidRootPart.Position}):Play()
end

local function getPlayerESP()
  for i,v in pairs(serverplayer:GetPlayers()) do
    setESP(v["Character"])
  end
end

local function gfg(str)
  return str:gsub("Easy","1"):gsub("Normal","2"):gsub("Hard","3"):gsub("Hell","4")
end

local function nbf(gs)
  return tonumber(gfg(gs))
end

T4:Dropdown("Select arena",{"1_1","1_2","1_3","2_1","2_2","2_3"},function(value)
    _G.forlvl = value
end)

T4:Dropdown("Select mode",{"Easy","Normal","Hard","Hell"},function(value)
    _G.mode = value
end)

T4:Button("Join ring/arena",function()
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",nbf(_G.mode))
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180",_G.forlvl)
end)

T4:Button("Exit ring/arena",function()
    game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\128\128\229\135\186\231\187\132\233\152\159\230\136\191\233\151\180",_G.forlvl)
end)

T4:Toggle("Auto select mode [ choose mode first ]",false,function(value)
    _G.jarne = value
end)

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

T5:Button("Visual XRAY [ ENEMY ]",function()
    FindTarget()
end)

T5:Button("Visual XRAY [ PLAYER ]",function()
    getPlayerESP()
end)

T2:Button("Infinite Coins",function()
    game:GetService("ReplicatedStorage")["Msg"]["DrawWeapon"]:InvokeServer(7000003,-math.huge)
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

T1:Toggle("Auto kill V1 [ Hit the enemy first ]",false,function(value)
    _G.killv1 = value
    while wait() do
      if _G.killv1 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["HitEvent"]:FireServer({["castPercent"] = vis.a,["damage"] = vis.b,["isSetNetworkOwnerEnemy"] = vis.c,["hitID"] = vis.d,["skillID"] = vis.e},vis.f)
    end
end)

T1:Toggle("Auto level max hero [ Feed ]",false,function(value)
    _G.maxh = value
end)

T1:Toggle("Auto collect loot drops",false,function(value)
    _G.tfurteaw = value
    for i,v in pairs(workspace["DropFolder"]:GetChildren()) do
      Bring(v)
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

workspace["DropFolder"].ChildAdded:Connect(function(loot)
    if _G.tfurteaw == true then
      Bring(loot)
    end
end)
