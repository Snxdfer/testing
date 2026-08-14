--[[
⣿⣿⣿⣿⡿⠟⠛⠋⠉⠉⠉⠉⠉⠛⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⠟⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠈⠙⠾⣿⣾⣿⣾⣿⣾⣿⣾⣿
@ Nurysium UI Library (Fixed & Improved)
]]

local ContextActionService = cloneref(game:GetService('ContextActionService'))
local UserInputService    = cloneref(game:GetService('UserInputService'))
local TweenService        = cloneref(game:GetService('TweenService'))
local HttpService         = cloneref(game:GetService('HttpService'))
local RunService          = cloneref(game:GetService('RunService'))
local Players             = cloneref(game:GetService('Players'))
local Debris              = cloneref(game:GetService('Debris'))

local LocalPlayer = Players.LocalPlayer

local Connections = {}

local function abandonConnections()
    for _, connection in pairs(Connections) do
        if typeof(connection) == 'RBXScriptConnection' then
            connection:Disconnect()
        end
    end
    table.clear(Connections)
end

local Library = {
    scale_cooldown    = false :: boolean,
    open              = true  :: boolean,
    flags             = {}    :: any,
    ui                = nil   :: any,
    scale             = 0,
    current_tab       = nil,
    mobile            = table.find({
        Enum.Platform.IOS,
        Enum.Platform.Android
    }, UserInputService:GetPlatform()),
    disconnected      = false :: boolean,
    can_be_optimized  = false :: boolean,
}

-- ─── ConfigsController ──────────────────────────────────────────────────────

local ConfigsController = {}

function ConfigsController.save(file_name: string, config: any)
    if not isfolder('Nurysium') then makefolder('Nurysium') end
    if not isfolder('Nurysium/configs') then makefolder('Nurysium/configs') end

    local ok, encoded = pcall(HttpService.JSONEncode, HttpService, config)
    if not ok then return end

    writefile(`Nurysium/configs/{file_name}.json`, encoded)
end

function ConfigsController.load(file_name: string, default_config: any): any
    local path = 'Nurysium/configs/' .. file_name .. '.json'

    if not isfile(path) then
        ConfigsController.save(file_name, default_config)
        return default_config or {}
    end

    local raw = readfile(path)
    if not raw or raw == '' then
        ConfigsController.save(file_name, default_config)
        return default_config or {}
    end

    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, raw)
    if not ok then
        ConfigsController.save(file_name, default_config)
        return default_config or {}
    end

    return decoded
end

Library.flags = ConfigsController.load(game.GameId, {})

-- ─── UIManager ──────────────────────────────────────────────────────────────

local UIManager = {}

function UIManager.refresh_tabs(Tab: TextButton)
    TweenService:Create(Tab, TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0,
    }):Play()

    local tabTitle = Tab:FindFirstChild('Title')
    local tabIcon  = Tab:FindFirstChild('Icon')

    if tabTitle then
        TweenService:Create(tabTitle, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
            TextTransparency = 0,
        }):Play()
    end
    if tabIcon then
        TweenService:Create(tabIcon, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
            ImageTransparency = 0,
        }):Play()
    end

    for _, object in Library.ui.Background.Tabs:GetChildren() do
        if object:IsA('TextButton') and object ~= Tab then
            TweenService:Create(object, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1,
            }):Play()

            if object:FindFirstChild('Title') then
                TweenService:Create(object.Title, TweenInfo.new(0.85, Enum.EasingStyle.Exponential), {
                    TextTransparency = 0.8,
                }):Play()
            end
            if object:FindFirstChild('Icon') then
                TweenService:Create(object.Icon, TweenInfo.new(0.85, Enum.EasingStyle.Exponential), {
                    ImageTransparency = 0.8,
                }):Play()
            end
        end
    end
end

function UIManager.refresh_sections(right_section: ScrollingFrame, left_section: ScrollingFrame)
    for _, object in Library.ui.Background.Sections:GetChildren() do
        if object == left_section or object == right_section then
            object.Visible = true
            continue
        end
        object.Visible = false
    end
end

function UIManager.animate_sections(right_section: ScrollingFrame, left_section: ScrollingFrame)
    local right_layout = right_section:FindFirstChildOfClass('UIListLayout')
    local left_layout  = left_section:FindFirstChildOfClass('UIListLayout')

    if not right_layout or not left_layout then return end

    right_layout.Padding = UDim.new(0, -6)
    left_layout.Padding  = UDim.new(0, -6)

    TweenService:Create(right_layout, TweenInfo.new(0.4, Enum.EasingStyle.Back), { Padding = UDim.new(0, 6) }):Play()
    TweenService:Create(left_layout,  TweenInfo.new(0.4, Enum.EasingStyle.Back), { Padding = UDim.new(0, 6) }):Play()
end

-- ─── Library helpers ────────────────────────────────────────────────────────

