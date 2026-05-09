--[[
	ui-engine-v2
	version 1.4a
	by Singularity (V3rm @ King Singularity) (Discord @ Singularity#5490)
    modified by: 00Fazee 
--]]

local Library = {version = 1.4}
local Config = {
    main_color = Color3.fromRGB(41, 74, 122),
    min_size = Vector2.new(400, 300),
    toggle_key = Enum.KeyCode.RightShift,
    can_resize = true,
}

warn('running on Library version // ' .. tostring(Library.version) .. '\n\r\n\t         _                     _                    ___ \r\n\t  __  __(_)  ___  ____  ____ _(_)___  ___     _   _|__ \\\r\n\t / / / / /  / _ \\/ __ \\/ __ `/ / __ \\/ _ \\   | | / /_/ /\r\n\t/ /_/ / /  /  __/ / / / /_/ / / / / /  __/   | |/ / __/ \r\n\t\\__,_/_/   \\___/_/ /_/\\__, /_/_/ /_/\\___/    |___/____/ \r\n\t\t\t\t\t\t/____/                             \r\n\r\n\tby Singularity (V3rm @ King Singularity) (Discord @ Singularity#5490)\r\n\t[Edited version by 00Fazee]\r\n')

local _ScreenGui        = Instance.new('ScreenGui')
local _Prefabs          = Instance.new('Frame')           -- contenedor de prefabs
local _LabelPrefab      = Instance.new('TextLabel')       -- prefab: etiqueta de texto
local _WindowPrefab     = Instance.new('ImageLabel')      -- prefab: ventana principal
local _ResizerPrefab    = Instance.new('Frame')           -- prefab: área de resize
local _BarPrefab        = Instance.new('Frame')           -- prefab: barra de título
local _ToggleBtn        = Instance.new('ImageButton')     -- prefab: botón colapsar ventana
local _BarBase          = Instance.new('ImageLabel')      -- prefab: base inferior de la barra
local _BarTop           = Instance.new('ImageLabel')      -- prefab: parte superior redondeada de la barra
local _TabsContainer    = Instance.new('Frame')           -- prefab: contenedor de pestañas
local _WindowTitle      = Instance.new('TextLabel')       -- prefab: título de la ventana
local _TabSelectionBar  = Instance.new('ImageLabel')      -- prefab: barra de selección de tabs
local _TabButtonsFrame  = Instance.new('Frame')           -- prefab: fila de botones de tab
local _TabListLayout    = Instance.new('UIListLayout')    -- layout horizontal de tab buttons
local _TabUnderline     = Instance.new('Frame')           -- línea debajo de la barra de tabs
local _TabPrefab        = Instance.new('Frame')           -- prefab: contenido de un tab
local _TabContentLayout = Instance.new('UIListLayout')    -- layout vertical de elementos en un tab
local _TextBoxPrefab    = Instance.new('TextBox')         -- prefab: caja de texto
local _TextBoxBg        = Instance.new('ImageLabel')      -- fondo redondeado del TextBox
local _SliderPrefab     = Instance.new('ImageLabel')      -- prefab: slider
local _SliderTitle      = Instance.new('TextLabel')       -- título del slider
local _SliderIndicator  = Instance.new('ImageLabel')      -- relleno del slider
local _SliderValue      = Instance.new('TextLabel')       -- valor actual del slider
local _SliderBracketR   = Instance.new('TextLabel')       -- decoración "]"
local _SliderBracketL   = Instance.new('TextLabel')       -- decoración "["
local _RippleCircle     = Instance.new('ImageLabel')      -- prefab: efecto ripple de click
local _ColorLayout      = Instance.new('UIListLayout')    -- layout horizontal (color picker, etc.)
local _DropdownPrefab   = Instance.new('TextButton')      -- prefab: dropdown
local _DropdownArrow    = Instance.new('ImageLabel')      -- flecha del dropdown
local _DropdownBox      = Instance.new('ImageButton')     -- caja desplegable
local _DropdownScroll   = Instance.new('ScrollingFrame')  -- scroll de opciones del dropdown
local _DropdownLayout   = Instance.new('UIListLayout')    -- layout del scroll del dropdown
local _DropdownBg       = Instance.new('ImageLabel')      -- fondo redondeado del dropdown
local _TabButtonPrefab  = Instance.new('TextButton')      -- prefab: botón de tab individual
local _TabButtonBg      = Instance.new('ImageLabel')      -- fondo redondeado del tab button
local _FolderPrefab     = Instance.new('ImageLabel')      -- prefab: carpeta
local _FolderBtn        = Instance.new('TextButton')      -- botón de la carpeta
local _FolderBtnBg      = Instance.new('ImageLabel')      -- fondo redondeado del botón carpeta
local _FolderToggleIcon = Instance.new('ImageLabel')      -- icono toggle de la carpeta
local _FolderObjects    = Instance.new('Frame')           -- contenedor de elementos dentro de la carpeta
local _FolderLayout     = Instance.new('UIListLayout')    -- layout de la carpeta
local _HAlignPrefab     = Instance.new('Frame')           -- prefab: alineación horizontal
local _HAlignLayout     = Instance.new('UIListLayout')    -- layout horizontal
local _ConsolePrefab    = Instance.new('ImageLabel')      -- prefab: consola/editor de código
local _ConsoleScroll    = Instance.new('ScrollingFrame')  -- scroll de la consola
local _SourceBox        = Instance.new('TextBox')         -- caja de texto de código
local _SyntaxComments   = Instance.new('TextLabel')       -- capa: comentarios
local _SyntaxGlobals    = Instance.new('TextLabel')       -- capa: globals
local _SyntaxKeywords   = Instance.new('TextLabel')       -- capa: keywords
local _SyntaxRemotes    = Instance.new('TextLabel')       -- capa: RemoteEvent/Function
local _SyntaxStrings    = Instance.new('TextLabel')       -- capa: strings
local _SyntaxTokens     = Instance.new('TextLabel')       -- capa: tokens/operadores
local _SyntaxNumbers    = Instance.new('TextLabel')       -- capa: números
local _SyntaxInfo       = Instance.new('TextLabel')       -- capa: info highlight
local _LineNumbers      = Instance.new('TextLabel')       -- números de línea
local _ColorPickerPrefab  = Instance.new('ImageLabel')    -- prefab: color picker
local _ColorPalette       = Instance.new('ImageLabel')    -- paleta de colores 2D
local _PaletteIndicator   = Instance.new('ImageLabel')    -- indicador en la paleta
local _ColorSample        = Instance.new('ImageLabel')    -- muestra del color seleccionado
local _SaturationBar      = Instance.new('ImageLabel')    -- barra de saturación
local _SatIndicator       = Instance.new('Frame')         -- indicador de saturación
local _SwitchPrefab       = Instance.new('TextButton')    -- prefab: switch (checkbox)
local _SwitchBg           = Instance.new('ImageLabel')    -- fondo del switch
local _SwitchTitle        = Instance.new('TextLabel')     -- título del switch
local _ButtonPrefab       = Instance.new('TextButton')    -- prefab: botón
local _ButtonBg           = Instance.new('ImageLabel')    -- fondo redondeado del botón
local _DropdownItemPrefab = Instance.new('TextButton')    -- prefab: ítem dentro del dropdown
local _KeybindPrefab      = Instance.new('ImageLabel')    -- prefab: keybind
local _KeybindTitle       = Instance.new('TextLabel')     -- título del keybind
local _KeybindInput       = Instance.new('TextButton')    -- botón de captura de tecla
local _KeybindInputBg     = Instance.new('ImageLabel')    -- fondo del botón de captura
local _WindowsContainer   = Instance.new('Frame')         -- contenedor de todas las ventanas en pantalla

-- ─── Configuración del ScreenGui ──────────────────────────────────────────────

_ScreenGui.Name    = 'ui-engine-v2'
_ScreenGui.Parent  = game:GetService('CoreGui')
_ScreenGui.Enabled = false

local screenGuiRef = _ScreenGui
_ScreenGui.SetAttribute(screenGuiRef, 'dead', false)

-- ─── Prefabs Frame ────────────────────────────────────────────────────────────

_Prefabs.Name             = 'Prefabs'
_Prefabs.Parent           = _ScreenGui
_Prefabs.BackgroundColor3 = Color3.new(1, 1, 1)
_Prefabs.Size             = UDim2.new(0, 100, 0, 100)
_Prefabs.Visible          = false

-- Label prefab
_LabelPrefab.Name                = 'Label'
_LabelPrefab.Parent              = _Prefabs
_LabelPrefab.BackgroundColor3    = Color3.new(1, 1, 1)
_LabelPrefab.BackgroundTransparency = 1
_LabelPrefab.Size                = UDim2.new(0, 200, 0, 20)
_LabelPrefab.Font                = Enum.Font.GothamSemibold
_LabelPrefab.Text                = 'Hello, world 123'
_LabelPrefab.TextColor3          = Color3.new(1, 1, 1)
_LabelPrefab.TextSize            = 14
_LabelPrefab.TextXAlignment      = Enum.TextXAlignment.Left

-- Window prefab
_WindowPrefab.Name                  = 'Window'
_WindowPrefab.Parent                = _Prefabs
_WindowPrefab.Active                = true
_WindowPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_WindowPrefab.BackgroundTransparency = 1
_WindowPrefab.ClipsDescendants      = true
_WindowPrefab.Position              = UDim2.new(0, 20, 0, 20)
_WindowPrefab.Selectable            = true
_WindowPrefab.Size                  = UDim2.new(0, 200, 0, 200)
_WindowPrefab.Image                 = 'rbxassetid://2851926732'
_WindowPrefab.ImageColor3           = Color3.new(0.0823529, 0.0862745, 0.0901961)
_WindowPrefab.ScaleType             = Enum.ScaleType.Slice
_WindowPrefab.SliceCenter           = Rect.new(12, 12, 12, 12)

-- Resizer prefab
_ResizerPrefab.Name                  = 'Resizer'
_ResizerPrefab.Parent                = _WindowPrefab
_ResizerPrefab.Active                = true
_ResizerPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_ResizerPrefab.BackgroundTransparency = 1
_ResizerPrefab.BorderSizePixel       = 0
_ResizerPrefab.Position              = UDim2.new(1, -20, 1, -20)
_ResizerPrefab.Size                  = UDim2.new(0, 20, 0, 20)

-- Title bar prefab
_BarPrefab.Name             = 'Bar'
_BarPrefab.Parent           = _WindowPrefab
_BarPrefab.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
_BarPrefab.BorderSizePixel  = 0
_BarPrefab.Position         = UDim2.new(0, 0, 0, 5)
_BarPrefab.Size             = UDim2.new(1, 0, 0, 15)

-- Toggle (collapse) button in bar
_ToggleBtn.Name                  = 'Toggle'
_ToggleBtn.Parent                = _BarPrefab
_ToggleBtn.BackgroundColor3      = Color3.new(1, 1, 1)
_ToggleBtn.BackgroundTransparency = 1
_ToggleBtn.Position              = UDim2.new(0, 5, 0, -2)
_ToggleBtn.Rotation              = 90
_ToggleBtn.Size                  = UDim2.new(0, 20, 0, 20)
_ToggleBtn.ZIndex                = 2
_ToggleBtn.Image                 = 'https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541'

-- Bar base (bottom rounded cap)
_BarBase.Name             = 'Base'
_BarBase.Parent           = _BarPrefab
_BarBase.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
_BarBase.BorderSizePixel  = 0
_BarBase.Position         = UDim2.new(0, 0, 0.800000012, 0)
_BarBase.Size             = UDim2.new(1, 0, 0, 10)
_BarBase.Image            = 'rbxassetid://2851926732'
_BarBase.ImageColor3      = Color3.new(0.160784, 0.290196, 0.478431)
_BarBase.ScaleType        = Enum.ScaleType.Slice
_BarBase.SliceCenter      = Rect.new(12, 12, 12, 12)

-- Bar top (top rounded cap)
_BarTop.Name                  = 'Top'
_BarTop.Parent                = _BarPrefab
_BarTop.BackgroundColor3      = Color3.new(1, 1, 1)
_BarTop.BackgroundTransparency = 1
_BarTop.Position              = UDim2.new(0, 0, 0, -5)
_BarTop.Size                  = UDim2.new(1, 0, 0, 10)
_BarTop.Image                 = 'rbxassetid://2851926732'
_BarTop.ImageColor3           = Color3.new(0.160784, 0.290196, 0.478431)
_BarTop.ScaleType             = Enum.ScaleType.Slice
_BarTop.SliceCenter           = Rect.new(12, 12, 12, 12)

-- Tabs content area
_TabsContainer.Name                  = 'Tabs'
_TabsContainer.Parent                = _WindowPrefab
_TabsContainer.BackgroundColor3      = Color3.new(1, 1, 1)
_TabsContainer.BackgroundTransparency = 1
_TabsContainer.Position              = UDim2.new(0, 15, 0, 60)
_TabsContainer.Size                  = UDim2.new(1, -30, 1, -60)

-- Window title label
_WindowTitle.Name                  = 'Title'
_WindowTitle.Parent                = _WindowPrefab
_WindowTitle.BackgroundColor3      = Color3.new(1, 1, 1)
_WindowTitle.BackgroundTransparency = 1
_WindowTitle.Position              = UDim2.new(0, 30, 0, 3)
_WindowTitle.Size                  = UDim2.new(0, 200, 0, 20)
_WindowTitle.Font                  = Enum.Font.GothamBold
_WindowTitle.Text                  = 'Gamer Time'
_WindowTitle.TextColor3            = Color3.new(1, 1, 1)
_WindowTitle.TextSize              = 14
_WindowTitle.TextXAlignment        = Enum.TextXAlignment.Left

-- Tab selection bar
_TabSelectionBar.Name                  = 'TabSelection'
_TabSelectionBar.Parent                = _WindowPrefab
_TabSelectionBar.BackgroundColor3      = Color3.new(1, 1, 1)
_TabSelectionBar.BackgroundTransparency = 1
_TabSelectionBar.Position              = UDim2.new(0, 15, 0, 30)
_TabSelectionBar.Size                  = UDim2.new(1, -30, 0, 25)
_TabSelectionBar.Visible               = false
_TabSelectionBar.Image                 = 'rbxassetid://2851929490'
_TabSelectionBar.ImageColor3           = Color3.new(0.145098, 0.14902, 0.156863)
_TabSelectionBar.ScaleType             = Enum.ScaleType.Slice
_TabSelectionBar.SliceCenter           = Rect.new(4, 4, 4, 4)

-- Tab buttons row
_TabButtonsFrame.Name                  = 'TabButtons'
_TabButtonsFrame.Parent                = _TabSelectionBar
_TabButtonsFrame.BackgroundColor3      = Color3.new(1, 1, 1)
_TabButtonsFrame.BackgroundTransparency = 1
_TabButtonsFrame.Size                  = UDim2.new(1, 0, 1, 0)

_TabListLayout.Parent        = _TabButtonsFrame
_TabListLayout.FillDirection = Enum.FillDirection.Horizontal
_TabListLayout.SortOrder     = Enum.SortOrder.LayoutOrder
_TabListLayout.Padding       = UDim.new(0, 2)

-- Underline below tab bar
_TabUnderline.Parent          = _TabSelectionBar
_TabUnderline.BackgroundColor3 = Color3.new(0.12549, 0.227451, 0.372549)
_TabUnderline.BorderColor3    = Color3.new(0.105882, 0.164706, 0.207843)
_TabUnderline.BorderSizePixel = 0
_TabUnderline.Position        = UDim2.new(0, 0, 1, 0)
_TabUnderline.Size            = UDim2.new(1, 0, 0, 2)

-- Tab content prefab
_TabPrefab.Name                  = 'Tab'
_TabPrefab.Parent                = _Prefabs
_TabPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_TabPrefab.BackgroundTransparency = 1
_TabPrefab.Size                  = UDim2.new(1, 0, 1, 0)
_TabPrefab.Visible               = false

_TabContentLayout.Parent    = _TabPrefab
_TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
_TabContentLayout.Padding   = UDim.new(0, 5)

-- TextBox prefab
_TextBoxPrefab.Parent                = _Prefabs
_TextBoxPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_TextBoxPrefab.BackgroundTransparency = 1
_TextBoxPrefab.BorderSizePixel       = 0
_TextBoxPrefab.Size                  = UDim2.new(1, 0, 0, 20)
_TextBoxPrefab.ZIndex                = 2
_TextBoxPrefab.Font                  = Enum.Font.GothamSemibold
_TextBoxPrefab.PlaceholderColor3     = Color3.new(0.698039, 0.698039, 0.698039)
_TextBoxPrefab.PlaceholderText       = 'Input Text'
_TextBoxPrefab.Text                  = ''
_TextBoxPrefab.TextColor3            = Color3.new(0.784314, 0.784314, 0.784314)
_TextBoxPrefab.TextSize              = 14

_TextBoxBg.Name                  = 'TextBox_Roundify_4px'
_TextBoxBg.Parent                = _TextBoxPrefab
_TextBoxBg.BackgroundColor3      = Color3.new(1, 1, 1)
_TextBoxBg.BackgroundTransparency = 1
_TextBoxBg.Size                  = UDim2.new(1, 0, 1, 0)
_TextBoxBg.Image                 = 'rbxassetid://2851929490'
_TextBoxBg.ImageColor3           = Color3.new(0.203922, 0.207843, 0.219608)
_TextBoxBg.ScaleType             = Enum.ScaleType.Slice
_TextBoxBg.SliceCenter           = Rect.new(4, 4, 4, 4)

-- Slider prefab
_SliderPrefab.Name                  = 'Slider'
_SliderPrefab.Parent                = _Prefabs
_SliderPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_SliderPrefab.BackgroundTransparency = 1
_SliderPrefab.Position              = UDim2.new(0, 0, 0.178571433, 0)
_SliderPrefab.Size                  = UDim2.new(1, 0, 0, 20)
_SliderPrefab.Image                 = 'rbxassetid://2851929490'
_SliderPrefab.ImageColor3           = Color3.new(0.145098, 0.14902, 0.156863)
_SliderPrefab.ScaleType             = Enum.ScaleType.Slice
_SliderPrefab.SliceCenter           = Rect.new(4, 4, 4, 4)

_SliderTitle.Name                  = 'Title'
_SliderTitle.Parent                = _SliderPrefab
_SliderTitle.BackgroundColor3      = Color3.new(1, 1, 1)
_SliderTitle.BackgroundTransparency = 1
_SliderTitle.Position              = UDim2.new(0.5, 0, 0.5, -10)
_SliderTitle.Size                  = UDim2.new(0, 0, 0, 20)
_SliderTitle.ZIndex                = 2
_SliderTitle.Font                  = Enum.Font.GothamBold
_SliderTitle.Text                  = 'Slider'
_SliderTitle.TextColor3            = Color3.new(0.784314, 0.784314, 0.784314)
_SliderTitle.TextSize              = 14

_SliderIndicator.Name                  = 'Indicator'
_SliderIndicator.Parent                = _SliderPrefab
_SliderIndicator.BackgroundColor3      = Color3.new(1, 1, 1)
_SliderIndicator.BackgroundTransparency = 1
_SliderIndicator.Size                  = UDim2.new(0, 0, 0, 20)
_SliderIndicator.Image                 = 'rbxassetid://2851929490'
_SliderIndicator.ImageColor3           = Color3.new(0.254902, 0.262745, 0.278431)
_SliderIndicator.ScaleType             = Enum.ScaleType.Slice
_SliderIndicator.SliceCenter           = Rect.new(4, 4, 4, 4)

_SliderValue.Name                  = 'Value'
_SliderValue.Parent                = _SliderPrefab
_SliderValue.BackgroundColor3      = Color3.new(1, 1, 1)
_SliderValue.BackgroundTransparency = 1
_SliderValue.Position              = UDim2.new(1, -55, 0.5, -10)
_SliderValue.Size                  = UDim2.new(0, 50, 0, 20)
_SliderValue.Font                  = Enum.Font.GothamBold
_SliderValue.Text                  = '0%'
_SliderValue.TextColor3            = Color3.new(0.784314, 0.784314, 0.784314)
_SliderValue.TextSize              = 14

_SliderBracketR.Parent                = _SliderPrefab
_SliderBracketR.BackgroundColor3      = Color3.new(1, 1, 1)
_SliderBracketR.BackgroundTransparency = 1
_SliderBracketR.Position              = UDim2.new(1, -20, -0.75, 0)
_SliderBracketR.Size                  = UDim2.new(0, 26, 0, 50)
_SliderBracketR.Font                  = Enum.Font.GothamBold
_SliderBracketR.Text                  = ']'
_SliderBracketR.TextColor3            = Color3.new(0.627451, 0.627451, 0.627451)
_SliderBracketR.TextSize              = 14

_SliderBracketL.Parent                = _SliderPrefab
_SliderBracketL.BackgroundColor3      = Color3.new(1, 1, 1)
_SliderBracketL.BackgroundTransparency = 1
_SliderBracketL.Position              = UDim2.new(1, -65, -0.75, 0)
_SliderBracketL.Size                  = UDim2.new(0, 26, 0, 50)
_SliderBracketL.Font                  = Enum.Font.GothamBold
_SliderBracketL.Text                  = '['
_SliderBracketL.TextColor3            = Color3.new(0.627451, 0.627451, 0.627451)
_SliderBracketL.TextSize              = 14

-- Ripple circle prefab
_RippleCircle.Name               = 'Circle'
_RippleCircle.Parent             = _Prefabs
_RippleCircle.BackgroundColor3   = Color3.new(1, 1, 1)
_RippleCircle.BackgroundTransparency = 1
_RippleCircle.Image              = 'rbxassetid://266543268'
_RippleCircle.ImageTransparency  = 0.5

_ColorLayout.Parent        = _Prefabs
_ColorLayout.FillDirection = Enum.FillDirection.Horizontal
_ColorLayout.SortOrder     = Enum.SortOrder.LayoutOrder
_ColorLayout.Padding       = UDim.new(0, 20)

-- Dropdown prefab
_DropdownPrefab.Name                  = 'Dropdown'
_DropdownPrefab.Parent                = _Prefabs
_DropdownPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_DropdownPrefab.BackgroundTransparency = 1
_DropdownPrefab.BorderSizePixel       = 0
_DropdownPrefab.Position              = UDim2.new(-0.055555556, 0, 0.0833333284, 0)
_DropdownPrefab.Size                  = UDim2.new(0, 200, 0, 20)
_DropdownPrefab.ZIndex                = 2
_DropdownPrefab.Font                  = Enum.Font.GothamBold
_DropdownPrefab.Text                  = '      Dropdown'
_DropdownPrefab.TextColor3            = Color3.new(0.784314, 0.784314, 0.784314)
_DropdownPrefab.TextSize              = 14
_DropdownPrefab.TextXAlignment        = Enum.TextXAlignment.Left

_DropdownArrow.Name                  = 'Indicator'
_DropdownArrow.Parent                = _DropdownPrefab
_DropdownArrow.BackgroundColor3      = Color3.new(1, 1, 1)
_DropdownArrow.BackgroundTransparency = 1
_DropdownArrow.Position              = UDim2.new(0.899999976, -10, 0.100000001, 0)
_DropdownArrow.Rotation              = -90
_DropdownArrow.Size                  = UDim2.new(0, 15, 0, 15)
_DropdownArrow.ZIndex                = 2
_DropdownArrow.Image                 = 'https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4744658743'

_DropdownBox.Name                  = 'Box'
_DropdownBox.Parent                = _DropdownPrefab
_DropdownBox.BackgroundColor3      = Color3.new(1, 1, 1)
_DropdownBox.BackgroundTransparency = 1
_DropdownBox.Position              = UDim2.new(0, 0, 0, 25)
_DropdownBox.Size                  = UDim2.new(1, 0, 0, 150)
_DropdownBox.ZIndex                = 3
_DropdownBox.Image                 = 'rbxassetid://2851929490'
_DropdownBox.ImageColor3           = Color3.new(0.129412, 0.133333, 0.141176)
_DropdownBox.ScaleType             = Enum.ScaleType.Slice
_DropdownBox.SliceCenter           = Rect.new(4, 4, 4, 4)

_DropdownScroll.Name                 = 'Objects'
_DropdownScroll.Parent               = _DropdownBox
_DropdownScroll.BackgroundColor3     = Color3.new(1, 1, 1)
_DropdownScroll.BackgroundTransparency = 1
_DropdownScroll.BorderSizePixel      = 0
_DropdownScroll.Size                 = UDim2.new(1, 0, 1, 0)
_DropdownScroll.ZIndex               = 3
_DropdownScroll.CanvasSize           = UDim2.new(0, 0, 0, 0)
_DropdownScroll.ScrollBarThickness   = 8

_DropdownLayout.Parent    = _DropdownScroll
_DropdownLayout.SortOrder = Enum.SortOrder.LayoutOrder

_DropdownBg.Name                  = 'TextButton_Roundify_4px'
_DropdownBg.Parent                = _DropdownPrefab
_DropdownBg.BackgroundColor3      = Color3.new(1, 1, 1)
_DropdownBg.BackgroundTransparency = 1
_DropdownBg.Size                  = UDim2.new(1, 0, 1, 0)
_DropdownBg.Image                 = 'rbxassetid://2851929490'
_DropdownBg.ImageColor3           = Color3.new(0.203922, 0.207843, 0.219608)
_DropdownBg.ScaleType             = Enum.ScaleType.Slice
_DropdownBg.SliceCenter           = Rect.new(4, 4, 4, 4)

-- Tab button prefab
_TabButtonPrefab.Name                  = 'TabButton'
_TabButtonPrefab.Parent                = _Prefabs
_TabButtonPrefab.BackgroundColor3      = Color3.new(0.160784, 0.290196, 0.478431)
_TabButtonPrefab.BackgroundTransparency = 1
_TabButtonPrefab.BorderSizePixel       = 0
_TabButtonPrefab.Position              = UDim2.new(0.185185179, 0, 0, 0)
_TabButtonPrefab.Size                  = UDim2.new(0, 71, 0, 20)
_TabButtonPrefab.ZIndex                = 2
_TabButtonPrefab.Font                  = Enum.Font.GothamSemibold
_TabButtonPrefab.Text                  = 'Test tab'
_TabButtonPrefab.TextColor3            = Color3.new(0.784314, 0.784314, 0.784314)
_TabButtonPrefab.TextSize              = 14

_TabButtonBg.Name                  = 'TextButton_Roundify_4px'
_TabButtonBg.Parent                = _TabButtonPrefab
_TabButtonBg.BackgroundColor3      = Color3.new(1, 1, 1)
_TabButtonBg.BackgroundTransparency = 1
_TabButtonBg.Size                  = UDim2.new(1, 0, 1, 0)
_TabButtonBg.Image                 = 'rbxassetid://2851929490'
_TabButtonBg.ImageColor3           = Color3.new(0.203922, 0.207843, 0.219608)
_TabButtonBg.ScaleType             = Enum.ScaleType.Slice
_TabButtonBg.SliceCenter           = Rect.new(4, 4, 4, 4)

-- Folder prefab
_FolderPrefab.Name                  = 'Folder'
_FolderPrefab.Parent                = _Prefabs
_FolderPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_FolderPrefab.BackgroundTransparency = 1
_FolderPrefab.Position              = UDim2.new(0, 0, 0, 50)
_FolderPrefab.Size                  = UDim2.new(1, 0, 0, 20)
_FolderPrefab.Image                 = 'rbxassetid://2851929490'
_FolderPrefab.ImageColor3           = Color3.new(0.0823529, 0.0862745, 0.0901961)
_FolderPrefab.ScaleType             = Enum.ScaleType.Slice
_FolderPrefab.SliceCenter           = Rect.new(4, 4, 4, 4)

_FolderBtn.Name                  = 'Button'
_FolderBtn.Parent                = _FolderPrefab
_FolderBtn.BackgroundColor3      = Color3.new(0.160784, 0.290196, 0.478431)
_FolderBtn.BackgroundTransparency = 1
_FolderBtn.BorderSizePixel       = 0
_FolderBtn.Size                  = UDim2.new(1, 0, 0, 20)
_FolderBtn.ZIndex                = 2
_FolderBtn.Font                  = Enum.Font.GothamSemibold
_FolderBtn.Text                  = '      Folder'
_FolderBtn.TextColor3            = Color3.new(1, 1, 1)
_FolderBtn.TextSize              = 14
_FolderBtn.TextXAlignment        = Enum.TextXAlignment.Left

_FolderBtnBg.Name                  = 'TextButton_Roundify_4px'
_FolderBtnBg.Parent                = _FolderBtn
_FolderBtnBg.BackgroundColor3      = Color3.new(1, 1, 1)
_FolderBtnBg.BackgroundTransparency = 1
_FolderBtnBg.Size                  = UDim2.new(1, 0, 1, 0)
_FolderBtnBg.Image                 = 'rbxassetid://2851929490'
_FolderBtnBg.ImageColor3           = Color3.new(0.160784, 0.290196, 0.478431)
_FolderBtnBg.ScaleType             = Enum.ScaleType.Slice
_FolderBtnBg.SliceCenter           = Rect.new(4, 4, 4, 4)

_FolderToggleIcon.Name                  = 'Toggle'
_FolderToggleIcon.Parent                = _FolderBtn
_FolderToggleIcon.BackgroundColor3      = Color3.new(1, 1, 1)
_FolderToggleIcon.BackgroundTransparency = 1
_FolderToggleIcon.Position              = UDim2.new(0, 5, 0, 2)
_FolderToggleIcon.Size                  = UDim2.new(0, 15, 0, 15)
_FolderToggleIcon.ZIndex                = 3
_FolderToggleIcon.Image                 = 'https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541'

_FolderObjects.Name                  = 'Objects'
_FolderObjects.Parent                = _FolderPrefab
_FolderObjects.BackgroundColor3      = Color3.new(1, 1, 1)
_FolderObjects.BackgroundTransparency = 1
_FolderObjects.Position              = UDim2.new(0, 10, 0, 25)
_FolderObjects.Size                  = UDim2.new(1, -10, 1, -25)
_FolderObjects.Visible               = false

_FolderLayout.Parent    = _FolderObjects
_FolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
_FolderLayout.Padding   = UDim.new(0, 5)

-- Horizontal alignment prefab
_HAlignPrefab.Name                  = 'HorizontalAlignment'
_HAlignPrefab.Parent                = _Prefabs
_HAlignPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_HAlignPrefab.BackgroundTransparency = 1
_HAlignPrefab.Size                  = UDim2.new(1, 0, 0, 20)

_HAlignLayout.Parent        = _HAlignPrefab
_HAlignLayout.FillDirection = Enum.FillDirection.Horizontal
_HAlignLayout.SortOrder     = Enum.SortOrder.LayoutOrder
_HAlignLayout.Padding       = UDim.new(0, 5)

-- Console prefab
_ConsolePrefab.Name             = 'Console'
_ConsolePrefab.Parent           = _Prefabs
_ConsolePrefab.BackgroundColor3 = Color3.new(1, 1, 1)
_ConsolePrefab.BackgroundTransparency = 1
_ConsolePrefab.Size             = UDim2.new(1, 0, 0, 200)
_ConsolePrefab.Image            = 'rbxassetid://2851928141'
_ConsolePrefab.ImageColor3      = Color3.new(0.129412, 0.133333, 0.141176)
_ConsolePrefab.ScaleType        = Enum.ScaleType.Slice
_ConsolePrefab.SliceCenter      = Rect.new(8, 8, 8, 8)

_ConsoleScroll.Parent               = _ConsolePrefab
_ConsoleScroll.BackgroundColor3     = Color3.new(1, 1, 1)
_ConsoleScroll.BackgroundTransparency = 1
_ConsoleScroll.BorderSizePixel      = 0
_ConsoleScroll.Size                 = UDim2.new(1, 0, 1, 1)
_ConsoleScroll.CanvasSize           = UDim2.new(0, 0, 0, 0)
_ConsoleScroll.ScrollBarThickness   = 4

_SourceBox.Name               = 'Source'
_SourceBox.Parent             = _ConsoleScroll
_SourceBox.BackgroundColor3   = Color3.new(1, 1, 1)
_SourceBox.BackgroundTransparency = 1
_SourceBox.Position           = UDim2.new(0, 40, 0, 0)
_SourceBox.Size               = UDim2.new(1, -40, 0, 10000)
_SourceBox.ZIndex             = 3
_SourceBox.ClearTextOnFocus   = false
_SourceBox.Font               = Enum.Font.Code
_SourceBox.MultiLine          = true
_SourceBox.PlaceholderColor3  = Color3.new(0.8, 0.8, 0.8)
_SourceBox.Text               = ''
_SourceBox.TextColor3         = Color3.new(1, 1, 1)
_SourceBox.TextSize           = 15
_SourceBox.TextStrokeColor3   = Color3.new(1, 1, 1)
_SourceBox.TextWrapped        = true
_SourceBox.TextXAlignment     = Enum.TextXAlignment.Left
_SourceBox.TextYAlignment     = Enum.TextYAlignment.Top

-- Syntax highlight layers
_SyntaxComments.Name               = 'Comments'
_SyntaxComments.Parent             = _SourceBox
_SyntaxComments.BackgroundColor3   = Color3.new(1, 1, 1)
_SyntaxComments.BackgroundTransparency = 1
_SyntaxComments.Size               = UDim2.new(1, 0, 1, 0)
_SyntaxComments.ZIndex             = 5
_SyntaxComments.Font               = Enum.Font.Code
_SyntaxComments.Text               = ''
_SyntaxComments.TextColor3         = Color3.new(0.231373, 0.784314, 0.231373)
_SyntaxComments.TextSize           = 15
_SyntaxComments.TextXAlignment     = Enum.TextXAlignment.Left
_SyntaxComments.TextYAlignment     = Enum.TextYAlignment.Top

_SyntaxGlobals.Name               = 'Globals'
_SyntaxGlobals.Parent             = _SourceBox
_SyntaxGlobals.BackgroundColor3   = Color3.new(1, 1, 1)
_SyntaxGlobals.BackgroundTransparency = 1
_SyntaxGlobals.Size               = UDim2.new(1, 0, 1, 0)
_SyntaxGlobals.ZIndex             = 5
_SyntaxGlobals.Font               = Enum.Font.Code
_SyntaxGlobals.Text               = ''
_SyntaxGlobals.TextColor3         = Color3.new(0.517647, 0.839216, 0.968628)
_SyntaxGlobals.TextSize           = 15
_SyntaxGlobals.TextXAlignment     = Enum.TextXAlignment.Left
_SyntaxGlobals.TextYAlignment     = Enum.TextYAlignment.Top

_SyntaxKeywords.Name               = 'Keywords'
_SyntaxKeywords.Parent             = _SourceBox
_SyntaxKeywords.BackgroundColor3   = Color3.new(1, 1, 1)
_SyntaxKeywords.BackgroundTransparency = 1
_SyntaxKeywords.Size               = UDim2.new(1, 0, 1, 0)
_SyntaxKeywords.ZIndex             = 5
_SyntaxKeywords.Font               = Enum.Font.Code
_SyntaxKeywords.Text               = ''
_SyntaxKeywords.TextColor3         = Color3.new(0.972549, 0.427451, 0.486275)
_SyntaxKeywords.TextSize           = 15
_SyntaxKeywords.TextXAlignment     = Enum.TextXAlignment.Left
_SyntaxKeywords.TextYAlignment     = Enum.TextYAlignment.Top

_SyntaxRemotes.Name               = 'RemoteHighlight'
_SyntaxRemotes.Parent             = _SourceBox
_SyntaxRemotes.BackgroundColor3   = Color3.new(1, 1, 1)
_SyntaxRemotes.BackgroundTransparency = 1
_SyntaxRemotes.Size               = UDim2.new(1, 0, 1, 0)
_SyntaxRemotes.ZIndex             = 5
_SyntaxRemotes.Font               = Enum.Font.Code
_SyntaxRemotes.Text               = ''
_SyntaxRemotes.TextColor3         = Color3.new(0, 0.568627, 1)
_SyntaxRemotes.TextSize           = 15
_SyntaxRemotes.TextXAlignment     = Enum.TextXAlignment.Left
_SyntaxRemotes.TextYAlignment     = Enum.TextYAlignment.Top

_SyntaxStrings.Name               = 'Strings'
_SyntaxStrings.Parent             = _SourceBox
_SyntaxStrings.BackgroundColor3   = Color3.new(1, 1, 1)
_SyntaxStrings.BackgroundTransparency = 1
_SyntaxStrings.Size               = UDim2.new(1, 0, 1, 0)
_SyntaxStrings.ZIndex             = 5
_SyntaxStrings.Font               = Enum.Font.Code
_SyntaxStrings.Text               = ''
_SyntaxStrings.TextColor3         = Color3.new(0.678431, 0.945098, 0.584314)
_SyntaxStrings.TextSize           = 15
_SyntaxStrings.TextXAlignment     = Enum.TextXAlignment.Left
_SyntaxStrings.TextYAlignment     = Enum.TextYAlignment.Top

_SyntaxTokens.Name               = 'Tokens'
_SyntaxTokens.Parent             = _SourceBox
_SyntaxTokens.BackgroundColor3   = Color3.new(1, 1, 1)
_SyntaxTokens.BackgroundTransparency = 1
_SyntaxTokens.Size               = UDim2.new(1, 0, 1, 0)
_SyntaxTokens.ZIndex             = 5
_SyntaxTokens.Font               = Enum.Font.Code
_SyntaxTokens.Text               = ''
_SyntaxTokens.TextColor3         = Color3.new(1, 1, 1)
_SyntaxTokens.TextSize           = 15
_SyntaxTokens.TextXAlignment     = Enum.TextXAlignment.Left
_SyntaxTokens.TextYAlignment     = Enum.TextYAlignment.Top

_SyntaxNumbers.Name               = 'Numbers'
_SyntaxNumbers.Parent             = _SourceBox
_SyntaxNumbers.BackgroundColor3   = Color3.new(1, 1, 1)
_SyntaxNumbers.BackgroundTransparency = 1
_SyntaxNumbers.Size               = UDim2.new(1, 0, 1, 0)
_SyntaxNumbers.ZIndex             = 4
_SyntaxNumbers.Font               = Enum.Font.Code
_SyntaxNumbers.Text               = ''
_SyntaxNumbers.TextColor3         = Color3.new(1, 0.776471, 0)
_SyntaxNumbers.TextSize           = 15
_SyntaxNumbers.TextXAlignment     = Enum.TextXAlignment.Left
_SyntaxNumbers.TextYAlignment     = Enum.TextYAlignment.Top

_SyntaxInfo.Name               = 'Info'
_SyntaxInfo.Parent             = _SourceBox
_SyntaxInfo.BackgroundColor3   = Color3.new(1, 1, 1)
_SyntaxInfo.BackgroundTransparency = 1
_SyntaxInfo.Size               = UDim2.new(1, 0, 1, 0)
_SyntaxInfo.ZIndex             = 5
_SyntaxInfo.Font               = Enum.Font.Code
_SyntaxInfo.Text               = ''
_SyntaxInfo.TextColor3         = Color3.new(0, 0.635294, 1)
_SyntaxInfo.TextSize           = 15
_SyntaxInfo.TextXAlignment     = Enum.TextXAlignment.Left
_SyntaxInfo.TextYAlignment     = Enum.TextYAlignment.Top

_LineNumbers.Name               = 'Lines'
_LineNumbers.Parent             = _ConsoleScroll
_LineNumbers.BackgroundColor3   = Color3.new(1, 1, 1)
_LineNumbers.BackgroundTransparency = 1
_LineNumbers.BorderSizePixel    = 0
_LineNumbers.Size               = UDim2.new(0, 40, 0, 10000)
_LineNumbers.ZIndex             = 4
_LineNumbers.Font               = Enum.Font.Code
_LineNumbers.Text               = '1\n'
_LineNumbers.TextColor3         = Color3.new(1, 1, 1)
_LineNumbers.TextSize           = 15
_LineNumbers.TextWrapped        = true
_LineNumbers.TextYAlignment     = Enum.TextYAlignment.Top

-- Color picker prefab
_ColorPickerPrefab.Name                  = 'ColorPicker'
_ColorPickerPrefab.Parent                = _Prefabs
_ColorPickerPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_ColorPickerPrefab.BackgroundTransparency = 1
_ColorPickerPrefab.Size                  = UDim2.new(0, 180, 0, 110)
_ColorPickerPrefab.Image                 = 'rbxassetid://2851929490'
_ColorPickerPrefab.ImageColor3           = Color3.new(0.203922, 0.207843, 0.219608)
_ColorPickerPrefab.ScaleType             = Enum.ScaleType.Slice
_ColorPickerPrefab.SliceCenter           = Rect.new(4, 4, 4, 4)

_ColorPalette.Name                  = 'Palette'
_ColorPalette.Parent                = _ColorPickerPrefab
_ColorPalette.BackgroundColor3      = Color3.new(1, 1, 1)
_ColorPalette.BackgroundTransparency = 1
_ColorPalette.Position              = UDim2.new(0.0500000007, 0, 0.0500000007, 0)
_ColorPalette.Size                  = UDim2.new(0, 100, 0, 100)
_ColorPalette.Image                 = 'rbxassetid://698052001'
_ColorPalette.ScaleType             = Enum.ScaleType.Slice
_ColorPalette.SliceCenter           = Rect.new(4, 4, 4, 4)

_PaletteIndicator.Name                  = 'Indicator'
_PaletteIndicator.Parent                = _ColorPalette
_PaletteIndicator.BackgroundColor3      = Color3.new(1, 1, 1)
_PaletteIndicator.BackgroundTransparency = 1
_PaletteIndicator.Size                  = UDim2.new(0, 5, 0, 5)
_PaletteIndicator.ZIndex                = 2
_PaletteIndicator.Image                 = 'rbxassetid://2851926732'
_PaletteIndicator.ImageColor3           = Color3.new(0, 0, 0)
_PaletteIndicator.ScaleType             = Enum.ScaleType.Slice
_PaletteIndicator.SliceCenter           = Rect.new(12, 12, 12, 12)

_ColorSample.Name             = 'Sample'
_ColorSample.Parent           = _ColorPickerPrefab
_ColorSample.BackgroundColor3 = Color3.new(1, 1, 1)
_ColorSample.BackgroundTransparency = 1
_ColorSample.Position         = UDim2.new(0.800000012, 0, 0.0500000007, 0)
_ColorSample.Size             = UDim2.new(0, 25, 0, 25)
_ColorSample.Image            = 'rbxassetid://2851929490'
_ColorSample.ScaleType        = Enum.ScaleType.Slice
_ColorSample.SliceCenter      = Rect.new(4, 4, 4, 4)

_SaturationBar.Name           = 'Saturation'
_SaturationBar.Parent         = _ColorPickerPrefab
_SaturationBar.BackgroundColor3 = Color3.new(1, 1, 1)
_SaturationBar.Position       = UDim2.new(0.649999976, 0, 0.0500000007, 0)
_SaturationBar.Size           = UDim2.new(0, 15, 0, 100)
_SaturationBar.Image          = 'rbxassetid://3641079629'

_SatIndicator.Name            = 'Indicator'
_SatIndicator.Parent          = _SaturationBar
_SatIndicator.BackgroundColor3 = Color3.new(1, 1, 1)
_SatIndicator.BorderSizePixel = 0
_SatIndicator.Size            = UDim2.new(0, 20, 0, 2)
_SatIndicator.ZIndex          = 2

-- Switch prefab
_SwitchPrefab.Name                  = 'Switch'
_SwitchPrefab.Parent                = _Prefabs
_SwitchPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_SwitchPrefab.BackgroundTransparency = 1
_SwitchPrefab.BorderSizePixel       = 0
_SwitchPrefab.Position              = UDim2.new(0.229411766, 0, 0.20714286, 0)
_SwitchPrefab.Size                  = UDim2.new(0, 20, 0, 20)
_SwitchPrefab.ZIndex                = 2
_SwitchPrefab.Font                  = Enum.Font.SourceSans
_SwitchPrefab.Text                  = ''
_SwitchPrefab.TextColor3            = Color3.new(1, 1, 1)
_SwitchPrefab.TextSize              = 18

_SwitchBg.Name                  = 'TextButton_Roundify_4px'
_SwitchBg.Parent                = _SwitchPrefab
_SwitchBg.BackgroundColor3      = Color3.new(1, 1, 1)
_SwitchBg.BackgroundTransparency = 1
_SwitchBg.Size                  = UDim2.new(1, 0, 1, 0)
_SwitchBg.Image                 = 'rbxassetid://2851929490'
_SwitchBg.ImageColor3           = Color3.new(0.160784, 0.290196, 0.478431)
_SwitchBg.ImageTransparency     = 0.5
_SwitchBg.ScaleType             = Enum.ScaleType.Slice
_SwitchBg.SliceCenter           = Rect.new(4, 4, 4, 4)

_SwitchTitle.Name                  = 'Title'
_SwitchTitle.Parent                = _SwitchPrefab
_SwitchTitle.BackgroundColor3      = Color3.new(1, 1, 1)
_SwitchTitle.BackgroundTransparency = 1
_SwitchTitle.Position              = UDim2.new(1.20000005, 0, 0, 0)
_SwitchTitle.Size                  = UDim2.new(0, 20, 0, 20)
_SwitchTitle.Font                  = Enum.Font.GothamSemibold
_SwitchTitle.Text                  = 'Switch'
_SwitchTitle.TextColor3            = Color3.new(0.784314, 0.784314, 0.784314)
_SwitchTitle.TextSize              = 14
_SwitchTitle.TextXAlignment        = Enum.TextXAlignment.Left

-- Button prefab
_ButtonPrefab.Name                  = 'Button'
_ButtonPrefab.Parent                = _Prefabs
_ButtonPrefab.BackgroundColor3      = Color3.new(0.160784, 0.290196, 0.478431)
_ButtonPrefab.BackgroundTransparency = 1
_ButtonPrefab.BorderSizePixel       = 0
_ButtonPrefab.Size                  = UDim2.new(0, 91, 0, 20)
_ButtonPrefab.ZIndex                = 2
_ButtonPrefab.Font                  = Enum.Font.GothamSemibold
_ButtonPrefab.TextColor3            = Color3.new(1, 1, 1)
_ButtonPrefab.TextSize              = 14

_ButtonBg.Name                  = 'TextButton_Roundify_4px'
_ButtonBg.Parent                = _ButtonPrefab
_ButtonBg.BackgroundColor3      = Color3.new(1, 1, 1)
_ButtonBg.BackgroundTransparency = 1
_ButtonBg.Size                  = UDim2.new(1, 0, 1, 0)
_ButtonBg.Image                 = 'rbxassetid://2851929490'
_ButtonBg.ImageColor3           = Color3.new(0.160784, 0.290196, 0.478431)
_ButtonBg.ScaleType             = Enum.ScaleType.Slice
_ButtonBg.SliceCenter           = Rect.new(4, 4, 4, 4)

-- Dropdown item prefab
_DropdownItemPrefab.Name            = 'DropdownButton'
_DropdownItemPrefab.Parent          = _Prefabs
_DropdownItemPrefab.BackgroundColor3 = Color3.new(0.129412, 0.133333, 0.141176)
_DropdownItemPrefab.BorderSizePixel = 0
_DropdownItemPrefab.Size            = UDim2.new(1, 0, 0, 20)
_DropdownItemPrefab.ZIndex          = 3
_DropdownItemPrefab.Font            = Enum.Font.GothamBold
_DropdownItemPrefab.Text            = '      Button'
_DropdownItemPrefab.TextColor3      = Color3.new(0.784314, 0.784314, 0.784314)
_DropdownItemPrefab.TextSize        = 14
_DropdownItemPrefab.TextXAlignment  = Enum.TextXAlignment.Left

-- Keybind prefab
_KeybindPrefab.Name                  = 'Keybind'
_KeybindPrefab.Parent                = _Prefabs
_KeybindPrefab.BackgroundColor3      = Color3.new(1, 1, 1)
_KeybindPrefab.BackgroundTransparency = 1
_KeybindPrefab.Size                  = UDim2.new(0, 200, 0, 20)
_KeybindPrefab.Image                 = 'rbxassetid://2851929490'
_KeybindPrefab.ImageColor3           = Color3.new(0.203922, 0.207843, 0.219608)
_KeybindPrefab.ScaleType             = Enum.ScaleType.Slice
_KeybindPrefab.SliceCenter           = Rect.new(4, 4, 4, 4)

_KeybindTitle.Name                  = 'Title'
_KeybindTitle.Parent                = _KeybindPrefab
_KeybindTitle.BackgroundColor3      = Color3.new(1, 1, 1)
_KeybindTitle.BackgroundTransparency = 1
_KeybindTitle.Size                  = UDim2.new(0, 0, 1, 0)
_KeybindTitle.Font                  = Enum.Font.GothamBold
_KeybindTitle.Text                  = 'Keybind'
_KeybindTitle.TextColor3            = Color3.new(0.784314, 0.784314, 0.784314)
_KeybindTitle.TextSize              = 14
_KeybindTitle.TextXAlignment        = Enum.TextXAlignment.Left

_KeybindInput.Name                  = 'Input'
_KeybindInput.Parent                = _KeybindPrefab
_KeybindInput.BackgroundColor3      = Color3.new(1, 1, 1)
_KeybindInput.BackgroundTransparency = 1
_KeybindInput.BorderSizePixel       = 0
_KeybindInput.Position              = UDim2.new(1, -85, 0, 2)
_KeybindInput.Size                  = UDim2.new(0, 80, 1, -4)
_KeybindInput.ZIndex                = 2
_KeybindInput.Font                  = Enum.Font.GothamSemibold
_KeybindInput.Text                  = 'RShift'
_KeybindInput.TextColor3            = Color3.new(0.784314, 0.784314, 0.784314)
_KeybindInput.TextSize              = 12
_KeybindInput.TextWrapped           = true

_KeybindInputBg.Name                  = 'Input_Roundify_4px'
_KeybindInputBg.Parent                = _KeybindInput
_KeybindInputBg.BackgroundColor3      = Color3.new(1, 1, 1)
_KeybindInputBg.BackgroundTransparency = 1
_KeybindInputBg.Size                  = UDim2.new(1, 0, 1, 0)
_KeybindInputBg.Image                 = 'rbxassetid://2851929490'
_KeybindInputBg.ImageColor3           = Color3.new(0.290196, 0.294118, 0.313726)
_KeybindInputBg.ScaleType             = Enum.ScaleType.Slice
_KeybindInputBg.SliceCenter           = Rect.new(4, 4, 4, 4)

-- Windows container
_WindowsContainer.Name                  = 'Windows'
_WindowsContainer.Parent                = _ScreenGui
_WindowsContainer.BackgroundColor3      = Color3.new(1, 1, 1)
_WindowsContainer.BackgroundTransparency = 1
_WindowsContainer.Position              = UDim2.new(0, 20, 0, 20)
_WindowsContainer.Size                  = UDim2.new(1, 20, 1, -20)

-- ─── Servicios ────────────────────────────────────────────────────────────────

local _UserInputService = game:GetService('UserInputService')
local _TweenService     = game:GetService('TweenService')
local _RunService       = game:GetService('RunService')
local _Mouse            = game:GetService('Players').LocalPlayer:GetMouse()
local _PrefabsFolder    = _ScreenGui:WaitForChild('Prefabs')
local _Windows          = _ScreenGui:FindFirstChild('Windows')
local _BindingState     = {binding = false}

-- Escucha la tecla de toggle para mostrar/ocultar la UI
_UserInputService.InputBegan:Connect(function(input, _)
    if input.KeyCode == (typeof(Config.toggle_key) == 'EnumItem' and Config.toggle_key or Enum.KeyCode.RightShift)
        and (script.Parent and not _BindingState.binding) then
        script.Parent.Enabled = not script.Parent.Enabled
    end
end)

-- ─── Funciones utilitarias ────────────────────────────────────────────────────

-- Crea y reproduce un tween sobre un objeto
local function tween(object, properties, duration)
    _TweenService:Create(object, TweenInfo.new(duration or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties):Play()
end

-- Convierte RGB (0-255) a HSV
local function rgbToHSV(r, g, b)
    local rn = r / 255
    local gn = g / 255
    local bn = b / 255
    local maxVal = math.max(rn, gn, bn)
    local minVal = math.min(rn, gn, bn)
    local delta  = maxVal - minVal
    local saturation = maxVal == 0 and 0 or delta / maxVal
    local hue

    if maxVal == minVal then
        hue = 0
    else
        local rawHue
        if maxVal == rn then
            rawHue = (gn - bn) / delta
            if gn < bn then rawHue = rawHue + 6 end
        elseif maxVal == gn then
            rawHue = (bn - rn) / delta + 2
        elseif maxVal == bn then
            rawHue = (rn - gn) / delta + 4
        end
        hue = rawHue / 6
    end

    return hue, saturation, maxVal
end

-- Intenta acceder a una propiedad de un objeto de forma segura (pcall)
local function safeGet(object, property)
    local ok, value = pcall(function()
        return object[tostring(property)]
    end)
    if ok then return value end
end

-- Devuelve el ancho ideal de un TextLabel/Button basado en su contenido
local function getTextWidth(label)
    return label.TextBounds.X + 15
end

-- Devuelve la posición actual del mouse, ajustada para la GUI
local function getMousePosition()
    return Vector2.new(
        _UserInputService:GetMouseLocation().X + 1,
        _UserInputService:GetMouseLocation().Y - 35
    )
end

-- Crea el efecto ripple (onda) al hacer click en un elemento
local function createRipple(parent, mouseX, mouseY)
    spawn(function()
        parent.ClipsDescendants = true

        local circle = _PrefabsFolder:FindFirstChild('Circle'):Clone()
        circle.Parent = parent
        circle.ZIndex = 1000

        local localX = mouseX - circle.AbsolutePosition.X
        local localY = mouseY - circle.AbsolutePosition.Y
        circle.Position = UDim2.new(0, localX, 0, localY)

        local diameter = 0
        local absX = parent.AbsoluteSize.X
        local absY = parent.AbsoluteSize.Y
        if absX <= absY then
            diameter = absY * 1.5
        else
            diameter = absX * 1.5
        end

        circle:TweenSizeAndPosition(
            UDim2.new(0, diameter, 0, diameter),
            UDim2.new(0.5, -diameter / 2, 0.5, -diameter / 2),
            'Out', 'Quad', 0.5, false, nil
        )
        tween(circle, {ImageTransparency = 1}, 0.5)
        wait(0.5)
        circle:Destroy()
    end)
end

-- ─── Contador de ventanas (para ZIndex escalonado) ────────────────────────────

local windowCount = 0

-- Reorganiza las ventanas en pantalla según sus posiciones actuales
local function formatWindows()
    local tempLayout = _PrefabsFolder:FindFirstChild('UIListLayout'):Clone()
    tempLayout.Parent = _Windows

    -- Guarda las posiciones absolutas antes de eliminar el layout
    local positions = {}
    for _, child in next, _Windows:GetChildren() do
        if not child:IsA('UIListLayout') then
            positions[child] = child.AbsolutePosition
        end
    end

    tempLayout:Destroy()

    -- Restaura posiciones como UDim2 fijas
    for child, pos in next, positions do
        child.Position = UDim2.new(0, pos.X, 0, pos.Y)
    end
end

-- ─── API pública de la librería ───────────────────────────────────────────────

function Library.FormatWindows(_)
    formatWindows()
end

function Library.AddWindow(_, windowName, windowConfig)
    -- Destruye cualquier ventana anterior con el mismo nombre
    local existing = game:GetService('CoreGui'):FindFirstChild('ui-engine-v2 // ' .. tostring(windowName))
    if existing then
        existing:SetAttribute('dead', true)
        existing:Destroy()
    end

    _ScreenGui.Name = 'ui-engine-v2 // ' .. tostring(windowName)
    _ScreenGui:SetAttribute('dead', false)

    windowCount = windowCount + 1

    local isDropdownOpen = false
    local title = tostring(windowName or 'New Window')

    if typeof(windowConfig) ~= 'table' or not windowConfig then
        windowConfig = Config
    end
    windowConfig.tween_time = 0.1

    -- Clona la ventana desde los prefabs
    local windowFrame = _PrefabsFolder:FindFirstChild('Window'):Clone()
    windowFrame.Parent = _Windows
    windowFrame:FindFirstChild('Title').Text = title
    windowFrame.Size = UDim2.new(0, windowConfig.min_size.X, 0, windowConfig.min_size.Y)
    windowFrame.ZIndex = windowFrame.ZIndex + windowCount * 10

    -- Referencias internas de la ventana
    local titleBar    = windowFrame:FindFirstChild('Bar')
    local barBase     = titleBar:FindFirstChild('Base')
    local barTop      = titleBar:FindFirstChild('Top')
    local tabRowBg    = windowFrame:FindFirstChild('TabSelection'):FindFirstChild('Frame')
    local resizer     = windowFrame:WaitForChild('Resizer')
    local windowAPI   = {}

    -- Mantiene el color de la barra actualizado en cada frame
    spawn(function()
        while true do
            titleBar.BackgroundColor3 = windowConfig.main_color
            barBase.BackgroundColor3  = windowConfig.main_color
            barBase.ImageColor3       = windowConfig.main_color
            barTop.ImageColor3        = windowConfig.main_color
            tabRowBg.BackgroundColor3 = windowConfig.main_color
            _RunService.Heartbeat:Wait()
        end
    end)

    -- ── Resize ────────────────────────────────────────────────────────────────

    windowFrame.Draggable = true

    local savedIcon    = _Mouse.Icon
    local mouseOnResizer = false

    resizer.MouseEnter:Connect(function()
        windowFrame.Draggable = false
        if windowConfig.can_resize then savedIcon = _Mouse.Icon end
        mouseOnResizer = true
    end)
    resizer.MouseLeave:Connect(function()
        mouseOnResizer = false
        if windowConfig.can_resize then _Mouse.Icon = savedIcon end
        windowFrame.Draggable = true
    end)

    local mouseDown = false

    _UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            mouseDown = true
            spawn(function()
                if mouseOnResizer and (resizer.Active and windowConfig.can_resize) then
                    while mouseDown and resizer.Active do
                        local pos  = getMousePosition()
                        local newW = pos.X - windowFrame.AbsolutePosition.X
                        local newH = pos.Y - windowFrame.AbsolutePosition.Y
                        local minW = windowConfig.min_size.X
                        local minH = windowConfig.min_size.Y

                        if minW > newW or minH > newH then
                            if minW > newW and minH > newH then
                                tween(windowFrame, {Size = UDim2.new(0, minW, 0, minH)}, windowConfig.tween_time)
                            elseif minW > newW then
                                tween(windowFrame, {Size = UDim2.new(0, minW, 0, newH)}, windowConfig.tween_time)
                            else
                                tween(windowFrame, {Size = UDim2.new(0, newW, 0, minH)}, windowConfig.tween_time)
                            end
                        else
                            tween(windowFrame, {Size = UDim2.new(0, newW, 0, newH)}, windowConfig.tween_time)
                        end

                        _RunService.Heartbeat:Wait()
                    end
                end
            end)
        end
    end)
    _UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            mouseDown = false
        end
    end)

    -- ── Colapsar/expandir ventana ─────────────────────────────────────────────

    local toggleBtn     = windowFrame:FindFirstChild('Bar'):FindFirstChild('Toggle')
    local windowVisible = true
    local canToggle     = true
    local tabVisibility = {}
    local savedHeight   = windowFrame.AbsoluteSize.Y

    toggleBtn.MouseButton1Click:Connect(function()
        if not canToggle then return end
        canToggle = false

        if windowVisible then
            -- Colapsar: oculta los tabs y achica la ventana
            tabVisibility = {}
            for _, child in next, windowFrame:FindFirstChild('Tabs'):GetChildren() do
                tabVisibility[child] = child.Visible
                child.Visible = false
            end
            resizer.Active = false
            savedHeight = windowFrame.AbsoluteSize.Y

            tween(toggleBtn, {Rotation = 0}, windowConfig.tween_time)
            tween(windowFrame, {Size = UDim2.new(0, windowFrame.AbsoluteSize.X, 0, 26)}, windowConfig.tween_time)
            toggleBtn.Parent:FindFirstChild('Base').Transparency = 1
        else
            -- Expandir: restaura visibilidad de tabs
            for child, wasVisible in next, tabVisibility do
                child.Visible = wasVisible
            end
            resizer.Active = true

            tween(toggleBtn, {Rotation = 90}, windowConfig.tween_time)
            tween(windowFrame, {Size = UDim2.new(0, windowFrame.AbsoluteSize.X, 0, savedHeight)}, windowConfig.tween_time)
            toggleBtn.Parent:FindFirstChild('Base').Transparency = 0
        end

        windowVisible = not windowVisible
        wait(windowConfig.tween_time)
        canToggle = true
    end)

    -- ── Pestañas ──────────────────────────────────────────────────────────────

    local tabsContentArea  = windowFrame:FindFirstChild('Tabs')
    local tabSelectionBar  = windowFrame:FindFirstChild('TabSelection')
    local tabButtonsRow    = tabSelectionBar:FindFirstChild('TabButtons')

    function windowAPI.AddTab(_, tabName)
        local tabAPI    = {}
        local tabLabel  = tostring(tabName or 'New Tab')

        tabSelectionBar.Visible = true

        local tabButton = _PrefabsFolder:FindFirstChild('TabButton'):Clone()
        tabButton.Parent = tabButtonsRow
        tabButton.Text   = tabLabel
        tabButton.Size   = UDim2.new(0, getTextWidth(tabButton), 0, 20)
        tabButton.ZIndex = tabButton.ZIndex + windowCount * 10
        tabButton:GetChildren()[1].ZIndex = tabButton:GetChildren()[1].ZIndex + windowCount * 10

        local tabContent = _PrefabsFolder:FindFirstChild('Tab'):Clone()
        tabContent.Parent = tabsContentArea
        tabContent.ZIndex = tabContent.ZIndex + windowCount * 10

        -- Activa esta pestaña (oculta las demás)
        local function activateTab()
            if isDropdownOpen then return end

            -- Restablece tamaño de todos los botones
            for _, btn in next, tabButtonsRow:GetChildren() do
                if not btn:IsA('UIListLayout') then
                    btn:GetChildren()[1].ImageColor3 = Color3.fromRGB(52, 53, 56)
                    tween(btn, {Size = UDim2.new(0, btn.AbsoluteSize.X, 0, 20)}, windowConfig.tween_time)
                end
            end

            -- Oculta todos los contenidos de tabs
            for _, content in next, tabsContentArea:GetChildren() do
                content.Visible = false
            end

            -- Activa el tab actual
            tween(tabButton, {Size = UDim2.new(0, tabButton.AbsoluteSize.X, 0, 25)}, windowConfig.tween_time)
            tabButton:GetChildren()[1].ImageColor3 = Color3.fromRGB(73, 75, 79)
            tabContent.Visible  = true
            _ScreenGui.Enabled  = true
        end

        tabButton.MouseButton1Click:Connect(activateTab)

        function tabAPI.Show(_)
            activateTab()
        end

        -- ── Elementos del tab ─────────────────────────────────────────────────

        function tabAPI.AddLabel(_, text)
            local labelAPI = {}
            local labelText = tostring(text or 'New Label')
            local label = _PrefabsFolder:FindFirstChild('Label'):Clone()
            label.Parent   = tabContent
            label.Text     = labelText
            label.Size     = UDim2.new(0, getTextWidth(label), 0, 20)
            label.ZIndex   = label.ZIndex + windowCount * 10
            label.RichText = true

            function labelAPI.Update(_, newText)
                label.Text = newText
            end

            return labelAPI
        end

        function tabAPI.AddFolderLabel(_, text)
            local labelText = tostring(text or 'New Label')
            local label = _PrefabsFolder:FindFirstChild('Label'):Clone()
            label.Parent   = tabContent
            label.RichText = true
            label.Text     = labelText
            label.Size     = UDim2.new(0, getTextWidth(label), 0, 20)
            label.ZIndex   = label.ZIndex + windowCount * 10
            return label
        end

        function tabAPI.AddButton(_, buttonText, callback, buttonConfig)
            local text    = tostring(buttonText or 'New Button')
            local onClick = (typeof(callback) ~= 'function' or not callback) and function() end or callback

            local btnConfig = {runOnOpen = false, runOnClosure = false}
            if typeof(buttonConfig) == 'table' and buttonConfig ~= nil then
                btnConfig = buttonConfig
            end

            local button = _PrefabsFolder:FindFirstChild('Button'):Clone()
            button.Parent   = tabContent
            button.Text     = text
            button.RichText = true
            button.Size     = UDim2.new(0, getTextWidth(button), 0, 20)
            button.ZIndex   = button.ZIndex + windowCount * 10
            button:GetChildren()[1].ZIndex = button:GetChildren()[1].ZIndex + windowCount * 10

            spawn(function()
                while true do
                    if button and button:GetChildren()[1] then
                        button:GetChildren()[1].ImageColor3 = windowConfig.main_color
                    end
                    _RunService.Heartbeat:Wait()
                end
            end)

            button.MouseButton1Click:Connect(function()
                createRipple(button, _Mouse.X, _Mouse.Y)
                pcall(onClick)
            end)

            if btnConfig.runOnOpen then pcall(onClick) end

            _ScreenGui:GetAttributeChangedSignal('dead'):Connect(function()
                if _ScreenGui:GetAttribute('dead') == true and btnConfig.runOnClosure then
                    pcall(onClick)
                end
            end)

            return button
        end

        function tabAPI.AddSwitch(_, switchText, callback)
            local switchAPI = {}
            local text      = tostring(switchText or 'New Switch')
            local onChange  = (typeof(callback) ~= 'function' or not callback) and function() end or callback
            local switchBtn = _PrefabsFolder:FindFirstChild('Switch'):Clone()

            switchBtn.Parent = tabContent
            switchBtn:FindFirstChild('Title').Text   = text
            switchBtn:FindFirstChild('Title').ZIndex = switchBtn:FindFirstChild('Title').ZIndex + windowCount * 10
            switchBtn.ZIndex = switchBtn.ZIndex + windowCount * 10
            switchBtn:GetChildren()[1].ZIndex = switchBtn:GetChildren()[1].ZIndex + windowCount * 10

            spawn(function()
                while true do
                    if switchBtn and switchBtn:GetChildren()[1] then
                        switchBtn:GetChildren()[1].ImageColor3 = windowConfig.main_color
                    end
                    _RunService.Heartbeat:Wait()
                end
            end)

            local isOn = false

            switchBtn.MouseButton1Click:Connect(function()
                isOn = not isOn
                switchBtn.Text = isOn and utf8.char(10003) or ''
                pcall(onChange, isOn)
            end)

            function switchAPI.Set(_, value)
                isOn = (typeof(value) == 'boolean') and value or false
                switchBtn.Text = isOn and utf8.char(10003) or ''
                pcall(onChange, isOn)
            end

            _ScreenGui:GetAttributeChangedSignal('dead'):Connect(function()
                if _ScreenGui:GetAttribute('dead') == true then
                    switchAPI:Set(false)
                end
            end)

            return switchAPI, switchBtn
        end

        function tabAPI.AddFolderSwitch(_, switchText, callback)
            local text     = tostring(switchText or 'New Switch')
            local onChange = (typeof(callback) ~= 'function' or not callback) and function() end or callback
            local switchBtn = _PrefabsFolder:FindFirstChild('Switch'):Clone()

            switchBtn.Parent = tabContent
            switchBtn:FindFirstChild('Title').Text   = text
            switchBtn:FindFirstChild('Title').ZIndex = switchBtn:FindFirstChild('Title').ZIndex + windowCount * 10
            switchBtn.ZIndex = switchBtn.ZIndex + windowCount * 10
            switchBtn:GetChildren()[1].ZIndex = switchBtn:GetChildren()[1].ZIndex + windowCount * 10

            spawn(function()
                while true do
                    if switchBtn and switchBtn:GetChildren()[1] then
                        switchBtn:GetChildren()[1].ImageColor3 = windowConfig.main_color
                    end
                    _RunService.Heartbeat:Wait()
                end
            end)

            local isOn = false

            switchBtn.MouseButton1Click:Connect(function()
                isOn = not isOn
                switchBtn.Text = isOn and utf8.char(10003) or ''
                pcall(onChange, isOn)
            end)

            _ScreenGui:GetAttributeChangedSignal('dead'):Connect(function()
                if _ScreenGui:GetAttribute('dead') == true then
                    isOn = false
                    switchBtn.Text = ''
                    pcall(onChange, isOn)
                end
            end)

            return switchBtn
        end

        function tabAPI.AddTextBox(_, placeholder, callback, options)
            local placeholderText = tostring(placeholder or 'New TextBox')
            local onSubmit = (typeof(callback) ~= 'function' or not callback) and function() end or callback
            local opts = {
                clear = ((typeof(options) ~= 'table' or not options) and {clear = true} or options).clear == true,
            }

            local textBox = _PrefabsFolder:FindFirstChild('TextBox'):Clone()
            textBox.Parent          = tabContent
            textBox.PlaceholderText = placeholderText
            textBox.ZIndex          = textBox.ZIndex + windowCount * 10
            textBox:GetChildren()[1].ZIndex = textBox:GetChildren()[1].ZIndex + windowCount * 10

            textBox.FocusLost:Connect(function(enterPressed)
                if enterPressed and #textBox.Text > 0 then
                    pcall(onSubmit, textBox.Text)
                    if opts.clear then textBox.Text = '' end
                end
            end)

            return textBox
        end

        function tabAPI.AddSlider(_, sliderText, callback, sliderOptions)
            local sliderAPI  = {}
            local text       = tostring(sliderText or 'New Slider')
            local onChange   = (typeof(callback) ~= 'function' or not callback) and function() end or callback
            local rawOpts    = (typeof(sliderOptions) ~= 'table' or not sliderOptions) and {} or sliderOptions
            local sliderCfg  = {
                min      = rawOpts.min or 0,
                max      = rawOpts.max or 100,
                readonly = rawOpts.readonly or false,
            }

            local sliderFrame  = _PrefabsFolder:FindFirstChild('Slider'):Clone()
            sliderFrame.Parent = tabContent
            sliderFrame.ZIndex = sliderFrame.ZIndex + windowCount * 10

            local titleLabel     = sliderFrame:FindFirstChild('Title')
            local fillIndicator  = sliderFrame:FindFirstChild('Indicator')
            local valueLabel     = sliderFrame:FindFirstChild('Value')

            titleLabel.ZIndex    = titleLabel.ZIndex + windowCount * 10
            fillIndicator.ZIndex = fillIndicator.ZIndex + windowCount * 10
            valueLabel.ZIndex    = valueLabel.ZIndex + windowCount * 10
            titleLabel.Text      = text

            local mouseOnSlider = false

            sliderFrame.MouseEnter:Connect(function()
                mouseOnSlider = true
                windowFrame.Draggable = false
            end)
            sliderFrame.MouseLeave:Connect(function()
                mouseOnSlider = false
                windowFrame.Draggable = true
            end)

            local sliderMouseDown = false

            _UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    sliderMouseDown = true
                    spawn(function()
                        if mouseOnSlider and not sliderCfg.readonly then
                            while sliderMouseDown and not isDropdownOpen do
                                local pos       = getMousePosition()
                                local rawPct    = (sliderFrame.AbsoluteSize.X - (sliderFrame.AbsoluteSize.X - (pos.X - sliderFrame.AbsolutePosition.X) + 1)) / sliderFrame.AbsoluteSize.X
                                local pct       = math.max(0, math.min(1, rawPct))

                                tween(fillIndicator, {Size = UDim2.new(pct, 0, 0, 20)}, windowConfig.tween_time)

                                local intPct   = math.floor(pct * 100)
                                local range    = sliderCfg.max - sliderCfg.min
                                local value    = math.floor(range / 100 * intPct + sliderCfg.min)

                                valueLabel.Text = tostring(value)
                                pcall(onChange, value)
                                _RunService.Heartbeat:Wait()
                            end
                        end
                    end)
                end
            end)
            _UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    sliderMouseDown = false
                end
            end)

            function sliderAPI.Set(_, value)
                local v = tonumber(value) or 0
                if v < 0 or v > 100 then v = 0 end
                local pct   = v / 100
                local range = sliderCfg.max - sliderCfg.min
                local real  = math.floor(range / 100 * math.floor(pct * 100) + sliderCfg.min)

                tween(fillIndicator, {Size = UDim2.new(pct, 0, 0, 20)}, windowConfig.tween_time)
                valueLabel.Text = tostring(real)
                pcall(onChange, real)
            end

            sliderAPI:Set(sliderCfg.min)
            return sliderAPI, sliderFrame
        end

        function tabAPI.AddKeybind(_, keybindText, callback, keybindOptions)
            local keybindAPI = {}
            local text       = tostring(keybindText or 'New Keybind')
            local onTrigger  = (typeof(callback) ~= 'function' or not callback) and function() end or callback
            local opts       = {
                standard = ((typeof(keybindOptions) ~= 'table' or not keybindOptions) and {} or keybindOptions).standard or Enum.KeyCode.RightShift,
            }

            local keybindFrame = _PrefabsFolder:FindFirstChild('Keybind'):Clone()
            local inputBtn     = keybindFrame:FindFirstChild('Input')
            local titleLabel   = keybindFrame:FindFirstChild('Title')

            keybindFrame.ZIndex = keybindFrame.ZIndex + windowCount * 10
            inputBtn.ZIndex     = inputBtn.ZIndex + windowCount * 10
            inputBtn:GetChildren()[1].ZIndex = inputBtn:GetChildren()[1].ZIndex + windowCount * 10
            titleLabel.ZIndex   = titleLabel.ZIndex + windowCount * 10
            keybindFrame.Parent = tabContent
            titleLabel.Text     = '  ' .. text
            keybindFrame.Size   = UDim2.new(0, getTextWidth(titleLabel) + 80, 0, 20)

            local keyNames = {
                RightControl = 'RightCtrl',
                LeftControl  = 'LeftCtrl',
                LeftShift    = 'LShift',
                RightShift   = 'RShift',
                MouseButton1 = 'Mouse1',
                MouseButton2 = 'Mouse2',
            }
            local currentKey = opts.standard

            function keybindAPI.SetKeybind(_, key)
                inputBtn.Text = keyNames[key.Name] or key.Name
                currentKey = key
            end

            _UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if _BindingState.binding then
                    spawn(function()
                        wait()
                        _BindingState.binding = false
                    end)
                elseif input.KeyCode == currentKey and (not gameProcessed and _ScreenGui) and _ScreenGui:GetAttribute('dead') == false then
                    pcall(onTrigger, currentKey)
                end
            end)

            keybindAPI:SetKeybind(opts.standard)

            inputBtn.MouseButton1Click:Connect(function()
                if not _BindingState.binding then
                    inputBtn.Text = '...'
                    _BindingState.binding = true
                    local newInput, _ = _UserInputService.InputBegan:Wait()
                    keybindAPI:SetKeybind(newInput.KeyCode)
                end
            end)

            return keybindAPI, currentKey
        end

        function tabAPI.AddGuiToggle(_, keybindText, keybindOptions)
            local guiToggleAPI = {}
            local text         = tostring(keybindText or 'New Keybind')
            local opts         = {
                standard = ((typeof(keybindOptions) ~= 'table' or not keybindOptions) and {} or keybindOptions).standard or Enum.KeyCode.RightShift,
            }

            local keybindFrame = _PrefabsFolder:FindFirstChild('Keybind'):Clone()
            local inputBtn     = keybindFrame:FindFirstChild('Input')
            local titleLabel   = keybindFrame:FindFirstChild('Title')

            keybindFrame.ZIndex = keybindFrame.ZIndex + windowCount * 10
            inputBtn.ZIndex     = inputBtn.ZIndex + windowCount * 10
            inputBtn:GetChildren()[1].ZIndex = inputBtn:GetChildren()[1].ZIndex + windowCount * 10
            titleLabel.ZIndex   = titleLabel.ZIndex + windowCount * 10
            keybindFrame.Parent = tabContent
            titleLabel.Text     = '  ' .. text
            keybindFrame.Size   = UDim2.new(0, getTextWidth(titleLabel) + 80, 0, 20)

            local keyNames = {
                RightControl = 'RightCtrl',
                LeftControl  = 'LeftCtrl',
                LeftShift    = 'LShift',
                RightShift   = 'RShift',
                MouseButton1 = 'Mouse1',
                MouseButton2 = 'Mouse2',
            }
            local currentKey = opts.standard

            function guiToggleAPI.SetKeybind(_, key)
                inputBtn.Text = keyNames[key.Name] or key.Name
                currentKey = key
            end

            _UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if _BindingState.binding then
                    spawn(function()
                        wait()
                        _BindingState.binding = false
                    end)
                elseif input.KeyCode == currentKey and (not gameProcessed and _ScreenGui) and _ScreenGui:GetAttribute('dead') == false then
                    _ScreenGui.Enabled = not _ScreenGui.Enabled
                end
            end)

            guiToggleAPI:SetKeybind(opts.standard)

            inputBtn.MouseButton1Click:Connect(function()
                if not _BindingState.binding then
                    inputBtn.Text = '...'
                    _BindingState.binding = true
                    local newInput, _ = _UserInputService.InputBegan:Wait()
                    guiToggleAPI:SetKeybind(newInput.KeyCode)
                end
            end)

            return guiToggleAPI, currentKey
        end

        function tabAPI.AddDropdown(_, dropdownText, callback)
            local dropdownAPI = {}
            local text        = tostring(dropdownText or 'New Dropdown')
            local onChange    = (typeof(callback) ~= 'function' or not callback) and function() end or callback

            local dropdownBtn  = _PrefabsFolder:FindFirstChild('Dropdown'):Clone()
            local dropdownBox  = dropdownBtn:FindFirstChild('Box')
            local itemsScroll  = dropdownBox:FindFirstChild('Objects')
            local arrowIcon    = dropdownBtn:FindFirstChild('Indicator')

            dropdownBtn.ZIndex  = dropdownBtn.ZIndex + windowCount * 10
            dropdownBox.ZIndex  = dropdownBox.ZIndex + windowCount * 10
            itemsScroll.ZIndex  = itemsScroll.ZIndex + windowCount * 10
            arrowIcon.ZIndex    = arrowIcon.ZIndex + windowCount * 10
            dropdownBtn:GetChildren()[3].ZIndex = dropdownBtn:GetChildren()[3].ZIndex + windowCount * 10
            dropdownBtn.Parent  = tabContent
            dropdownBtn.Text    = '      ' .. text
            dropdownBox.Size    = UDim2.new(1, 0, 0, 0)

            local expanded = false

            dropdownBtn.MouseButton1Click:Connect(function()
                expanded = not expanded

                local itemCount = #itemsScroll:GetChildren() - 1
                local boxHeight = itemCount * 20

                if itemCount >= 10 then
                    itemsScroll.CanvasSize = UDim2.new(0, 0, itemCount * 0.1, 0)
                    boxHeight = 200
                end

                if expanded then
                    if isDropdownOpen then return end
                    isDropdownOpen = true
                    tween(dropdownBox, {Size = UDim2.new(1, 0, 0, boxHeight)}, windowConfig.tween_time)
                    tween(arrowIcon, {Rotation = 90}, windowConfig.tween_time)
                else
                    isDropdownOpen = false
                    tween(dropdownBox, {Size = UDim2.new(1, 0, 0, 0)}, windowConfig.tween_time)
                    tween(arrowIcon, {Rotation = -90}, windowConfig.tween_time)
                end
            end)

            function dropdownAPI.Add(_, itemText)
                local itemAPI   = {}
                local label     = tostring(itemText or 'New Object')
                local itemBtn   = _PrefabsFolder:FindFirstChild('DropdownButton'):Clone()

                itemBtn.Parent  = itemsScroll
                itemBtn.Text    = label
                itemBtn.ZIndex  = itemBtn.ZIndex + windowCount * 10

                itemBtn.MouseEnter:Connect(function()
                    itemBtn.BackgroundColor3 = windowConfig.main_color
                end)
                itemBtn.MouseLeave:Connect(function()
                    itemBtn.BackgroundColor3 = Color3.fromRGB(33, 34, 36)
                end)

                if expanded then
                    local count = #itemsScroll:GetChildren() - 1
                    local h     = count * 20
                    if count >= 10 then
                        itemsScroll.CanvasSize = UDim2.new(0, 0, count * 0.1, 0)
                        h = 200
                    end
                    tween(dropdownBox, {Size = UDim2.new(1, 0, 0, h)}, windowConfig.tween_time)
                end

                itemBtn.MouseButton1Click:Connect(function()
                    if isDropdownOpen then
                        dropdownBtn.Text = '      [ ' .. label .. ' ]'
                        isDropdownOpen   = false
                        expanded         = false
                        tween(dropdownBox, {Size = UDim2.new(1, 0, 0, 0)}, windowConfig.tween_time)
                        tween(arrowIcon, {Rotation = -90}, windowConfig.tween_time)
                        pcall(onChange, label)
                    end
                end)

                function itemAPI.Remove(_)
                    itemBtn:Destroy()
                end

                return itemBtn, itemAPI
            end

            return dropdownAPI, dropdownBtn
        end

        function tabAPI.AddColorPicker(_, callback)
            local colorAPI  = {}
            local onChange  = (typeof(callback) ~= 'function' or not callback) and function() end or callback
            local picker    = _PrefabsFolder:FindFirstChild('ColorPicker'):Clone()

            picker.Parent = tabContent
            picker.ZIndex = picker.ZIndex + windowCount * 10

            local palette    = picker:FindFirstChild('Palette')
            local sample     = picker:FindFirstChild('Sample')
            local saturation = picker:FindFirstChild('Saturation')

            palette.ZIndex    = palette.ZIndex + windowCount * 10
            sample.ZIndex     = sample.ZIndex + windowCount * 10
            saturation.ZIndex = saturation.ZIndex + windowCount * 10

            local hue   = 0
            local sat   = 1
            local val   = 1

            local function updateColor()
                local color = Color3.fromHSV(hue, sat, val)
                sample.ImageColor3     = color
                saturation.ImageColor3 = Color3.fromHSV(hue, 1, 1)
                pcall(onChange, color)
            end

            sample.ImageColor3     = Color3.fromHSV(hue, sat, val)
            saturation.ImageColor3 = Color3.fromHSV(hue, 1, 1)

            local paletteHover    = false
            local saturationHover = false

            palette.MouseEnter:Connect(function()
                windowFrame.Draggable = false
                paletteHover = true
            end)
            palette.MouseLeave:Connect(function()
                windowFrame.Draggable = true
                paletteHover = false
            end)
            saturation.MouseEnter:Connect(function()
                windowFrame.Draggable = false
                saturationHover = true
            end)
            saturation.MouseLeave:Connect(function()
                windowFrame.Draggable = true
                saturationHover = false
            end)

            local paletteIndicator   = palette:FindFirstChild('Indicator')
            local satIndicator       = saturation:FindFirstChild('Indicator')

            paletteIndicator.ZIndex  = paletteIndicator.ZIndex + windowCount * 10
            satIndicator.ZIndex      = satIndicator.ZIndex + windowCount * 10

            local colorMouseDown = false

            _UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    colorMouseDown = true
                    spawn(function()
                        -- Arrastrar en la paleta 2D
                        while colorMouseDown and (paletteHover and not isDropdownOpen) do
                            local pos  = getMousePosition()
                            local relX = palette.AbsoluteSize.X - (pos.X - palette.AbsolutePosition.X) + 1
                            local relY = palette.AbsoluteSize.Y - (pos.Y - palette.AbsolutePosition.Y) + 1.5

                            hue = relX / 100
                            sat = relY / 100

                            tween(paletteIndicator, {
                                Position = UDim2.new(0, math.abs(relX - 100) - paletteIndicator.AbsoluteSize.X / 2,
                                                     0, math.abs(relY - 100) - paletteIndicator.AbsoluteSize.Y / 2),
                            }, windowConfig.tween_time)
                            updateColor()
                            _RunService.Heartbeat:Wait()
                        end
                        -- Arrastrar en la barra de saturación
                        while colorMouseDown and (saturationHover and not isDropdownOpen) do
                            local pos  = getMousePosition()
                            local relY = palette.AbsoluteSize.Y - (pos.Y - palette.AbsolutePosition.Y) + 1.5

                            val = relY / 100

                            tween(satIndicator, {
                                Position = UDim2.new(0, 0, 0, math.abs(relY - 100)),
                            }, windowConfig.tween_time)
                            updateColor()
                            _RunService.Heartbeat:Wait()
                        end
                    end)
                end
            end)
            _UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    colorMouseDown = false
                end
            end)

            function colorAPI.Set(_, color)
                if typeof(color) ~= 'Color3' or not color then
                    color = Color3.new(1, 1, 1)
                end
                local h, _, _ = rgbToHSV(color.r * 255, color.g * 255, color.b * 255)
                sample.ImageColor3     = color
                saturation.ImageColor3 = Color3.fromHSV(h, 1, 1)
                pcall(onChange, color)
            end

            return colorAPI, picker
        end

        function tabAPI.AddConsole(_, consoleOptions)
            local rawOpts = (typeof(consoleOptions) ~= 'table' or not consoleOptions) and {readonly = true, full = false} or consoleOptions
            local opts    = {
                y        = tonumber(rawOpts.y) or 200,
                source   = rawOpts.source or 'Logs',
                readonly = rawOpts.readonly == true,
                full     = rawOpts.full == true,
            }

            local consoleFrame = _PrefabsFolder:FindFirstChild('Console'):Clone()
            consoleFrame.Parent = tabContent
            consoleFrame.ZIndex = consoleFrame.ZIndex + windowCount * 10
            consoleFrame.Size   = UDim2.new(1, 0, opts.full and 1 or 0, opts.y)

            local scrollFrame   = consoleFrame:GetChildren()[1]
            local sourceBox     = scrollFrame:FindFirstChild('Source')
            local lineNumbers   = scrollFrame:FindFirstChild('Lines')

            sourceBox.ZIndex       = sourceBox.ZIndex + windowCount * 10
            lineNumbers.ZIndex     = lineNumbers.ZIndex + windowCount * 10
            sourceBox.TextEditable = not opts.readonly

            -- Aplica ZIndex a las capas de syntax highlight
            local consoleAPI = {}
            for _, layer in next, sourceBox:GetChildren() do
                layer.ZIndex = layer.ZIndex + windowCount * 10 + 1
            end
            sourceBox.Comments.ZIndex = sourceBox.Comments.ZIndex + 1

            -- Listas de palabras para el resaltado de sintaxis
            local luaKeywords = {
                'and','break','do','else','elseif','end','false','for',
                'function','goto','if','in','local','nil','not','or',
                'repeat','return','then','true','until','while',
            }
            local luaGlobals = {
                'getrawmetatable','newcclosure','islclosure','setclipboard',
                'game','workspace','script','math','string','table','print',
                'wait','BrickColor','Color3','next','pairs','ipairs','select',
                'unpack','Instance','Vector2','Vector3','CFrame','Ray','UDim2',
                'Enum','assert','error','warn','tick','loadstring','_G','shared',
                'getfenv','setfenv','newproxy','setmetatable','getmetatable',
                'os','debug','pcall','ypcall','xpcall','rawequal','rawset',
                'rawget','tonumber','tostring','type','typeof','_VERSION',
                'coroutine','delay','require','spawn','LoadLibrary','settings',
                'stats','time','UserSettings','version','Axes','ColorSequence',
                'Faces','ColorSequenceKeypoint','NumberRange','NumberSequence',
                'NumberSequenceKeypoint','gcinfo','elapsedTime','collectgarbage',
                'PhysicalProperties','Rect','Region3','Region3int16','UDim',
                'Vector2int16','Vector3int16','load','fire','Fire',
            }

            -- Filtra un texto para dejar solo las palabras que pertenezcan a una lista
            local function filterWordsIn(text, wordList)
                local wordSet   = {}
                local operators = {['=']=true,['.']=true,[',']=true,['(']=true,[')']=true,['[']=true,[']']=true,['{']=true,['}']=true,[':']=true,['*']=true,['/']=true,['+']=true,['-']=true,['%']=true,[';']=true,['~']=true}
                for _, w in pairs(wordList) do wordSet[w] = true end
                return text:gsub('.', function(c)
                    return operators[c] and ' ' or c
                end):gsub('%S+', function(word)
                    return wordSet[word] == nil and (' '):rep(#word) or word
                end)
            end

            -- Deja solo los operadores, preservando saltos de línea
            local function keepOnlyOperators(text)
                local operators = {['=']=true,['.']=true,[',']=true,['(']=true,[')']=true,['[']=true,[']']=true,['{']=true,['}']=true,[':']=true,['*']=true,['/']=true,['+']=true,['-']=true,['%']=true,[';']=true,['~']=true}
                local result = ''
                text:gsub('.', function(c)
                    if operators[c] == nil then
                        result = result .. (c == '\n' and '\n' or (c == '\t' and '\t' or ' '))
                    else
                        result = result .. c
                    end
                end)
                return result
            end

            -- Extrae solo el contenido de strings con comillas dobles
            local function extractStrings(text)
                local result  = ''
                local inString = false
                text:gsub('.', function(c)
                    if inString or c == '"' then
                        if inString and c == '"' then inString = false end
                    else
                        inString = true
                    end
                    if inString or c == '"' then
                        if c == '\n' then result = result .. '\n'
                        elseif c == '\t' then result = result .. '\t'
                        elseif inString == true then result = result .. c
                        else result = result .. '"'
                        end
                    else
                        result = result .. (c == '\n' and '\n' or (c == '\t' and '\t' or ' '))
                    end
                end)
                return result
            end

            -- Extrae contenido entre corchetes (para info highlight)
            local function extractBracketed(text)
                local result    = ''
                local inBracket = false
                text:gsub('.', function(c)
                    if inBracket or c == '[' then
                        if inBracket and c == ']' then inBracket = false end
                    else
                        inBracket = true
                    end
                    if inBracket or c == ']' then
                        if c == '\n' then result = result .. '\n'
                        elseif c == '\t' then result = result .. '\t'
                        elseif inBracket == true then result = result .. c
                        else result = result .. ']'
                        end
                    else
                        result = result .. (c == '\n' and '\n' or (c == '\t' and '\t' or ' '))
                    end
                end)
                return result
            end

            -- Extrae solo los comentarios (-- hasta fin de línea)
            local function extractComments(text)
                local result = ''
                text:gsub('[^\r\n]+', function(line)
                    local inComment = false
                    local charIndex = 0
                    line:gsub('.', function(c)
                        charIndex = charIndex + 1
                        if line:sub(charIndex, charIndex + 1) == '--' then inComment = true end
                        result = result .. (inComment and c or ' ')
                    end)
                end)
                return result
            end

            -- Deja solo dígitos (para resaltar números)
            local function extractNumbers(text)
                local result = ''
                text:gsub('.', function(c)
                    if tonumber(c) == nil then
                        result = result .. (c == '\n' and '\n' or (c == '\t' and '\t' or ' '))
                    else
                        result = result .. c
                    end
                end)
                return result
            end

            -- Actualiza el resaltado de sintaxis para Lua
            local function updateLuaSyntax(property)
                if property ~= 'Text' then return end

                sourceBox.Text = sourceBox.Text:gsub('\r', '')
                sourceBox.Text = sourceBox.Text:gsub('\t', '      ')

                local rawText = sourceBox.Text

                sourceBox.Keywords.Text       = filterWordsIn(rawText, luaKeywords)
                sourceBox.Globals.Text        = filterWordsIn(rawText, luaGlobals)
                sourceBox.RemoteHighlight.Text = filterWordsIn(rawText, {'FireServer','fireServer','InvokeServer','invokeServer'})
                sourceBox.Tokens.Text         = keepOnlyOperators(rawText)
                sourceBox.Numbers.Text        = extractNumbers(rawText)
                sourceBox.Strings.Text        = extractStrings(rawText)
                sourceBox.Comments.Text       = extractComments(rawText)

                -- Actualiza los números de línea
                local lineCount = 1
                rawText:gsub('\n', function() lineCount = lineCount + 1 end)

                lineNumbers.Text = ''
                for i = 1, lineCount do
                    lineNumbers.Text = lineNumbers.Text .. i .. '\n'
                end

                scrollFrame.CanvasSize = UDim2.new(0, 0, lineCount * 0.153846154, 0)
            end

            -- Actualiza el resaltado de sintaxis para Logs (formato [bracket])
            local function highlight_logs(property)
                if property ~= 'Text' then return end

                sourceBox.Text = sourceBox.Text:gsub('\r', '')
                sourceBox.Text = sourceBox.Text:gsub('\t', '      ')

                local rawText = sourceBox.Text
                sourceBox.Info.Text = extractBracketed(rawText)

                local lineCount = 1
                rawText:gsub('\n', function() lineCount = lineCount + 1 end)

                scrollFrame.CanvasSize = UDim2.new(0, 0, lineCount * 0.153846154, 0)
            end

            if opts.source ~= 'Lua' then
                if opts.source == 'Logs' then
                    lineNumbers.Visible = false
                    highlight_logs('Text')
                    sourceBox.Changed:Connect(highlight_logs)
                end
            else
                updateLuaSyntax('Text')
                sourceBox.Changed:Connect(updateLuaSyntax)
            end

            function consoleAPI.Set(_, text)
                sourceBox.Text = tostring(text)
            end
            function consoleAPI.Get(_)
                return sourceBox.Text
            end
            function consoleAPI.Log(_, text)
                sourceBox.Text = sourceBox.Text .. '[*] ' .. tostring(text) .. '\n'
            end

            return consoleAPI, consoleFrame
        end

        function tabAPI.AddHorizontalAlignment(_)
            local hAlignAPI = {}
            local hAlignFrame = _PrefabsFolder:FindFirstChild('HorizontalAlignment'):Clone()
            hAlignFrame.Parent = tabContent

            function hAlignAPI.AddButton(_, ...)
                local results = {tabAPI:AddButton(...)}

                if typeof(results[1]) ~= 'table' then
                    results[1].Parent = hAlignFrame
                    return results[1]
                end

                results[2].Parent = hAlignFrame
                return results[1], results[2]
            end

            return hAlignAPI, hAlignFrame
        end

        function tabAPI.AddFolder(_, folderName)
            local folderAPI   = {}
            local label       = tostring(folderName or 'New Folder')
            local folderFrame = _PrefabsFolder:FindFirstChild('Folder'):Clone()
            local folderBtn   = folderFrame:FindFirstChild('Button')
            local itemsFrame  = folderFrame:FindFirstChild('Objects')
            local toggleIcon  = folderBtn:FindFirstChild('Toggle')

            folderFrame.ZIndex = folderFrame.ZIndex + windowCount * 10
            folderBtn.ZIndex   = folderBtn.ZIndex + windowCount * 10
            itemsFrame.ZIndex  = itemsFrame.ZIndex + windowCount * 10
            toggleIcon.ZIndex  = toggleIcon.ZIndex + windowCount * 10
            folderBtn:GetChildren()[1].ZIndex = folderBtn:GetChildren()[1].ZIndex + windowCount * 10

            folderFrame.Parent = tabContent
            folderBtn.Text     = '         ' .. label

            spawn(function()
                while true do
                    if folderBtn and folderBtn:GetChildren()[1] then
                        folderBtn:GetChildren()[1].ImageColor3 = windowConfig.main_color
                    end
                    _RunService.Heartbeat:Wait()
                end
            end)

            -- Calcula la altura total de los elementos del folder
            local function getFolderHeight()
                local height = 25
                for _, child in next, itemsFrame:GetChildren() do
                    if not child:IsA('UIListLayout') then
                        height = height + child.AbsoluteSize.Y + 5
                    end
                end
                return height
            end

            local folderOpen = false

            folderBtn.MouseButton1Click:Connect(function()
                if folderOpen then
                    tween(toggleIcon, {Rotation = 0}, windowConfig.tween_time)
                    itemsFrame.Visible = false
                else
                    tween(toggleIcon, {Rotation = 90}, windowConfig.tween_time)
                    itemsFrame.Visible = true
                end
                folderOpen = not folderOpen
            end)

            spawn(function()
                while true do
                    tween(folderFrame, {
                        Size = UDim2.new(1, 0, 0, folderOpen and getFolderHeight() or 20),
                    }, windowConfig.tween_time)
                    wait()
                end
            end)

            -- Proxy: todos los métodos del tabAPI se redirigen al folder
            for methodName, method in next, tabAPI do
                folderAPI[methodName] = function(...)
                    local results = {method(...)}

                    if typeof(results[1]) ~= 'table' then
                        results[1].Parent = itemsFrame
                        return results[1]
                    end

                    results[2].Parent = itemsFrame
                    return results[1], results[2]
                end
            end

            return folderAPI, folderFrame
        end

        return tabAPI, tabContent
    end

    -- Ajusta el ZIndex de todos los descendientes de la ventana
    for _, descendant in next, windowFrame:GetDescendants() do
        if safeGet(descendant, 'ZIndex') then
            descendant.ZIndex = descendant.ZIndex + windowCount * 10
        end
    end

    return windowAPI, windowFrame
end

return Library
