local desiredGravity = 196
local gravityLockEnabled = true

game:GetService("RunService").Stepped:Connect(function()
    if gravityLockEnabled and workspace.Gravity ~= desiredGravity then
        workspace.Gravity = desiredGravity
    end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = Players.LocalPlayer
local placeId = game.PlaceId

local function getCharacter()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    return character, hrp, humanoid
end

local function createNotification(text)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.IgnoreGuiInset = true

    local Note = Instance.new("TextLabel")
    Note.Size = UDim2.new(0, 260, 0, 40)
    Note.Position = UDim2.new(0.5, -130, 0.1, -20)
    Note.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Note.TextColor3 = Color3.fromRGB(255, 255, 255)
    Note.Font = Enum.Font.GothamBold
    Note.TextScaled = true
    Note.Text = text
    Note.Parent = ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = Note

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 170, 255)
    stroke.Thickness = 2
    stroke.Parent = Note

    Note.BackgroundTransparency = 1
    Note.TextTransparency = 1
    for i = 1, 20 do
        Note.BackgroundTransparency = 1 - (i * 0.05)
        Note.TextTransparency = 1 - (i * 0.05)
        task.wait(0.02)
    end

    task.wait(3)

    for i = 1, 20 do
        Note.BackgroundTransparency = i * 0.05
        Note.TextTransparency = i * 0.05
        task.wait(0.02)
    end

    ScreenGui:Destroy()
end

createNotification("Made by Watzz")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CompactServerGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 200)
MainFrame.Position = UDim2.new(0.5, -140, 0.3, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 170, 255)
Stroke.Thickness = 2
Stroke.Parent = MainFrame

MainFrame.Active = true
MainFrame.Draggable = true

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 30, 0, 60)
OpenButton.Position = UDim2.new(0, 0, 0.5, -30)
OpenButton.Text = ">"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
OpenButton.Parent = ScreenGui
OpenButton.Visible = false

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 6)
OpenCorner.Parent = OpenButton

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CloseButton.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)

local GameThumbnail = Instance.new("ImageLabel")
GameThumbnail.Size = UDim2.new(0, 60, 0, 60)
GameThumbnail.Position = UDim2.new(0, 10, 0, 10)
GameThumbnail.BackgroundTransparency = 1
GameThumbnail.Parent = MainFrame

local GameTitle = Instance.new("TextLabel")
GameTitle.Size = UDim2.new(0, 200, 0, 30)
GameTitle.Position = UDim2.new(0, 80, 0, 10)
GameTitle.BackgroundTransparency = 1
GameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
GameTitle.TextScaled = true
GameTitle.Font = Enum.Font.GothamBold
GameTitle.Text = "Game Title"
GameTitle.Parent = MainFrame

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(0, 200, 0, 40)
InfoLabel.Position = UDim2.new(0, 80, 0, 50)
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.TextScaled = true
InfoLabel.TextWrapped = true
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "Ping: ...\nServer: ..."
InfoLabel.Parent = MainFrame

local success, info = pcall(function()
    return MarketplaceService:GetProductInfo(placeId, Enum.InfoType.Asset)
end)

if success and info then
    GameTitle.Text = info.Name
    GameThumbnail.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. info.AssetId .. "&width=150&height=150"
end

RunService.RenderStepped:Connect(function()
    local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
    local serverID = game.JobId:sub(1, 6)
    InfoLabel.Text = string.format("Ping: %d ms\nServer: %s", ping, serverID)
end)

local function MakeButton(text, xPos, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0, xPos, 0, yPos)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    btn.Parent = MainFrame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn

    return btn
end

