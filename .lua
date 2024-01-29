local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - TESTING GAME SCRIPT")
local T1 = wndw:Tab("Main")

local vis = {
  a = 0,
  b = 0,
  c = false,
  d = 0,
  e = 0,
  f = ""
}

T1:Toggle("Auto kill V1",false,function(value)
    _G.killv1 = value
    while wait() do
      if _G.killv1 == false then break end
      game:GetService("ReplicatedStorage")["Msg"]["HitEvent"]:FireServer({["castPercent"] = vis.a,["damage"] = vis.b,["isSetNetworkOwnerEnemy"] = vis.c,["hitID"] = vis.d,["skillID"] = vis.e},vis.f)
    end
end)

T1:Toggle("Auto kill V2",false,function(value)
    _G.killv2 = value
end)

lib:HookFunction(function(method,self,args)
    if self == "HitEvent" and method == "FireServer" then
      vis.a = args[1]["castPercent"]
      vis.b = args[1]["damage"]
      vis.c = args[1]["isSetNetworkOwnerEnemy"]
      vis.d = args[1]["hitID"]
      vis.e = args[1]["skillID"]
      vis.f = args[2]
    end
end)

lib:HookCalled(function(self,args)
     if self.Name == "HitEvent" and _G.killv2 == true then
        args[1]["damage"] = 9e9
        return self.FireServer(self,unpack(args))
    end
end)
