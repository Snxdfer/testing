-- Singularity UI Library V2 (Edited by KaterHub)
-- Original: King Singularity @ V3rmillion
-- Discord: Singularity#5490

local library = { 
    version = 1.3,
    tween_time = 0.1,
    windows = {}
}

warn([[running on Library version // ]]..tostring(library.version)..[[

         _ _ ___
  __ __(_) ___ ____ ____ _(_)___ ___ _ _|__ \
 / / / / / / _ \/ __ \/ __ `/ / __ \/ _ \ | | / /_/ /
/ /_/ / / / __/ / / / /_/ / / / / / __/ | |/ / __/
\__,_/_/ \___/_/ /_/\__, /_/_/ /_/\___/ |___/____/
/____/
by Singularity (V3rm @ King Singularity) (Discord @ Singularity#5490)
[Edited version by KaterHub]
]])

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ui-engine-v2"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Enabled = false
ScreenGui:SetAttribute("dead", false)

local Prefabs = Instance.new("Frame")
Prefabs.Name = "Prefabs"
Prefabs.Parent = ScreenGui
Prefabs.BackgroundColor3 = Color3.new(1,1,1)
Prefabs.Size = UDim2.new(0,100,0,100)
Prefabs.Visible = false

local Windows = Instance.new("Folder")
Windows.Name = "Windows"
Windows.Parent = ScreenGui

local binding = false

UserInputService.InputBegan:Connect(function(key)
    if binding then return end
    local toggleKey = library.windows[1] and library.windows[1].toggle_key or Enum.KeyCode.RightShift
    if typeof(toggleKey) == "EnumItem" then
        if key.KeyCode == toggleKey then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    elseif key.KeyCode == Enum.KeyCode.RightShift then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

local function tween(obj, props, time)
    time = time or library.tween_time
    TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local function updateZIndex(window)
    for _, obj in ipairs(window:GetDescendants()) do
        if obj:IsA("GuiObject") then
            obj.ZIndex = obj.ZIndex + (window.ZIndex - 10)
        end
    end
end

function library:AddWindow(title, options)
    options = options or {}
    options.main_color = options.main_color or Color3.fromRGB(41,74,122)
    options.min_size = options.min_size or Vector2.new(400,300)
    options.toggle_key = options.toggle_key or Enum.KeyCode.RightShift
    options.can_resize = options.can_resize ~= false

    local windowName = "ui-engine-v2 // "..tostring(title or "Window")
    local existing = game:GetService("CoreGui"):FindFirstChild(windowName)
    if existing then
        existing:SetAttribute("dead", true)
        existing:Destroy()
    end

    local Window = Prefabs:FindFirstChild("Window"):Clone()
    Window.Name = windowName
    Window.Parent = Windows
    Window:SetAttribute("dead", false)

    local Title = Window:FindFirstChild("Title")
    Title.Text = title or "Window"

    Window.Size = UDim2.new(0, options.min_size.X, 0, options.min_size.Y)
    Window.ZIndex = #library.windows * 10 + 10

    local Resizer = Window:FindFirstChild("Resizer")
    local Bar = Window:FindFirstChild("Bar")
    local Toggle = Bar:FindFirstChild("Toggle")
    local Tabs = Window:FindFirstChild("Tabs")
    local TabSelection = Window:FindFirstChild("TabSelection")
    local TabButtons = TabSelection:FindFirstChild("TabButtons")

    -- Color update loop
    spawn(function()
        while wait() do
            if Window:GetAttribute("dead") then break end
            for _, v in ipairs(Window:GetDescendants()) do
                if v:IsA("ImageLabel") or v:IsA("ImageButton") then
                    v.ImageColor3 = options.main_color
                elseif v:IsA("Frame") and not v:FindFirstChild("Title") then
                    v.BackgroundColor3 = options.main_color
                end
            end
        end
    end)

    -- Dragging
    local dragging = false
    local dragStart, startPos
    Window.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.Position
        end
    end)
    Window.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    Window.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Resizing
    if options.can_resize then
        local resizing = false
        Resizer.MouseEnter:Connect(function()
            Resizer.BackgroundTransparency = 0.8
        end)
        Resizer.MouseLeave:Connect(function()
            Resizer.BackgroundTransparency = 1
        end)
        Resizer.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = true
                dragStart = input.Position
                startPos = Window.Size
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                local newSize = Vector2.new(math.max(options.min_size.X, startPos.X.Offset + delta.X), math.max(options.min_size.Y, startPos.Y.Offset + delta.Y))
                Window.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = false
            end
        end)
    end

    -- Toggle
    local open = true
    Toggle.MouseButton1Click:Connect(function()
        open = not open
        if open then
            tween(Window, {Size = UDim2.new(0, options.min_size.X, 0, options.min_size.Y)})
            tween(Toggle, {Rotation = 90})
        else
            tween(Window, {Size = UDim2.new(0, options.min_size.X, 0, 25)})
            tween(Toggle, {Rotation = 0})
        end
    end)

    local tabIndex = 0
    local tabs = {}

    local function selectTab(tab)
        for _, t in ipairs(tabs) do
            t.frame.Visible = false
        end
        tab.frame.Visible = true
        TabSelection.Visible = true
    end

    function Window:AddTab(name)
        tabIndex += 1
        local tab = {}
        local button = Prefabs:FindFirstChild("TabButton"):Clone()
        button.Parent = TabButtons
        button.Text = name
        button.ZIndex = Window.ZIndex + tabIndex
        button.Size = UDim2.new(0, button.TextBounds.X + 20, 0, 20)

        local content = Prefabs:FindFirstChild("Tab"):Clone()
        content.Parent = Windows
        content.Visible = false
        content.ZIndex = Window.ZIndex

        button.MouseButton1Click:Connect(function()
            selectTab(tab)
        end)

        if tabIndex == 1 then
            selectTab(tab)
        end

        local layout = Instance.new("UIListLayout")
        layout.Parent = content
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 5)

        local elements = {}

        function tab:AddLabel(text)
            local label = Prefabs:FindFirstChild("Label"):Clone()
            label.Parent = content
            label.Text = text
            label.ZIndex = Window.ZIndex + 100
            label.Size = UDim2.new(1, 0, 0, 20)
            return label
        end

        function tab:AddButton(text, callback)
            local button = Prefabs:FindFirstChild("Button"):Clone()
            button.Parent = content
            button.Text = text
            button.ZIndex = Window.ZIndex + 100
            button.MouseButton1Click:Connect(callback or function() end)
            return button
        end

        function tab:AddSwitch(text, callback, default)
            local switch = Prefabs:FindFirstChild("Switch"):Clone()
            switch.Parent = content
            switch.Title.Text = text
            switch.ZIndex = Window.ZIndex + 100
            local state = default or false
            switch.MouseButton1Click:Connect(function()
                state = not state
                if state then
                    switch.Text = "✓"
                else
                    switch.Text = ""
                end
                if callback then callback(state) end
            end)
            if state then switch.Text = "✓" end
            function switch:Set(value)
                state = value
                switch.Text = value and "✓" or ""
            end
            return switch
        end

        function tab:AddSlider(text, callback, options)
            options = options or {}
            options.min = options.min or 0
            options.max = options.max or 100
            local slider = Prefabs:FindFirstChild("Slider"):Clone()
            slider.Parent = content
            slider.Title.Text = text
            slider.ZIndex = Window.ZIndex + 100
            local value = options.min
            local dragging = false

            local function update(val)
                value = math.clamp(val, options.min, options.max)
                slider.Indicator.Size = UDim2.new(value / options.max, 0, 1, 0)
                slider.Value.Text = tostring(math.floor(value)) .. "%"
                if callback then callback(value) end
            end

            slider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local percent = (Mouse.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
                    update(percent * options.max)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            update(options.min)
            function slider:Set(val) update(val) end
            return slider
        end

        function tab:AddKeybind(text, callback, options)
            options = options or {}
            options.standard = options.standard or Enum.KeyCode.RightShift
            local keybind = Prefabs:FindFirstChild("Keybind"):Clone()
            keybind.Parent = content
            keybind.Title.Text = text
            keybind.ZIndex = Window.ZIndex + 100
            local current = options.standard

            local function setKey(key)
                current = key
                keybind.Input.Text = key.Name
            end

            keybind.Input.MouseButton1Click:Connect(function()
                keybind.Input.Text = "..."
                local conn
                conn = UserInputService.InputBegan:Connect(function(input)
                    setKey(input.KeyCode)
                    conn:Disconnect()
                end)
            end)

            UserInputService.InputBegan:Connect(function(input)
                if input.KeyCode == current then
                    if callback then callback() end
                end
            end)

            setKey(current)
            function keybind:SetKeybind(key) setKey(key) end
            return keybind
        end

        function tab:AddHorizontalAlignment()
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 0, 5)
            frame.BackgroundTransparency = 1
            frame.Parent = content
            local layout = Instance.new("UIListLayout")
            layout.FillDirection = Enum.FillDirection.Horizontal
            layout.Parent = frame
            layout.Padding = UDim.new(0, 5)
            return frame
        end

        tab.frame = content
        table.insert(tabs, tab)
        return tab
    end

    table.insert(library.windows, Window)
    return Window
end

return library