local function startTelepadRebirth()
    if getgenv().MS_AUTO_RUNNING then
        warn("Auto Rebirth is already running")
        return
    end
    getgenv().MS_AUTO_RUNNING = true
    getgenv().Name = getgenv().Name or " "

    local SellThreshold = getgenv().SellThreshold or 30000
    local Depth = getgenv().Depth or 260
    local SellArea = CFrame.new(41.96064, 14, -1239.64648)
    local Collapse = false
    local ScriptIsBroken = false
    local Counter = 0
    local TeleportPos

    local virtual = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        virtual:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        virtual:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)

    repeat task.wait() until game:IsLoaded()
    LocalPlayer.PlayerGui:WaitForChild("ScreenGui")

    local screenGui = LocalPlayer.PlayerGui.ScreenGui

    pcall(function()
        screenGui.TeleporterFrame:Destroy()
    end)
    pcall(function()
        screenGui.StatsFrame.Sell:Destroy()
    end)
    pcall(function()
        screenGui.MainButtons.Surface:Destroy()
    end)

    local character, hrp, humanoid = getCharacter()
    pcall(function()
        character.Head.CustomPlayerTag.PlayerName.Text = getgenv().Name
        character.Head.CustomPlayerTag.MinerRank.Text = "Made By Watzz"
    end)

    local Data = getsenv(screenGui.ClientScript).displayCurrent
    local Values = getupvalue(Data, 8)
    local Remote = Values["RemoteEvent"]
    Data, Values = nil

    if not Remote then
        LocalPlayer:Kick("Failed to get RemoteEvent")
        return
    end

    pcall(function()
        Remote.OnClientEvent:Connect(function()
            return nil
        end)
    end)

    local function refreshCharacter()
        character, hrp, humanoid = getCharacter()
        return character, hrp, humanoid
    end

    local function split(s, delimiter)
        local result = {}
        for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
            table.insert(result, match)
        end
        return result
    end

    local function getDepthAmount()
        local depthLabel = screenGui:FindFirstChild("TopInfoFrame") and screenGui.TopInfoFrame:FindFirstChild("Depth")
        if not depthLabel then
            return 0
        end
        local pieces = split(depthLabel.Text, " ")
        return tonumber(pieces[1]) or 0
    end

    local CoinsAmount = LocalPlayer.leaderstats.Coins
    local function getCoinsAmount()
        local amount = tostring(CoinsAmount.Value):gsub(",", "")
        return tonumber(amount) or 0
    end

    local function getInventoryAmount()
        local amount
        pcall(function()
            amount = screenGui.StatsFrame2.Inventory.Amount.Text
        end)
        if not amount then
            pcall(function()
                amount = character.Backpack.Decore.Count.SurfaceGui.Amount.Text
            end)
        end
        amount = tostring(amount or "0"):gsub("%s+", ""):gsub(",", "")
        local inventory = amount:split("/")
        return tonumber(inventory[1]) or 0
    end

    local function setPlatformStand(state)
        refreshCharacter()
        humanoid.PlatformStand = state
        hrp.CanCollide = false
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

        for _, obj in ipairs(character:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.CanCollide = false
                obj.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                obj.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        end
    end

    local function hardSetCFrame(cframe, anchored)
        refreshCharacter()
        hrp.Anchored = true
        setPlatformStand(true)
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        hrp.CFrame = cframe
        RunService.Stepped:Wait()
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        hrp.Anchored = anchored == true
    end

    local function softSetCFrame(cframe)
        refreshCharacter()
        setPlatformStand(true)
        hrp.Anchored = false
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        hrp.CFrame = cframe
        RunService.Stepped:Wait()
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        hrp.Anchored = false
    end

    local function makeLavaBridge()
        if workspace:FindFirstChild("WatzzLavaBridge") then
            return
        end

        local part = Instance.new("Part")
        part.Name = "WatzzLavaBridge"
        part.Anchored = true
        part.Size = Vector3.new(10, 0.5, 100)
        part.Material = Enum.Material.ForceField
        part.Position = Vector3.new(21, 9.5, 26285)
        part.Parent = workspace
    end

    local function moveToLavaStart()
        refreshCharacter()
        gravityLockEnabled = false
        workspace.Gravity = 1000
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 0
        hrp.Anchored = true
        setPlatformStand(true)
        Remote:FireServer("MoveTo", {{"LavaSpawn"}})
        makeLavaBridge()
        task.wait(1)
        hrp.Anchored = false

        while hrp.Position.Z > 26220 do
            hardSetCFrame(CFrame.new(Vector3.new(hrp.Position.X, 13.05, hrp.Position.Z - 0.5)), false)
            task.wait()
        end

        hardSetCFrame(CFrame.new(18, 10, 26220), false)
        workspace.Gravity = desiredGravity
        gravityLockEnabled = true
    end

    local function digToDepth()
        refreshCharacter()
        local stepped = RunService.Stepped
        while getDepthAmount() < Depth and hrp.Position.Y > -2430 do
            local min = hrp.CFrame + Vector3.new(-1, -10, -1)
            local max = hrp.CFrame + Vector3.new(1, 0, 1)
            local region = Region3.new(min.Position, max.Position)
            local parts = workspace:FindPartsInRegion3WithWhiteList(region, {workspace.Blocks}, 5)
            for _, block in pairs(parts) do
                Remote:FireServer("MineBlock", {{block.Parent}})
                stepped:Wait()
            end
            task.wait()
        end
    end

    local function removePad()
        Remote:FireServer("RemovePad", {{}})
    end

    local function placeTelepadAt(position)
        refreshCharacter()
        hardSetCFrame(CFrame.new(position), true)
        removePad()
        task.wait(0.1)
        Remote:FireServer("PlaceTeleporter", {{position}})
        task.wait(0.25)
        Remote:FireServer("TeleportToPad", {{}})
        task.wait(0.25)
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        TeleportPos = hrp.Position
    end

    local function placeTelepadHere()
        refreshCharacter()
        task.wait(0.1)
        placeTelepadAt(hrp.CFrame.Position)
        task.wait(0.1)
    end

    local function returnToTelepad()
        refreshCharacter()
        hrp.Anchored = true
        setPlatformStand(true)
        for _ = 1, 30 do
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            Remote:FireServer("TeleportToPad", {{}})
            RunService.Stepped:Wait()
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            if TeleportPos and (hrp.Position - TeleportPos).Magnitude <= 6 then
                return true
            end
        end
        return false
    end

    local function findStartBlockPosition()
        for _, block in pairs(workspace.Blocks:GetChildren()) do
            local primary = block.PrimaryPart
            if primary and math.abs(primary.Position.Z - 26220) < 1 and math.abs(primary.Position.X - 18) < 2 then
                return primary.Position
            end
        end
        return Vector3.new(18, 10, 26220)
    end

    local function resetTelepadAtStart()
        placeTelepadAt(findStartBlockPosition())
    end

    local function fullDepthSetup()
        moveToLavaStart()
        digToDepth()
        placeTelepadHere()
    end

    fullDepthSetup()

    local RebirthsAmount = LocalPlayer.leaderstats.Rebirths
    local blocksMined = LocalPlayer.leaderstats:FindFirstChild("Blocks Mined")
    if blocksMined then
        blocksMined:GetPropertyChangedSignal("Value"):Connect(function()
            Counter = 0
        end)
    end

    workspace.Collapsed.Changed:Connect(function()
        if workspace.Collapsed.Value == true then
            Collapse = true
            setPlatformStand(false)
            refreshCharacter()
            hrp.Anchored = true
            task.wait(1)
            hrp.Anchored = false
            fullDepthSetup()
            Counter = 0
            Collapse = false
        end
    end)

    task.spawn(function()
        while getgenv().MS_AUTO_RUNNING do
            task.wait(1)
            Counter += 1
            if Counter >= 10 then
                if not Collapse and not ScriptIsBroken then
                    ScriptIsBroken = true
                    resetTelepadAtStart()
                    Counter = 0
                    ScriptIsBroken = false
                else
                    Counter = 0
                end
            end
        end
    end)

    local function rebirthLoop()
        setPlatformStand(true)
        while getgenv().MS_AUTO_RUNNING do
            refreshCharacter()
            if not Collapse and not ScriptIsBroken then
                local params = OverlapParams.new()
                params.FilterType = Enum.RaycastFilterType.Include
                params.FilterDescendantsInstances = {workspace.Blocks}

                local parts = workspace:GetPartBoundsInBox(hrp.CFrame, Vector3.new(10, 10, 10), params)
                if parts[1] then
                    for _, block in pairs(parts) do
                        if Collapse or ScriptIsBroken then
                            break
                        end

                        if block:IsA("BasePart") and block.Parent then
                            Remote:FireServer("MineBlock", {{block.Parent}})
                        end

                        if getInventoryAmount() >= SellThreshold then
                            while getInventoryAmount() >= SellThreshold and not Collapse and not ScriptIsBroken do
                                softSetCFrame(SellArea)
                                task.wait()
                                Remote:FireServer("SellItems", {{}})
                                task.wait()
                            end

                            while getCoinsAmount() >= (10000000 * (RebirthsAmount.Value + 1)) and not Collapse and not ScriptIsBroken do
                                Remote:FireServer("Rebirth", {{}})
                                task.wait()
                            end

                            if not returnToTelepad() then
                                resetTelepadAtStart()
                            end
                            setPlatformStand(true)
                        end

                        task.wait()
                    end
                else
                    if not Collapse and not ScriptIsBroken then
                        resetTelepadAtStart()
                    end
                end
            end

            RunService.Stepped:Wait()
        end
    end

    rebirthLoop()
end

local AutoRebirth = MakeButton("Auto Rebirth", 20, 100)
AutoRebirth.MouseButton1Click:Connect(function()
    task.spawn(startTelepadRebirth)
end)

local AutoMine = MakeButton("Auto Mine", 150, 100)
AutoMine.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ProdHallow/MiningSimMine/main/Mininsimmine"))()
end)