function Library.get_screen_scale()
    if Library.disconnected then return end

    local vp = workspace.CurrentCamera.ViewportSize
    local size = (vp.X + vp.Y) / (Library.mobile and 7000 or 2200)

    Library.scale = size + math.max(0.65 - size, 0)
end

function Library:onDestroyed(callback: () -> ())
    Library.ui.AncestryChanged:Once(callback)
end

function Library.normalize_size()
    Library.scale_cooldown = true

    if not Library.disconnected then
        task.spawn(function()
            local bg = Library.ui and Library.ui:FindFirstChild('Background')
            local icon = bg and bg:FindFirstChild('DisconnectIcon')
            if not icon then return end

            TweenService:Create(icon, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                ImageTransparency = 1,
                Rotation = 180,
            }):Play()
        end)
    end

    if not Library.open then
        Library.scale = 0.01

        TweenService:Create(Library.ui.Background.UIScale,
            TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
            Scale = Library.scale,
        }):Play()

        task.delay(0.6, function() Library.ui.Enabled = false end)
        task.delay(1,   function() Library.scale_cooldown = false end)
        return
    end

    Library.get_screen_scale()

    TweenService:Create(Library.ui.Background.UIScale,
        TweenInfo.new(0.95, Enum.EasingStyle.Back), {
        Scale = Library.scale,
    }):Play()

    Library.ui.Enabled = true
    task.delay(1, function() Library.scale_cooldown = false end)
end

UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessed: boolean)
    if Library.disconnected  then return end
    if input.KeyCode ~= Enum.KeyCode.Insert then return end
    if Library.scale_cooldown then return end
    if gameProcessed then return end

    Library.open             = not Library.open
    Library.can_be_optimized = not Library.open
    Library.normalize_size()
end)

-- ─── Library:create() ───────────────────────────────────────────────────────

