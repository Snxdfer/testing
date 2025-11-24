-- KaterHub's FE Hamsterball Gui v0.2a
-- Original by w2pr, modificado por KaterHub

print("KaterHub's FE Hamsterball Gui")

local Players           = game:GetService("Players")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local HttpService       = game:GetService("HttpService")
local TeleportService   = game:GetService("TeleportService")
local workspace         = game.Workspace
local camera            = workspace.CurrentCamera
local queue_on_teleport = queue_on_teleport

local LocalPlayer = Players.LocalPlayer

local speedMultiplier = 25
local jumpPower       = 60
local gravity         = 100
local ballSize        = 5

local tc = nil
local jumprqst = nil
local freezeOnAFK = nil
local unfreezeFromAFK = nil
local lastvelocity = nil

local settings = {
    freezeOnAFK = false,
    ExecuteOnTp = true
}

-- Cargar UI Engine V2
local UiEngine = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaterHub-Inc/scripts/refs/heads/main/modules/UiEngineV2.lua"))()

local window = UiEngine:AddWindow("FE Hamsterball [Gui Version]", {
    main_color = Color3.fromRGB(50, 105, 168),
    min_size = Vector2.new(250, 350),
    toggle_key = Enum.KeyCode.RightControl,
    can_resize = false
})

local tab = window:AddTab("Main")
local miscTab = window:AddTab("Misc.")

local statusLabel = tab:AddLabel("currently: <font color=\"rgb(57, 255, 8)\">Normal</font>.")

-- Sliders
local speedSlider = tab:AddSlider("Speed Multiplier", function(v) speedMultiplier = v end, {min = 0, max = 100})
speedSlider:Set(25)

local jumpSlider = tab:AddSlider("Jump power", function(v) jumpPower = v end, {min = 0, max = 100})
jumpSlider:Set(60)

local gravitySlider = tab:AddSlider("Environment Gravity", function(v) workspace.Gravity = v end, {min = 0, max = 196})
gravitySlider:Set(100)

tab:AddButton("Set default", function()
    speedSlider:Set(25)
    jumpSlider:Set(60)
    gravitySlider:Set(100)
end)

tab:AddLabel("")

local afkSwitch = tab:AddSwitch("Pause on AFK", function(state)
    settings.freezeOnAFK = state
end)
afkSwitch:Set(settings.freezeOnAFK)

tab:AddKeybind("brake", function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    if hrp.Shape == Enum.PartType.Ball then
        hrp.RotVelocity = Vector3.new(0,0,0)
    end
end, {standard = Enum.KeyCode.R})

tab:AddKeybind("freeze", function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    if hrp.Shape == Enum.PartType.Ball then
        hrp.Anchored = not hrp.Anchored
    end
end, {standard = Enum.KeyCode.F})

local sizeSlider = tab:AddSlider("BallSize", function(v) ballSize = v end, {min = 5, max = 15})
sizeSlider:Set(0)

tab:AddHorizontalAlignment()