local DupeButton = MakeButton("Dupe", 20, 145)
DupeButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wiatrowkaa/MiningSimulator1/Public/DupeScriptGUI"))()
end)

local BoostFPS = MakeButton("Boost FPS", 150, 145)
BoostFPS.MouseButton1Click:Connect(function()
    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local CoreGui = game:GetService("CoreGui")

    if setfpscap then
        setfpscap(240)
    end

    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 1

    for _, effect in ipairs(Lighting:GetChildren()) do
        if effect:IsA("BloomEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("DepthOfFieldEffect") or effect:IsA("SunRaysEffect") or effect:IsA("BlurEffect") then
            effect.Enabled = false
        end
    end

    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 0
    end

    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
            obj.CastShadow = false
        elseif obj:IsA("Texture") or obj:IsA("Decal") then
            obj.Transparency = 1
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Explosion") then
            obj.Enabled = false
        elseif obj:IsA("MeshPart") then
            obj.TextureID = ""
            obj.Material = Enum.Material.SmoothPlastic
        end
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            for _, obj in pairs(player.Character:GetDescendants()) do
                if obj:IsA("Accessory") or obj:IsA("Hat") or obj:IsA("Clothing") then
                    obj:Destroy()
                elseif obj:IsA("Animator") then
                    obj:Destroy()
                end
            end
        end
    end

    for _, remote in pairs(ReplicatedStorage:GetChildren()) do
        if remote:IsA("RemoteEvent") then
            pcall(function()
                remote.OnClientEvent:Connect(function() end)
            end)
        end
    end

    for _, gui in pairs(CoreGui:GetDescendants()) do
        if gui:IsA("Frame") or gui:IsA("TextLabel") or gui:IsA("ImageLabel") then
            gui.Visible = false
        end
    end
end)
