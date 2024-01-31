local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - powered by Turtle Team & Turtle Secure")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Server Manipulator")
local T3 = wndw:Tab("Draw")
local T4 = wndw:Tab("Join arena")

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

T4:Dropdown("Select arena",{"1_1","1_2","1_3","2_1","2_2","2_3"},function(value)
    _G.forlvl = value
end)

T4:Dropdown("Select mode",{"Easy","Normal","Hard","Hell"},function(value)
    _G.mode = value:gsub("Easy","1"):gsub("Normal","2"):gsub("Hard","3"):gsub("Hell","4") or 1
end)

T4:Button("Join ring/arena",function()
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",tonumber(_G.mode))
      game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180",_G.forlvl)
end)

T4:Button("Exit ring/arena",function()
    game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\233\128\128\229\135\186\231\187\132\233\152\159\230\136\191\233\151\180",_G.forlvl)
end)

T2:Button("Infinite Coins",function()
    game:GetService("ReplicatedStorage")["Msg"]["DrawWeapon"]:InvokeServer(7000003,-math.huge)
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

T3:Toggle("Draw weapon [ Draw before enabling this ]",false,function(value)
    _G.dw = value
    while wait() do
      if _G.dw == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawWeapon"]:InvokeServer(draw.a,1)
    end
end)

T3:Toggle("Auto draw hero",false,function(value)
    _G.dh = value
    while wait() do
      if _G.dh == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["DrawHero"]:InvokeServer(1,1)
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

lib:HookCalled(function(self,args)
     if self.Name == "HitEvent" then
        args[1]["damage"] = math.huge
        return self.FireServer(self,unpack(args))
    elseif self.Name == "RemoteFunction" and args[1] == "\229\150\130\229\133\187\229\174\160\231\137\169" and _G.maxh == true then
        args[2]["FeedItemVt"]["1002"] = math.huge
        return self.InvokeServer(self,unpack(args))
    elseif self.Name == "RemoteFunction" and args[1] == "\230\138\149\231\165\168\233\154\190\229\186\166" then
        game:GetService("ReplicatedStorage")["Msg"]["RemoteFunction"]:InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166",tonumber(_G.mode))
        return self.InvokeServer(self,unpack(args))
    end
end)