function Library:create()
    local old_ui = self.parent:FindFirstChild(self.name)
    if old_ui then Debris:AddItem(old_ui, 0) end

    local Nurysium   = Instance.new('ScreenGui')
    local Background = Instance.new('Frame')
    local UICorner   = Instance.new('UICorner')
    local UIScale    = Instance.new('UIScale')
    local Tabs       = Instance.new('ScrollingFrame')
    local TabsLayout = Instance.new('UIListLayout')

    local optimized_folder = Instance.new('Folder')
    optimized_folder.Name   = 'Optimized'
    optimized_folder.Parent = Nurysium

    local Sections_folder   = Instance.new('Folder')

    Nurysium.Name           = self.name
    Nurysium.Parent         = self.parent
    Nurysium.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Background.Name                 = 'Background'
    Background.Parent               = Nurysium
    Background.Active               = true
    Background.AnchorPoint          = Vector2.new(0.5, 0.5)
    Background.BackgroundColor3     = Color3.fromRGB(13, 13, 13)
    Background.BackgroundTransparency = 0.015
    Background.BorderSizePixel      = 0
    Background.Position             = UDim2.new(0.5, 0, 0.5, 0)
    Background.Size                 = UDim2.new(0, 640, 0, 355)

    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent       = Background

    UIScale.Parent = Background
    UIScale.Scale  = 0.01

    Tabs.Name                    = 'Tabs'
    Tabs.Parent                  = Background
    Tabs.Active                  = true
    Tabs.AnchorPoint             = Vector2.new(0.5, 0.5)
    Tabs.BackgroundTransparency  = 1
    Tabs.BorderSizePixel         = 0
    Tabs.Position                = UDim2.new(0.132933617, 0, 0.498037577, 0)
    Tabs.Size                    = UDim2.new(0, 138, 0, 308)
    Tabs.ScrollBarImageColor3    = Color3.fromRGB(0, 0, 0)
    Tabs.BottomImage             = ''
    Tabs.MidImage                = ''
    Tabs.ScrollBarThickness      = 0
    Tabs.TopImage                = ''
    Tabs.CanvasSize              = UDim2.new(0, 0, 0, 0)
    Tabs.AutomaticCanvasSize     = Enum.AutomaticSize.Y

    TabsLayout.Parent              = Tabs
    TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsLayout.SortOrder           = Enum.SortOrder.LayoutOrder
    TabsLayout.Padding             = UDim.new(0, 6)

    Sections_folder.Name   = 'Sections'
    Sections_folder.Parent = Background

    Library.ui = Nurysium

    local DisconnectIcon       = Instance.new('ImageLabel')
    local DisconnectIcon_Scale = Instance.new('UIScale')

    DisconnectIcon.Name                 = 'DisconnectIcon'
    DisconnectIcon.Parent               = Background
    DisconnectIcon.AnchorPoint          = Vector2.new(0.5, 0.5)
    DisconnectIcon.BackgroundTransparency = 1
    DisconnectIcon.BorderSizePixel      = 0
    DisconnectIcon.Position             = UDim2.new(0.5, 0, 0.498278558, 0)
    DisconnectIcon.Rotation             = 180
    DisconnectIcon.Size                 = UDim2.new(0, 50, 0, 50)
    DisconnectIcon.Image                = 'rbxassetid://102151842256737'
    DisconnectIcon.ImageTransparency    = 1

    DisconnectIcon_Scale.Parent = DisconnectIcon

    local Safemode        = Instance.new('TextButton')
    local SafemodeTitle   = Instance.new('TextLabel')
    local Safemode_Corner = Instance.new('UICorner')

    Safemode.Name                 = 'Safemode'
    Safemode.Parent               = Background
    Safemode.BackgroundColor3     = Color3.fromRGB(13, 13, 13)
    Safemode.BackgroundTransparency = 0.015
    Safemode.BorderSizePixel      = 0
    Safemode.Position             = UDim2.new(0.391105562, 0, 1.04384315, 0)
    Safemode.Size                 = UDim2.new(0, 138, 0, 27)
    Safemode.Text                 = ''
    Safemode.TextSize             = 1
    Safemode.TextTransparency     = 1
    Safemode.TextWrapped          = true

    SafemodeTitle.Name               = 'Title'
    SafemodeTitle.Parent             = Safemode
    SafemodeTitle.BackgroundTransparency = 1
    SafemodeTitle.BorderSizePixel    = 0
    SafemodeTitle.Position           = UDim2.new(0.229, 0, 0.278, 0)
    SafemodeTitle.Size               = UDim2.new(0, 75, 0, 12)
    SafemodeTitle.FontFace           = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold)
    SafemodeTitle.Text               = 'Safe Mode'
    SafemodeTitle.TextColor3         = Color3.fromRGB(255, 255, 255)
    SafemodeTitle.TextScaled         = true
    SafemodeTitle.TextWrapped        = true

    Safemode_Corner.CornerRadius = UDim.new(0, 6)
    Safemode_Corner.Parent       = Safemode

    local function animateIcon(transparency: number, rotation: number, style: Enum.EasingStyle)
        TweenService:Create(DisconnectIcon,
            TweenInfo.new(0.45, style, Enum.EasingDirection.InOut), {
            ImageTransparency = transparency,
            Rotation          = rotation,
        }):Play()
    end

    local function triggerSafemode()
        if Library.disconnected then return end
        Library.disconnected = true

        animateIcon(1, 90, Enum.EasingStyle.Exponential)

        task.delay(0.35, function()
            DisconnectIcon.Image = 'rbxassetid://121830702067948'
            animateIcon(0.8, 360, Enum.EasingStyle.Back)
        end)

        TweenService:Create(DisconnectIcon_Scale,
            TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
            Scale = 1.5,
        }):Play()

        task.delay(2, function()
            TweenService:Create(DisconnectIcon_Scale,
                TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                Scale = 0.5,
            }):Play()
            animateIcon(1, 180, Enum.EasingStyle.Exponential)
        end)

        task.delay(2, function()
            Library.open = not Library.open
            Library.normalize_size()

            task.delay(1, function()
                Debris:AddItem(Nurysium, 0)
                abandonConnections()
            end)
        end)
    end

    Safemode.MouseEnter:Connect(function()
        if Library.disconnected then return end
        animateIcon(0.5, 0, Enum.EasingStyle.Exponential)
    end)

    Safemode.MouseLeave:Connect(function()
        if Library.disconnected then return end
        animateIcon(1, 180, Enum.EasingStyle.Back)
    end)

    Safemode.MouseButton1Click:Connect(triggerSafemode)
    Safemode.TouchTap:Connect(triggerSafemode)

    Library:onDestroyed(function()
        table.clear(Library.flags)
        abandonConnections()
        Library.disconnected = true
    end)

    Library.normalize_size()

    Connections['ui_render'] = workspace.CurrentCamera
        :GetPropertyChangedSignal('ViewportSize')
        :Connect(Library.normalize_size)

    -- ── Mobile toggle button ────────────────────────────────────────────────

    if Library.mobile then
        local MobileUI     = Instance.new('ScreenGui')
        local MobileFrame  = Instance.new('Frame')
        local MobileButton = Instance.new('TextButton')
        local MobileCorner = Instance.new('UICorner')
        local MobileIcon   = Instance.new('ImageLabel')
        local MobileScale  = Instance.new('UIScale')

        MobileUI.Name           = 'MobileUI'
        MobileUI.Parent         = Nurysium
        MobileUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        MobileFrame.Name                 = 'Mobile'
        MobileFrame.Parent               = MobileUI
        MobileFrame.AnchorPoint          = Vector2.new(0.5, 0.5)
        MobileFrame.BackgroundTransparency = 1
        MobileFrame.BorderSizePixel      = 0
        MobileFrame.Position             = UDim2.new(0.0620736592, 0, 0.926020384, 0)
        MobileFrame.Size                 = UDim2.new(0, 85, 0, 45)

        MobileButton.Name               = 'MobileButton'
        MobileButton.Parent             = MobileFrame
        MobileButton.BackgroundColor3   = Color3.fromRGB(13, 13, 13)
        MobileButton.BackgroundTransparency = 0.015
        MobileButton.BorderSizePixel    = 0
        MobileButton.Position           = UDim2.new(0.243122876, 0, 0.171316162, 0)
        MobileButton.Size               = UDim2.new(0, 43, 0, 28)
        MobileButton.Text               = ''

        MobileCorner.CornerRadius = UDim.new(0, 6)
        MobileCorner.Parent       = MobileButton

        MobileIcon.Name                 = 'Icon'
        MobileIcon.Parent               = MobileButton
        MobileIcon.BackgroundTransparency = 1
        MobileIcon.BorderSizePixel      = 0
        MobileIcon.Position             = UDim2.new(0.303248554, 0, 0.214285716, 0)
        MobileIcon.Size                 = UDim2.new(0, 15, 0, 15)
        MobileIcon.Image                = 'rbxassetid://134992015790041'

        MobileScale.Parent = MobileFrame
        MobileScale.Scale  = 1.34

        MobileButton.TouchTap:Connect(function()
            Library.open             = not Library.open
            Library.can_be_optimized = not Library.open
            Library.normalize_size()
        end)
    end

    -- ── TabsController ─────────────────────────────────────────────────────

    local TabsController = {}

    function TabsController.create_tab(text: string, image: string)
        local Tab       = Instance.new('TextButton')
        local TabTitle  = Instance.new('TextLabel')
        local TabCorner = Instance.new('UICorner')
        local TabIcon   = Instance.new('ImageLabel')

        Tab.AutoButtonColor   = false
        Tab.Name              = tostring(math.random())
        Tab.Parent            = Library.ui.Background.Tabs
        Tab.BackgroundColor3  = Color3.fromRGB(21, 21, 21)
        Tab.BackgroundTransparency = 1
        Tab.BorderSizePixel   = 0
        Tab.Position          = UDim2.new(0.0241379309, 0, 0, 0)
        Tab.Size              = UDim2.new(0, 138, 0, 27)
        Tab.Text              = ''
        Tab.TextSize          = 1
        Tab.TextWrapped       = true

        local Right       = Instance.new('ScrollingFrame')
        local RightLayout = Instance.new('UIListLayout')
        local Left        = Instance.new('ScrollingFrame')
        local LeftLayout  = Instance.new('UIListLayout')

        local function makeSection(name: string, xPos: number): ScrollingFrame
            local s = Instance.new('ScrollingFrame')
            s.Name                   = name
            s.Parent                 = Library.ui.Background.Sections
            s.Active                 = true
            s.AnchorPoint            = Vector2.new(0.5, 0.5)
            s.BackgroundTransparency = 1
            s.BorderSizePixel        = 0
            s.Position               = UDim2.new(xPos, 0, 0.497150093, 0)
            s.Size                   = UDim2.new(0, 208, 0, 308)
            s.ScrollBarImageColor3   = Color3.fromRGB(0, 0, 0)
            s.BottomImage            = ''
            s.MidImage               = ''
            s.ScrollBarThickness     = 0
            s.TopImage               = ''
            s.CanvasSize             = UDim2.new(0, 0, 0, 0)
            s.AutomaticCanvasSize    = Enum.AutomaticSize.Y
            s.Visible                = false
            return s
        end

        Right = makeSection('Right', 0.794181466)
        Left  = makeSection('Left',  0.44886893)

        RightLayout.Parent              = Right
        RightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        RightLayout.SortOrder           = Enum.SortOrder.LayoutOrder
        RightLayout.Padding             = UDim.new(0, 6)

        LeftLayout.Parent               = Left
        LeftLayout.HorizontalAlignment  = Enum.HorizontalAlignment.Center
        LeftLayout.SortOrder            = Enum.SortOrder.LayoutOrder
        LeftLayout.Padding              = UDim.new(0, 6)

        local function onTabSelected()
            if Library.current_tab == Tab.Name then return end
            Library.current_tab = Tab.Name
            UIManager.refresh_tabs(Tab)
            UIManager.refresh_sections(Right, Left)
            UIManager.animate_sections(Right, Left)
        end

        Tab.MouseButton1Up:Connect(onTabSelected)
        Tab.TouchTap:Connect(onTabSelected)

        TabTitle.Name                = 'Title'
        TabTitle.Parent              = Tab
        TabTitle.BackgroundTransparency = 1
        TabTitle.BorderSizePixel     = 0
        TabTitle.Position            = UDim2.new(0.3375673, 0, 0.277778059, 0)
        TabTitle.Size                = UDim2.new(0, 75, 0, 12)
        TabTitle.FontFace            = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold)
        TabTitle.Text                = text
        TabTitle.TextColor3          = Color3.fromRGB(255, 255, 255)
        TabTitle.TextScaled          = true
        TabTitle.TextTransparency    = 0.8
        TabTitle.TextWrapped         = true
        TabTitle.TextXAlignment      = Enum.TextXAlignment.Left

        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent       = Tab

        TabIcon.Name                 = 'Icon'
        TabIcon.Parent               = Tab
        TabIcon.BackgroundTransparency = 1
        TabIcon.BorderSizePixel      = 0
        TabIcon.ImageTransparency    = 0.8
        TabIcon.Position             = UDim2.new(0.1, 0, 0.222222224, 0)
        TabIcon.Size                 = UDim2.new(0, 15, 0, 15)
        TabIcon.Image                = image

        -- ── ModuleController ───────────────────────────────────────────────

        local ModuleController = {}

        -- FIX: 'callback' ahora es opcional. El script principal llama
        -- create_module({text, flag, side}) sin pasar ningún callback,
        -- lo que antes causaba "attempt to call a nil value" en update_module.
        function ModuleController:create_module(callback: ((boolean) -> ())?)
            local Module       = Instance.new('Frame')
            local ModCorner    = Instance.new('UICorner')
            local ModTab       = Instance.new('TextButton')
            local ModTitle     = Instance.new('TextLabel')
            local ModCorner2   = Instance.new('UICorner')
            local SizeFixer    = Instance.new('Frame')

            Module.Name             = 'Module'
            Module.Parent           = (self.side == 'right' and Right or Left)
            Module.Active           = true
            Module.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            Module.BorderSizePixel  = 0
            Module.Size             = UDim2.new(0, 188, 0, 26)
            Module.AutomaticSize    = Enum.AutomaticSize.Y

            ModCorner.CornerRadius = UDim.new(0, 6)
            ModCorner.Parent       = Module

            ModTab.Name             = 'Tab'
            ModTab.Parent           = Module
            ModTab.BackgroundColor3 = Color3.fromRGB(18, 17, 17)
            ModTab.BorderSizePixel  = 0
            ModTab.Size             = UDim2.new(0, 188, 0, 26)
            ModTab.AutoButtonColor  = false
            ModTab.Text             = ''
            ModTab.TextSize         = 1
            ModTab.TextTransparency = 1
            ModTab.TextWrapped      = true

            ModTitle.Name                = 'Title'
            ModTitle.Parent              = ModTab
            ModTitle.BackgroundTransparency = 1
            ModTitle.BorderSizePixel     = 0
            ModTitle.Position            = UDim2.new(0.0716098249, 0, 0.277777791, 0)
            ModTitle.Size                = UDim2.new(0, 140, 0, 12)
            ModTitle.FontFace            = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold)
            ModTitle.Text                = self.text
            ModTitle.TextColor3          = Color3.fromRGB(255, 255, 255)
            ModTitle.TextScaled          = true
            ModTitle.TextWrapped         = true
            ModTitle.TextXAlignment      = Enum.TextXAlignment.Left
            ModTitle.TextTransparency    = 0.7

            ModCorner2.CornerRadius = UDim.new(0, 6)
            ModCorner2.Parent       = ModTab

            local Settings     = Instance.new('Frame')
            local SetCorner    = Instance.new('UICorner')
            local SetLayout    = Instance.new('UIListLayout')
            local SetPadding   = Instance.new('UIPadding')

            Settings.Name                = 'Settings'
            Settings.Parent              = Module
            Settings.Active              = true
            Settings.BackgroundColor3    = Color3.fromRGB(15, 15, 15)
            Settings.BackgroundTransparency = 0.35
            Settings.BorderSizePixel     = 0
            Settings.Size                = UDim2.new(0, 188, 0, 0)
            Settings.ZIndex              = 0
            Settings.AutomaticSize       = Enum.AutomaticSize.Y

            SetCorner.CornerRadius = UDim.new(0, 6)
            SetCorner.Parent       = Settings

            SetLayout.Parent              = Settings
            SetLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            SetLayout.SortOrder           = Enum.SortOrder.LayoutOrder
            SetLayout.Padding             = UDim.new(0, 6)

            SetPadding.Parent     = Settings
            SetPadding.PaddingTop = UDim.new(0, 31)

            SizeFixer.Parent              = Settings
            SizeFixer.LayoutOrder         = 2147483647
            SizeFixer.Size                = UDim2.new(0, 0, 0, 0)
            SizeFixer.BackgroundTransparency = 1

            local function update_module(toggle: boolean)
                if toggle then
                    Library.flags[self.flag] = not Library.flags[self.flag]
                end

                -- FIX #PRINCIPAL: guard antes de invocar callback.
                -- El script principal crea módulos sin pasar callback,
                -- causaba "attempt to call a nil value" en esta línea.
                if callback then
                    callback(Library.flags[self.flag])
                end

                if Library.flags[self.flag] then
                    TweenService:Create(ModTab, TweenInfo.new(1.2, Enum.EasingStyle.Exponential), {
                        BackgroundColor3 = Color3.fromRGB(51, 51, 51),
                    }):Play()
                    TweenService:Create(ModTitle, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                        TextTransparency = 0,
                    }):Play()
                else
                    TweenService:Create(ModTab, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                        BackgroundColor3 = Color3.fromRGB(18, 17, 17),
                    }):Play()
                    TweenService:Create(ModTitle, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                        TextTransparency = 0.7,
                    }):Play()
                end
            end

            if not Library.flags[self.flag] then
                Library.flags[self.flag] = false
            else
                update_module(false)
            end

            local function onModuleClick()
                update_module(true)
                ConfigsController.save(game.GameId, Library.flags)
            end

            ModTab.MouseButton1Click:Connect(onModuleClick)
            ModTab.TouchTap:Connect(onModuleClick)

            -- ── SettingsController ─────────────────────────────────────────

            local SettingsController = {}

            function SettingsController:create_toggle()
                local Toggle       = Instance.new('TextButton')
                local ToggleTitle  = Instance.new('TextLabel')
                local ToggleCorner = Instance.new('UICorner')
                local ToggleFrame  = Instance.new('Frame')
                local ToggleCorner2 = Instance.new('UICorner')

                Toggle.Name              = 'Toggle'
                Toggle.Parent            = Settings
                Toggle.BackgroundColor3  = Color3.fromRGB(24, 24, 24)
                Toggle.BackgroundTransparency = 1
                Toggle.BorderSizePixel   = 0
                Toggle.Size              = UDim2.new(0, 174, 0, 20)
                Toggle.AutoButtonColor   = false
                Toggle.Text              = ''
                Toggle.TextSize          = 1
                Toggle.TextTransparency  = 1
                Toggle.TextWrapped       = true

                ToggleTitle.Name                = 'Title'
                ToggleTitle.Parent              = Toggle
                ToggleTitle.BackgroundTransparency = 1
                ToggleTitle.BorderSizePixel     = 0
                ToggleTitle.Position            = UDim2.new(0.0400152095, 0, 0.1277771, 0)
                ToggleTitle.Size                = UDim2.new(0, 120, 0, 14)
                ToggleTitle.FontFace            = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Medium)
                ToggleTitle.Text                = self.title
                ToggleTitle.TextColor3          = Color3.fromRGB(255, 255, 255)
                ToggleTitle.TextSize            = 13
                ToggleTitle.TextTransparency    = 0.6
                ToggleTitle.TextWrapped         = true
                ToggleTitle.TextXAlignment      = Enum.TextXAlignment.Left

                ToggleCorner.CornerRadius = UDim.new(0, 6)
                ToggleCorner.Parent       = Toggle

                ToggleFrame.Name                 = 'ToggleFrame'
                ToggleFrame.Parent               = Toggle
                ToggleFrame.Active               = true
                ToggleFrame.BackgroundColor3     = Color3.fromRGB(14, 14, 14)
                ToggleFrame.BackgroundTransparency = 0.45
                ToggleFrame.BorderSizePixel      = 0
                ToggleFrame.Position             = UDim2.new(0.879999995, 0, 0.16, 0)
                ToggleFrame.Selectable           = true
                ToggleFrame.Size                 = UDim2.new(0, 14, 0, 14)

                ToggleCorner2.CornerRadius = UDim.new(0, 6)
                ToggleCorner2.Parent       = ToggleFrame

                local function update_toggle(switch: boolean)
                    if switch then
                        Library.flags[self.flag] = not Library.flags[self.flag]
                    end

                    if Library.flags[self.flag] then
                        TweenService:Create(ToggleTitle,  TweenInfo.new(0.5, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
                        TweenService:Create(Toggle,       TweenInfo.new(1,   Enum.EasingStyle.Exponential), { BackgroundTransparency = 0.3 }):Play()
                        TweenService:Create(ToggleFrame,  TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {
                            BackgroundTransparency = 0,
                            BackgroundColor3       = Color3.fromRGB(29, 29, 29),
                        }):Play()
                    else
                        TweenService:Create(ToggleTitle,  TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { TextTransparency = 0.6 }):Play()
                        TweenService:Create(Toggle,       TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
                        TweenService:Create(ToggleFrame,  TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                            BackgroundTransparency = 0.45,
                            BackgroundColor3       = Color3.fromRGB(14, 14, 14),
                        }):Play()
                    end
                end

                if not Library.flags[self.flag] then
                    Library.flags[self.flag] = false
                else
                    update_toggle(false)
                end

                local function onToggleClick()
                    update_toggle(true)
                    ConfigsController.save(game.GameId, Library.flags)
                end

                Toggle.MouseButton1Click:Connect(onToggleClick)
                Toggle.TouchTap:Connect(onToggleClick)
            end

            function SettingsController:create_slider()
                local Slider       = Instance.new('Frame')
                local SliderCorner = Instance.new('UICorner')
                local ValueLabel   = Instance.new('TextLabel')
                local Dragger      = Instance.new('TextButton')
                local Hitbox       = Instance.new('TextButton')
                local DraggerCorner = Instance.new('UICorner')
                local SliderTitle  = Instance.new('TextLabel')

                local min_val = self.min or 0
                local max_val = self.max or 100

                Slider.Name            = 'Slider'
                Slider.Parent          = Settings
                Slider.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
                Slider.BorderSizePixel = 0
                Slider.Size            = UDim2.new(0, 165, 0, 10)

                SliderCorner.CornerRadius = UDim.new(0, 6)
                SliderCorner.Parent       = Slider

                ValueLabel.Name                = 'Value'
                ValueLabel.Parent              = Slider
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.BorderSizePixel     = 0
                ValueLabel.Position            = UDim2.new(0.380386621, 0, 0, 0.5)
                ValueLabel.Size                = UDim2.new(0, 40, 0, 10)
                ValueLabel.ZIndex              = 2
                ValueLabel.FontFace            = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold)
                ValueLabel.Text                = tostring(self.value)
                ValueLabel.TextColor3          = Color3.fromRGB(255, 255, 255)
                ValueLabel.TextSize            = 8
                ValueLabel.TextWrapped         = true

                Hitbox.Name              = 'Hitbox'
                Hitbox.Parent            = Slider
                Hitbox.Active            = false
                Hitbox.BackgroundTransparency = 1
                Hitbox.BorderSizePixel   = 0
                Hitbox.Selectable        = false
                Hitbox.ZIndex            = 2
                Hitbox.Size              = UDim2.new(1, 0, 0, 10)
                Hitbox.Text              = ''

                local initial_ratio = math.clamp((self.value - min_val) / (max_val - min_val), 0, 1)

                Dragger.Name             = 'Dragger'
                Dragger.Parent           = Slider
                Dragger.Active           = false
                Dragger.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Dragger.BorderSizePixel  = 0
                Dragger.Selectable       = false
                Dragger.Size             = UDim2.new(initial_ratio, 0, 0, 10)
                Dragger.Text             = ''

                DraggerCorner.CornerRadius = UDim.new(0, 6)
                DraggerCorner.Parent       = Dragger

                SliderTitle.Name                = 'Title'
                SliderTitle.Parent              = Settings
                SliderTitle.BackgroundTransparency = 1
                SliderTitle.BorderSizePixel     = 0
                SliderTitle.Size                = UDim2.new(0, 162, 0, 8)
                SliderTitle.ZIndex              = 3
                SliderTitle.FontFace            = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Medium)
                SliderTitle.Text                = self.title
                SliderTitle.TextColor3          = Color3.fromRGB(255, 255, 255)
                SliderTitle.TextScaled          = true
                SliderTitle.TextTransparency    = 0.66
                SliderTitle.TextWrapped         = true

                if not Library.flags[self.flag] then
                    Library.flags[self.flag] = self.value
                else
                    local saved = Library.flags[self.flag]
                    local ratio = math.clamp((saved - min_val) / (max_val - min_val), 0, 1)
                    ValueLabel.Text = tostring(saved)
                    Dragger.Size    = UDim2.new(ratio, 0, 0, 10)
                end

                local function update_slider()
                    local mouseX = UserInputService:GetMouseLocation().X
                    local output = math.clamp(
                        (mouseX - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X,
                        0, 1
                    )
                    local value = math.round(output * (max_val - min_val) + min_val)

                    Library.flags[self.flag] = value
                    ValueLabel.Text          = tostring(value)

                    TweenService:Create(Dragger, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                        Size = UDim2.new(output, 0, 0, 10),
                    }):Play()

                    if self.callback then
                        self.callback(value)
                    end

                    ConfigsController.save(game.GameId, Library.flags)
                end

                local slider_active = false

                local function activate_slider()
                    slider_active = true
                    while slider_active and not Library.disconnected do
                        update_slider()
                        task.wait()
                    end
                    slider_active = false
                end

                Hitbox.MouseButton1Down:Connect(activate_slider)
                Hitbox.TouchLongPress:Connect(activate_slider)

                UserInputService.InputEnded:Connect(function(input: InputObject)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                        slider_active = false
                    end
                end)
            end

            function SettingsController:create_dropdown(callback: ((string) -> ())?)
                local Dropdown    = Instance.new('Frame')
                local DDCorner    = Instance.new('UICorner')
                local ScrollFrame = Instance.new('ScrollingFrame')
                local ScrollLayout = Instance.new('UIListLayout')
                local ScrollPad   = Instance.new('UIPadding')
                local DDTitle     = Instance.new('TextLabel')

                Dropdown.Name            = 'Dropdown'
                Dropdown.Parent          = Settings
                Dropdown.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
                Dropdown.BorderSizePixel = 0
                Dropdown.Size            = UDim2.new(0, 165, 0, 80)

                DDCorner.CornerRadius = UDim.new(0, 6)
                DDCorner.Parent       = Dropdown

                ScrollFrame.Parent                = Dropdown
                ScrollFrame.Active                = true
                ScrollFrame.BackgroundTransparency = 1
                ScrollFrame.BorderSizePixel       = 0
                ScrollFrame.Size                  = UDim2.new(1, 0, 1, 0)
                ScrollFrame.ZIndex                = 5
                ScrollFrame.ScrollBarImageColor3  = Color3.fromRGB(60, 60, 60)
                ScrollFrame.BottomImage           = ''
                ScrollFrame.ScrollBarThickness    = 1
                ScrollFrame.TopImage              = ''
                ScrollFrame.AutomaticCanvasSize   = Enum.AutomaticSize.Y

                local function hideScroll()
                    if ScrollFrame.Parent == optimized_folder then return end
                    ScrollFrame.Parent  = optimized_folder
                    ScrollFrame.Visible = false
                end

                local function showScroll()
                    if ScrollFrame.Parent == Dropdown then return end
                    ScrollFrame.Parent  = Dropdown
                    ScrollFrame.Visible = true
                end

                Dropdown:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
                    if Library.disconnected then return end

                    if not Library.can_be_optimized then
                        task.delay(1, showScroll)
                        return
                    end
                    task.spawn(hideScroll)
                end)

                ScrollLayout.Parent              = ScrollFrame
                ScrollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                ScrollLayout.SortOrder           = Enum.SortOrder.LayoutOrder
                ScrollLayout.Padding             = UDim.new(0, 6)

                local selected_mod
                local current_flag = Library.flags[self.flag]

                if not current_flag then
                    Library.flags[self.flag] = self.default_flag or nil
                    current_flag             = Library.flags[self.flag]
                end

                for _, value in self.mods do
                    local Mode       = Instance.new('TextButton')
                    local ModeTitle  = Instance.new('TextLabel')
                    local ModeCorner = Instance.new('UICorner')

                    Mode.Name               = 'Mode'
                    Mode.Parent             = ScrollFrame
                    Mode.BackgroundColor3   = Color3.fromRGB(24, 24, 24)
                    Mode.BackgroundTransparency = 0.65
                    Mode.BorderSizePixel    = 0
                    Mode.Size               = UDim2.new(0, 144, 0, 22)
                    Mode.AutoButtonColor    = false
                    Mode.Text               = ''
                    Mode.TextSize           = 1
                    Mode.TextTransparency   = 1
                    Mode.TextWrapped        = true

                    ModeTitle.Name                = 'Title'
                    ModeTitle.Parent              = Mode
                    ModeTitle.BackgroundTransparency = 1
                    ModeTitle.Size                = UDim2.new(0, 122, 0, 12)
                    ModeTitle.FontFace            = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Medium)
                    ModeTitle.Text                = value
                    ModeTitle.Position            = UDim2.new(0, 7, 0, 5)
                    ModeTitle.TextColor3          = Color3.fromRGB(255, 255, 255)
                    ModeTitle.TextScaled          = true
                    ModeTitle.TextTransparency    = 0.3
                    ModeTitle.TextWrapped         = true
                    ModeTitle.TextXAlignment      = Enum.TextXAlignment.Left

                    ModeCorner.CornerRadius = UDim.new(0, 6)
                    ModeCorner.Parent       = Mode

                    if current_flag == value then
                        selected_mod             = Mode
                        Mode.BackgroundColor3    = Color3.fromRGB(60, 60, 60)
                    end

                    local function onModeSelect()
                        if selected_mod then
                            TweenService:Create(selected_mod,
                                TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                            }):Play()
                        end

                        selected_mod = Mode

                        TweenService:Create(Mode, TweenInfo.new(1.2, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                        }):Play()

                        Library.flags[self.flag] = value

                        -- FIX: callback también es opcional en create_dropdown
                        if callback then
                            callback(Library.flags[self.flag])
                        end

                        ConfigsController.save(game.GameId, Library.flags)
                    end

                    Mode.MouseButton1Click:Connect(onModeSelect)
                    Mode.TouchTap:Connect(onModeSelect)
                end

                ScrollPad.Parent     = ScrollFrame
                ScrollPad.PaddingTop = UDim.new(0, 10)

                DDTitle.Name                = 'Title'
                DDTitle.Parent              = Settings
                DDTitle.BackgroundTransparency = 1
                DDTitle.Size                = UDim2.new(0, 144, 0, 8)
                DDTitle.ZIndex              = 2
                DDTitle.FontFace            = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Medium)
                DDTitle.Text                = self.title
                DDTitle.TextColor3          = Color3.fromRGB(255, 255, 255)
                DDTitle.TextScaled          = true
                DDTitle.TextTransparency    = 0.66
                DDTitle.TextWrapped         = true
            end

            return SettingsController
        end

        return ModuleController
    end

    return TabsController
end

return Library
