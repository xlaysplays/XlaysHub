-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeianRussell/Kavo-UI-Library/main/Movable.source.lua"))()
local Window = Library.CreateLib("Xlays's Hub", "Midnight")

-- Home Tab
local HomeTab = Window:NewTab("Home")
local HomeSection = HomeTab:NewSection("Welcome")
local player = game.Players.LocalPlayer

HomeSection:NewLabel("Welcome, " .. player.Name .. "!")
HomeSection:NewLabel("Game ID: " .. game.PlaceId)
HomeSection:NewLabel("UserID: " .. player.UserId)

-- Player Tab
local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Player Tools")

PlayerSection:NewSlider("WalkSpeed", "Change WalkSpeed", 100, 16, function(value)
    player.Character.Humanoid.WalkSpeed = value
end)

PlayerSection:NewSlider("JumpPower", "Change JumpPower", 150, 50, function(value)
    player.Character.Humanoid.JumpPower = value
end)

PlayerSection:NewToggle("Fly (Basic)", "Toggles Fly", function(state)
    if state then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zackdoesstuff/ROBLOX-Fly-Script/main/Fly%20Script"))()
    end
end)

-- Combat Tab
local CombatTab = Window:NewTab("Combat")
local CombatSection = CombatTab:NewSection("Fighting Tools")

CombatSection:NewButton("Expand Hitbox", "Makes your hitbox larger", function()
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.Size = Vector3.new(10, 10, 10)
    end
end)

CombatSection:NewButton("God Mode (FE)", "Try to become invincible", function()
    local hum = player.Character:FindFirstChild("Humanoid")
    if hum then
        hum.Name = "1"
        local newHum = hum:Clone()
        newHum.Name = "Humanoid"
        newHum.Parent = player.Character
        task.wait()
        player.Character["1"]:Destroy()
        workspace.CurrentCamera.CameraSubject = player.Character
    end
end)

-- Scripts Tab
local ScriptsTab = Window:NewTab("Scripts")
local ScriptsSection = ScriptsTab:NewSection("FE Scripts")

ScriptsSection:NewButton("Infinite Yield", "Loads Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

ScriptsSection:NewButton("ESP (Highlight)", "See players through walls", function()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local highlight = Instance.new("Highlight", plr.Character)
            highlight.FillColor = Color3.new(1, 0, 0)
            highlight.OutlineColor = Color3.new(1, 1, 1)
        end
    end
end)

ScriptsSection:NewButton("TP Tool", "Teleport where you click", function()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "TP Tool"
    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local pos = mouse.Hit.Position
        player.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
    end)
    tool.Parent = player.Backpack
end)

-- Game Scripts Tab
local GameScriptsTab = Window:NewTab("Game Scripts")
local GameScripts = GameScriptsTab:NewSection("Detected Scripts")

local gameScriptsList = {
    [8737602449] = {name = "DOORS", script = "https://raw.githubusercontent.com/LOLking123456/doors-script/main/doors"}, -- DOORS
    [286090429] = {name = "Arsenal", script = "https://pastebin.com/raw/xR8qmF6N"}, -- Arsenal
    [4924922222] = {name = "Brookhaven", script = "https://pastebin.com/raw/YuDJE7Vb"}, -- Brookhaven
}

local current = game.PlaceId
if gameScriptsList[current] then
    local data = gameScriptsList[current]
    GameScripts:NewButton("Run " .. data.name .. " Script", "Executes script for this game", function()
        loadstring(game:HttpGet(data.script))()
    end)
else
    GameScripts:NewLabel("No script found for this game.")
end

GameScripts:NewButton("Teleport to DOORS", "Go to DOORS", function()
    game:GetService("TeleportService"):Teleport(8737602449)
end)
GameScripts:NewButton("Teleport to Arsenal", "Go to Arsenal", function()
    game:GetService("TeleportService"):Teleport(286090429)
end)
GameScripts:NewButton("Teleport to Brookhaven", "Go to Brookhaven", function()
    game:GetService("TeleportService"):Teleport(4924922222)
end)

-- FE Animations Tab
local AnimTab = Window:NewTab("FE Animations")
local AnimSection = AnimTab:NewSection("Play Animations")

local function playAnimation(id)
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. id
    local hum = player.Character:FindFirstChild("Humanoid")
    if hum then
        hum:LoadAnimation(anim):Play()
    end
end

AnimSection:NewButton("Dance", "Plays a dance animation", function()
    playAnimation(507771019)
end)

AnimSection:NewButton("Zombie", "Plays a zombie animation", function()
    playAnimation(616006778)
end)

AnimSection:NewButton("Backflip", "Plays backflip", function()
    playAnimation(507770239)
end)

AnimSection:NewButton("Lean", "Leans like a cool kid", function()
    playAnimation(507776043)
end)

-- Fun Stuff Tab
local FunTab = Window:NewTab("Fun Stuff")
local FunSection = FunTab:NewSection("Funny & Fun")

FunSection:NewButton("Invisible Chair", "Sit on air", function()
    local seat = Instance.new("Seat")
    seat.Anchored = true
    seat.CanCollide = false
    seat.Transparency = 1
    seat.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0)
    seat.Parent = workspace
    player.Character:MoveTo(seat.Position)
end)

FunSection:NewButton("Sit Spam", "Rapidly sit & unsit", function()
    local hum = player.Character:FindFirstChild("Humanoid")
    for i = 1, 10 do
        hum.Sit = true
        task.wait(0.2)
        hum.Sit = false
        task.wait(0.2)
    end
end)

FunSection:NewButton("Clone Follower", "Clone follows you", function()
    local clone = player.Character:Clone()
    clone.Parent = workspace
    clone.Name = "Follower"
    for _, v in ipairs(clone:GetDescendants()) do
        if v:IsA("BasePart") then v.Anchored = false end
    end
    game:GetService("RunService").Heartbeat:Connect(function()
        if clone and player.Character then
            clone:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame * CFrame.new(3, 0, 0))
        end
    end)
end)

FunSection:NewButton("Fling Clone", "Clone spins fast", function()
    local clone = player.Character:Clone()
    clone.Parent = workspace
    clone.Name = "FlingClone"
    clone:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame + Vector3.new(5, 0, 0))
    local bv = Instance.new("BodyAngularVelocity", clone.PrimaryPart)
    bv.AngularVelocity = Vector3.new(0, 50, 0)
    bv.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bv.P = math.huge
end)

FunSection:NewButton("Loop Sit", "Keeps sitting", function()
    while true do
        player.Character.Humanoid.Sit = true
        task.wait(0.5)
    end
end)

-- Settings Tab
local SettingsTab = Window:NewTab("Settings")
local SettingsSection = SettingsTab:NewSection("UI Settings")

SettingsSection:NewKeybind("Toggle UI", "Show/Hide UI", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

SettingsSection:NewButton("Destroy UI", "Completely remove the UI", function()
    for _,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "Kavo" then
            v:Destroy()
        end
    end
end)