local enableBtn = tab:AddButton("Enable", function()
    if tc then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FE Hamsterball",
            Text = "already enabled!",
            Duration = 3
        })
        return
    end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FE Hamsterball",
            Text = "character not found?\nCustom Character model maybe?\ntry again",
            Duration = 5
        })
        return
    end

    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end

    local hrp = char.HumanoidRootPart
    hrp.Shape = Enum.PartType.Ball
    hrp.Size = Vector3.new(ballSize, ballSize, ballSize)

    local humanoid = char:WaitForChild("Humanoid")

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {char}

    -- RenderStepped (movimiento)
    tc = RunService.RenderStepped:Connect(function(dt)
        hrp.CanCollide = true
        humanoid.PlatformStand = true

        if UserInputService:GetFocusedTextBox() then return end

        local move = Vector3.new(0,0,0)
        local cam = workspace.CurrentCamera

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            hrp.RotVelocity = hrp.RotVelocity - cam.CFrame.RightVector * dt * speedMultiplier
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            hrp.RotVelocity = hrp.RotVelocity - cam.CFrame.LookVector * dt * speedMultiplier
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            hrp.RotVelocity = hrp.RotVelocity + cam.CFrame.RightVector * dt * speedMultiplier
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            hrp.RotVelocity = hrp.RotVelocity + cam.CFrame.LookVector * dt * speedMultiplier
        end
    end)

    -- Jump
    jumprqst = UserInputService.JumpRequest:Connect(function()
        local ray = workspace:Raycast(hrp.Position, Vector3.new(0, -(hrp.Size.Y/2 + jumpPower), 0), rayParams)
        if ray then
            hrp.Velocity = hrp.Velocity + Vector3.new(0, jumpPower, 0)
        end
    end)

    -- AFK Freeze
    unfreezeFromAFK = UserInputService.WindowFocusReleased:Connect(function()
        if not settings.freezeOnAFK then return end
        if char and hrp then
            lastvelocity = hrp.RotVelocity
            hrp.Anchored = true
            statusLabel:Update("currently: <font color=\"rgb(255, 110, 26)\">idle</font>!")
        end
    end)

    freezeOnAFK = UserInputService.WindowFocused:Connect(function()
        if lastvelocity and char and hrp then
            hrp.Anchored = false
            hrp.RotVelocity = lastvelocity
            statusLabel:Update("currently: <font color=\"rgb(145, 33, 250)\">Ball</font>.")
        end
    end)

    camera.CameraSubject = hrp
    humanoid.Died:Connect(function()
        if tc then tc:Disconnect() end
        if jumprqst then jumprqst:Disconnect() end
        if freezeOnAFK then freezeOnAFK:Disconnect() end
        if unfreezeFromAFK then unfreezeFromAFK:Disconnect() end

        if char and hrp then
            hrp.Anchored = false
            camera.CameraSubject = humanoid
        end

        tc = nil
        gravitySlider:Set(100)
        statusLabel:Update("currently: <font color=\"rgb(57, 255, 8)\">Normal</font>.")
    end)

    statusLabel:Update("currently: <font color=\"rgb(145, 33, 250)\">Ball</font>.")
end)

tab:AddButton("Disable", function()
    if not tc then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FE Hamsterball",
            Text = "already disabled!",
            Duration = 3
        })
        return
    end

    tc:Disconnect()
    jumprqst:Disconnect()
    freezeOnAFK:Disconnect()
    unfreezeFromAFK:Disconnect()

    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local hum = char:FindFirstChild("Humanoid")

        hrp.Anchored = false
        camera.CameraSubject = hum
        hrp.CanCollide = true
        hum.PlatformStand = false
        hrp.Shape = Enum.PartType.Block
        hrp.Size = hrp.OriginalSize.Value
    end

    tc = nil
    gravitySlider:Set(100)
    statusLabel:Update("currently: <font color=\"rgb(57, 255, 8)\">Normal</font>.")
end)

-- Misc Tab
miscTab:AddLabel("FE Hamsterball // version <font color=\"rgb(76, 148, 255)\">[0.2a]</font>.")
miscTab:AddLabel("<font color=\"rgb(37, 85, 124)\">(This is a modified version of the real script // @w2pr)</font>")

if setclipboard then
    miscTab:AddButton("community discord invite", function()
        setclipboard("discord.gg/kSBmA2qKEp")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FE Hamsterball",
            Text = "Check your clipboard!",
            Duration = 10
        })
    end)
else
    miscTab:AddLabel("<font color=\"rgb(8, 107, 255)\">discord.gg/kSBmA2qKEp</font>")
end

miscTab:AddLabel("")

if queue_on_teleport then
    local reexecSwitch = miscTab:AddSwitch("ReExecute on Serverhop", function(state)
        settings.ExecuteOnTp = state
    end)
    reexecSwitch:Set(settings.ExecuteOnTp)
end

miscTab:AddButton("Rejoin", function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "FE Hamsterball",
        Text = "Rejoining soon...",
        Duration = 10
    })

    if settings.ExecuteOnTp and queue_on_teleport then
        queue_on_teleport('loadstring(game:HttpGet("https://pastebin.com/raw/U0Hih6E4"))()')
    end

    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

tab:Show()
window:FormatWindows()
