local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - powered by Turtle Team & Turtle Secure")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Server Manipulator")
local T3 = wndw:Tab("Draw")
local T4 = wndw:Tab("Join arena")
local T5 = wndw:Tab("XRAY - TEST")
local workspace = game:GetService("Workspace")
local serverplayer = game:GetService("Players")

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
    game:GetService("ReplicatedStorage")["Msg"]["DrawFruit"]:InvokeServer(-math.huge)
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

T1:Toggle("Dont enable this feature",false,function(value)
    _G.tfurteaw = value
end)

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

local args = {
    [1] = "\230\139\190\229\143\150\231\137\169\229\147\129",
    [2] = {
        [1] = 1,
        [2] = 1,
        [3] = "36211883078399"
    }
}

game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer(unpack(args))

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
    elseif self.Name == "RemoteFunction" and args[1] == "\230\139\190\229\143\150\231\137\169\229\147\129" and args[2][1] == 1 and _G.tfurteaw == true then
         args[2][2] = math.huge
         return self.InvokeServer(self,unpack(args))
    elseif self.Name == "RemoteFunction" and args[1] == "\230\139\190\229\143\150\231\137\169\229\147\129" and args[2][2] == 1 and _G.tfurteaw == true then
         args[2][1] = math.huge
         return self.InvokeServer(self,unpack(args))
    elseif self.Name == "RemoteFunction" and args[1] == "\230\139\190\229\143\150\231\137\169\229\147\129" and args[2][1] == 1 and args[2][2] == 1 and _G.tfurteaw == true then
         args[2][1] = math.huge
         args[2][2] = math.huge
         return self.InvokeServer(self,unpack(args))
    end
end)
