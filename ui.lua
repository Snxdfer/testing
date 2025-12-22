local v1 = {
    version = 1.3
}
local vu2 = {
    main_color = Color3.fromRGB(41, 74, 122),
    min_size = Vector2.new(400, 300),
    toggle_key = Enum.KeyCode.RightShift,
    can_resize = true
}
warn("running on Library version // " .. tostring(v1.version) .. "\n\r\n\t         _                     _                    ___ \r\n\t  __  __(_)  ___  ____  ____ _(_)___  ___     _   _|__ \\\r\n\t / / / / /  / _ \\/ __ \\/ __ `/ / __ \\/ _ \\   | | / /_/ /\r\n\t/ /_/ / /  /  __/ / / / /_/ / / / / /  __/   | |/ / __/ \r\n\t\\__,_/_/   \\___/_/ /_/\\__, /_/_/ /_/\\___/    |___/____/ \r\n\t\t\t\t\t\t/____/                             \r\n\r\n\tby Singularity (V3rm @ King Singularity) (Discord @ Singularity#5490)\r\n\t[Edited version by KaterHub]\r\n")
local vu3 = Instance.new("ScreenGui")
local v4 = Instance.new("Frame")
local v5 = Instance.new("TextLabel")
local v6 = Instance.new("ImageLabel")
local v7 = Instance.new("Frame")
local v8 = Instance.new("Frame")
local v9 = Instance.new("ImageButton")
local v10 = Instance.new("ImageLabel")
local v11 = Instance.new("ImageLabel")
local v12 = Instance.new("Frame")
local v13 = Instance.new("TextLabel")
local v14 = Instance.new("ImageLabel")
local v15 = Instance.new("Frame")
local v16 = Instance.new("UIListLayout")
local v17 = Instance.new("Frame")
local v18 = Instance.new("Frame")
local v19 = Instance.new("UIListLayout")
local v20 = Instance.new("TextBox")
local v21 = Instance.new("ImageLabel")
local v22 = Instance.new("ImageLabel")
local v23 = Instance.new("TextLabel")
local v24 = Instance.new("ImageLabel")
local v25 = Instance.new("TextLabel")
local v26 = Instance.new("TextLabel")
local v27 = Instance.new("TextLabel")
local v28 = Instance.new("ImageLabel")
local v29 = Instance.new("UIListLayout")
local v30 = Instance.new("TextButton")
local v31 = Instance.new("ImageLabel")
local v32 = Instance.new("ImageButton")
local v33 = Instance.new("ScrollingFrame")
local v34 = Instance.new("UIListLayout")
local v35 = Instance.new("ImageLabel")
local v36 = Instance.new("TextButton")
local v37 = Instance.new("ImageLabel")
local v38 = Instance.new("ImageLabel")
local v39 = Instance.new("TextButton")
local v40 = Instance.new("ImageLabel")
local v41 = Instance.new("ImageLabel")
local v42 = Instance.new("Frame")
local v43 = Instance.new("UIListLayout")
local v44 = Instance.new("Frame")
local v45 = Instance.new("UIListLayout")
local v46 = Instance.new("ImageLabel")
local v47 = Instance.new("ScrollingFrame")
local v48 = Instance.new("TextBox")
local v49 = Instance.new("TextLabel")
local v50 = Instance.new("TextLabel")
local v51 = Instance.new("TextLabel")
local v52 = Instance.new("TextLabel")
local v53 = Instance.new("TextLabel")
local v54 = Instance.new("TextLabel")
local v55 = Instance.new("TextLabel")
local v56 = Instance.new("TextLabel")
local v57 = Instance.new("TextLabel")
local v58 = Instance.new("ImageLabel")
local v59 = Instance.new("ImageLabel")
local v60 = Instance.new("ImageLabel")
local v61 = Instance.new("ImageLabel")
local v62 = Instance.new("ImageLabel")
local v63 = Instance.new("Frame")
local v64 = Instance.new("TextButton")
local v65 = Instance.new("ImageLabel")
local v66 = Instance.new("TextLabel")
local v67 = Instance.new("TextButton")
local v68 = Instance.new("ImageLabel")
local v69 = Instance.new("TextButton")
local v70 = Instance.new("ImageLabel")
local v71 = Instance.new("TextLabel")
local v72 = Instance.new("TextButton")
local v73 = Instance.new("ImageLabel")
local v74 = Instance.new("Frame")
vu3.Name = "ui-engine-v2"
vu3.Parent = game:GetService("CoreGui")
vu3.Enabled = false
local v75 = vu3
vu3.SetAttribute(v75, "dead", false)
v4.Name = "Prefabs"
v4.Parent = vu3
v4.BackgroundColor3 = Color3.new(1, 1, 1)
v4.Size = UDim2.new(0, 100, 0, 100)
v4.Visible = false
v5.Name = "Label"
v5.Parent = v4
v5.BackgroundColor3 = Color3.new(1, 1, 1)
v5.BackgroundTransparency = 1
v5.Size = UDim2.new(0, 200, 0, 20)
v5.Font = Enum.Font.GothamSemibold
v5.Text = "Hello, world 123"
v5.TextColor3 = Color3.new(1, 1, 1)
v5.TextSize = 14
v5.TextXAlignment = Enum.TextXAlignment.Left
v6.Name = "Window"
v6.Parent = v4
v6.Active = true
v6.BackgroundColor3 = Color3.new(1, 1, 1)
v6.BackgroundTransparency = 1
v6.ClipsDescendants = true
v6.Position = UDim2.new(0, 20, 0, 20)
v6.Selectable = true
v6.Size = UDim2.new(0, 200, 0, 200)
v6.Image = "rbxassetid://2851926732"
v6.ImageColor3 = Color3.new(0.0823529, 0.0862745, 0.0901961)
v6.ScaleType = Enum.ScaleType.Slice
v6.SliceCenter = Rect.new(12, 12, 12, 12)
v7.Name = "Resizer"
v7.Parent = v6
v7.Active = true
v7.BackgroundColor3 = Color3.new(1, 1, 1)
v7.BackgroundTransparency = 1
v7.BorderSizePixel = 0
v7.Position = UDim2.new(1, - 20, 1, - 20)
v7.Size = UDim2.new(0, 20, 0, 20)
v8.Name = "Bar"
v8.Parent = v6
v8.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
v8.BorderSizePixel = 0
v8.Position = UDim2.new(0, 0, 0, 5)
v8.Size = UDim2.new(1, 0, 0, 15)
v9.Name = "Toggle"
v9.Parent = v8
v9.BackgroundColor3 = Color3.new(1, 1, 1)
v9.BackgroundTransparency = 1
v9.Position = UDim2.new(0, 5, 0, - 2)
v9.Rotation = 90
v9.Size = UDim2.new(0, 20, 0, 20)
v9.ZIndex = 2
v9.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"
v10.Name = "Base"
v10.Parent = v8
v10.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
v10.BorderSizePixel = 0
v10.Position = UDim2.new(0, 0, 0.800000012, 0)
v10.Size = UDim2.new(1, 0, 0, 10)
v10.Image = "rbxassetid://2851926732"
v10.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
v10.ScaleType = Enum.ScaleType.Slice
v10.SliceCenter = Rect.new(12, 12, 12, 12)
v11.Name = "Top"
v11.Parent = v8
v11.BackgroundColor3 = Color3.new(1, 1, 1)
v11.BackgroundTransparency = 1
v11.Position = UDim2.new(0, 0, 0, - 5)
v11.Size = UDim2.new(1, 0, 0, 10)
v11.Image = "rbxassetid://2851926732"
v11.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
v11.ScaleType = Enum.ScaleType.Slice
v11.SliceCenter = Rect.new(12, 12, 12, 12)
v12.Name = "Tabs"
v12.Parent = v6
v12.BackgroundColor3 = Color3.new(1, 1, 1)
v12.BackgroundTransparency = 1
v12.Position = UDim2.new(0, 15, 0, 60)
v12.Size = UDim2.new(1, - 30, 1, - 60)
v13.Name = "Title"
v13.Parent = v6
v13.BackgroundColor3 = Color3.new(1, 1, 1)
v13.BackgroundTransparency = 1
v13.Position = UDim2.new(0, 30, 0, 3)
v13.Size = UDim2.new(0, 200, 0, 20)
v13.Font = Enum.Font.GothamBold
v13.Text = "Gamer Time"
v13.TextColor3 = Color3.new(1, 1, 1)
v13.TextSize = 14
v13.TextXAlignment = Enum.TextXAlignment.Left
v14.Name = "TabSelection"
v14.Parent = v6
v14.BackgroundColor3 = Color3.new(1, 1, 1)
v14.BackgroundTransparency = 1
v14.Position = UDim2.new(0, 15, 0, 30)
v14.Size = UDim2.new(1, - 30, 0, 25)
v14.Visible = false
v14.Image = "rbxassetid://2851929490"
v14.ImageColor3 = Color3.new(0.145098, 0.14902, 0.156863)
v14.ScaleType = Enum.ScaleType.Slice
v14.SliceCenter = Rect.new(4, 4, 4, 4)
v15.Name = "TabButtons"
v15.Parent = v14
v15.BackgroundColor3 = Color3.new(1, 1, 1)
v15.BackgroundTransparency = 1
v15.Size = UDim2.new(1, 0, 1, 0)
v16.Parent = v15
v16.FillDirection = Enum.FillDirection.Horizontal
v16.SortOrder = Enum.SortOrder.LayoutOrder
v16.Padding = UDim.new(0, 2)
v17.Parent = v14
v17.BackgroundColor3 = Color3.new(0.12549, 0.227451, 0.372549)
v17.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
v17.BorderSizePixel = 0
v17.Position = UDim2.new(0, 0, 1, 0)
v17.Size = UDim2.new(1, 0, 0, 2)
v18.Name = "Tab"
v18.Parent = v4
v18.BackgroundColor3 = Color3.new(1, 1, 1)
v18.BackgroundTransparency = 1
v18.Size = UDim2.new(1, 0, 1, 0)
v18.Visible = false
v19.Parent = v18
v19.SortOrder = Enum.SortOrder.LayoutOrder
v19.Padding = UDim.new(0, 5)
v20.Parent = v4
v20.BackgroundColor3 = Color3.new(1, 1, 1)
v20.BackgroundTransparency = 1
v20.BorderSizePixel = 0
v20.Size = UDim2.new(1, 0, 0, 20)
v20.ZIndex = 2
v20.Font = Enum.Font.GothamSemibold
v20.PlaceholderColor3 = Color3.new(0.698039, 0.698039, 0.698039)
v20.PlaceholderText = "Input Text"
v20.Text = ""
v20.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
v20.TextSize = 14
v21.Name = "TextBox_Roundify_4px"
v21.Parent = v20
v21.BackgroundColor3 = Color3.new(1, 1, 1)
v21.BackgroundTransparency = 1
v21.Size = UDim2.new(1, 0, 1, 0)
v21.Image = "rbxassetid://2851929490"
v21.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
v21.ScaleType = Enum.ScaleType.Slice
v21.SliceCenter = Rect.new(4, 4, 4, 4)
v22.Name = "Slider"
v22.Parent = v4
v22.BackgroundColor3 = Color3.new(1, 1, 1)
v22.BackgroundTransparency = 1
v22.Position = UDim2.new(0, 0, 0.178571433, 0)
v22.Size = UDim2.new(1, 0, 0, 20)
v22.Image = "rbxassetid://2851929490"
v22.ImageColor3 = Color3.new(0.145098, 0.14902, 0.156863)
v22.ScaleType = Enum.ScaleType.Slice
v22.SliceCenter = Rect.new(4, 4, 4, 4)
v23.Name = "Title"
v23.Parent = v22
v23.BackgroundColor3 = Color3.new(1, 1, 1)
v23.BackgroundTransparency = 1
v23.Position = UDim2.new(0.5, 0, 0.5, - 10)
v23.Size = UDim2.new(0, 0, 0, 20)
v23.ZIndex = 2
v23.Font = Enum.Font.GothamBold
v23.Text = "Slider"
v23.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
v23.TextSize = 14
v24.Name = "Indicator"
v24.Parent = v22
v24.BackgroundColor3 = Color3.new(1, 1, 1)
v24.BackgroundTransparency = 1
v24.Size = UDim2.new(0, 0, 0, 20)
v24.Image = "rbxassetid://2851929490"
v24.ImageColor3 = Color3.new(0.254902, 0.262745, 0.278431)
v24.ScaleType = Enum.ScaleType.Slice
v24.SliceCenter = Rect.new(4, 4, 4, 4)
v25.Name = "Value"
v25.Parent = v22
v25.BackgroundColor3 = Color3.new(1, 1, 1)
v25.BackgroundTransparency = 1
v25.Position = UDim2.new(1, - 55, 0.5, - 10)
v25.Size = UDim2.new(0, 50, 0, 20)
v25.Font = Enum.Font.GothamBold
v25.Text = "0%"
v25.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
v25.TextSize = 14
v26.Parent = v22
v26.BackgroundColor3 = Color3.new(1, 1, 1)
v26.BackgroundTransparency = 1
v26.Position = UDim2.new(1, - 20, - 0.75, 0)
v26.Size = UDim2.new(0, 26, 0, 50)
v26.Font = Enum.Font.GothamBold
v26.Text = "]"
v26.TextColor3 = Color3.new(0.627451, 0.627451, 0.627451)
v26.TextSize = 14
v27.Parent = v22
v27.BackgroundColor3 = Color3.new(1, 1, 1)
v27.BackgroundTransparency = 1
v27.Position = UDim2.new(1, - 65, - 0.75, 0)
v27.Size = UDim2.new(0, 26, 0, 50)
v27.Font = Enum.Font.GothamBold
v27.Text = "["
v27.TextColor3 = Color3.new(0.627451, 0.627451, 0.627451)
v27.TextSize = 14
v28.Name = "Circle"
v28.Parent = v4
v28.BackgroundColor3 = Color3.new(1, 1, 1)
v28.BackgroundTransparency = 1
v28.Image = "rbxassetid://266543268"
v28.ImageTransparency = 0.5
v29.Parent = v4
v29.FillDirection = Enum.FillDirection.Horizontal
v29.SortOrder = Enum.SortOrder.LayoutOrder
v29.Padding = UDim.new(0, 20)
v30.Name = "Dropdown"
v30.Parent = v4
v30.BackgroundColor3 = Color3.new(1, 1, 1)
v30.BackgroundTransparency = 1
v30.BorderSizePixel = 0
v30.Position = UDim2.new(- 0.055555556, 0, 0.0833333284, 0)
v30.Size = UDim2.new(0, 200, 0, 20)
v30.ZIndex = 2
v30.Font = Enum.Font.GothamBold
v30.Text = "      Dropdown"
v30.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
v30.TextSize = 14
v30.TextXAlignment = Enum.TextXAlignment.Left
v31.Name = "Indicator"
v31.Parent = v30
v31.BackgroundColor3 = Color3.new(1, 1, 1)
v31.BackgroundTransparency = 1
v31.Position = UDim2.new(0.899999976, - 10, 0.100000001, 0)
v31.Rotation = - 90
v31.Size = UDim2.new(0, 15, 0, 15)
v31.ZIndex = 2
v31.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4744658743"
v32.Name = "Box"
v32.Parent = v30
v32.BackgroundColor3 = Color3.new(1, 1, 1)
v32.BackgroundTransparency = 1
v32.Position = UDim2.new(0, 0, 0, 25)
v32.Size = UDim2.new(1, 0, 0, 150)
v32.ZIndex = 3
v32.Image = "rbxassetid://2851929490"
v32.ImageColor3 = Color3.new(0.129412, 0.133333, 0.141176)
v32.ScaleType = Enum.ScaleType.Slice
v32.SliceCenter = Rect.new(4, 4, 4, 4)
v33.Name = "Objects"
v33.Parent = v32
v33.BackgroundColor3 = Color3.new(1, 1, 1)
v33.BackgroundTransparency = 1
v33.BorderSizePixel = 0
v33.Size = UDim2.new(1, 0, 1, 0)
v33.ZIndex = 3
v33.CanvasSize = UDim2.new(0, 0, 0, 0)
v33.ScrollBarThickness = 8
v34.Parent = v33
v34.SortOrder = Enum.SortOrder.LayoutOrder
v35.Name = "TextButton_Roundify_4px"
v35.Parent = v30
v35.BackgroundColor3 = Color3.new(1, 1, 1)
v35.BackgroundTransparency = 1
v35.Size = UDim2.new(1, 0, 1, 0)
v35.Image = "rbxassetid://2851929490"
v35.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
v35.ScaleType = Enum.ScaleType.Slice
v35.SliceCenter = Rect.new(4, 4, 4, 4)
v36.Name = "TabButton"
v36.Parent = v4
v36.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
v36.BackgroundTransparency = 1
v36.BorderSizePixel = 0
v36.Position = UDim2.new(0.185185179, 0, 0, 0)
v36.Size = UDim2.new(0, 71, 0, 20)
v36.ZIndex = 2
v36.Font = Enum.Font.GothamSemibold
v36.Text = "Test tab"
v36.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
v36.TextSize = 14
v37.Name = "TextButton_Roundify_4px"
v37.Parent = v36
v37.BackgroundColor3 = Color3.new(1, 1, 1)
v37.BackgroundTransparency = 1
v37.Size = UDim2.new(1, 0, 1, 0)
v37.Image = "rbxassetid://2851929490"
v37.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
v37.ScaleType = Enum.ScaleType.Slice
v37.SliceCenter = Rect.new(4, 4, 4, 4)
v38.Name = "Folder"
v38.Parent = v4
v38.BackgroundColor3 = Color3.new(1, 1, 1)
v38.BackgroundTransparency = 1
v38.Position = UDim2.new(0, 0, 0, 50)
v38.Size = UDim2.new(1, 0, 0, 20)
v38.Image = "rbxassetid://2851929490"
v38.ImageColor3 = Color3.new(0.0823529, 0.0862745, 0.0901961)
v38.ScaleType = Enum.ScaleType.Slice
v38.SliceCenter = Rect.new(4, 4, 4, 4)
v39.Name = "Button"
v39.Parent = v38
v39.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
v39.BackgroundTransparency = 1
v39.BorderSizePixel = 0
v39.Size = UDim2.new(1, 0, 0, 20)
v39.ZIndex = 2
v39.Font = Enum.Font.GothamSemibold
v39.Text = "      Folder"
v39.TextColor3 = Color3.new(1, 1, 1)
v39.TextSize = 14
v39.TextXAlignment = Enum.TextXAlignment.Left
v40.Name = "TextButton_Roundify_4px"
v40.Parent = v39
v40.BackgroundColor3 = Color3.new(1, 1, 1)
v40.BackgroundTransparency = 1
v40.Size = UDim2.new(1, 0, 1, 0)
v40.Image = "rbxassetid://2851929490"
v40.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
v40.ScaleType = Enum.ScaleType.Slice
v40.SliceCenter = Rect.new(4, 4, 4, 4)
v41.Name = "Toggle"
v41.Parent = v39
v41.BackgroundColor3 = Color3.new(1, 1, 1)
v41.BackgroundTransparency = 1
v41.Position = UDim2.new(0, 5, 0, 0)
v41.Size = UDim2.new(0, 20, 0, 20)
v41.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"
v42.Name = "Objects"
v42.Parent = v38
v42.BackgroundColor3 = Color3.new(1, 1, 1)
v42.BackgroundTransparency = 1
v42.Position = UDim2.new(0, 10, 0, 25)
v42.Size = UDim2.new(1, - 10, 1, - 25)
v42.Visible = false
v43.Parent = v42
v43.SortOrder = Enum.SortOrder.LayoutOrder
v43.Padding = UDim.new(0, 5)
v44.Name = "HorizontalAlignment"
v44.Parent = v4
v44.BackgroundColor3 = Color3.new(1, 1, 1)
v44.BackgroundTransparency = 1
v44.Size = UDim2.new(1, 0, 0, 20)
v45.Parent = v44
v45.FillDirection = Enum.FillDirection.Horizontal
v45.SortOrder = Enum.SortOrder.LayoutOrder
v45.Padding = UDim.new(0, 5)
v46.Name = "Console"
v46.Parent = v4
v46.BackgroundColor3 = Color3.new(1, 1, 1)
v46.BackgroundTransparency = 1
v46.Size = UDim2.new(1, 0, 0, 200)
v46.Image = "rbxassetid://2851928141"
v46.ImageColor3 = Color3.new(0.129412, 0.133333, 0.141176)
v46.ScaleType = Enum.ScaleType.Slice
v46.SliceCenter = Rect.new(8, 8, 8, 8)
v47.Parent = v46
v47.BackgroundColor3 = Color3.new(1, 1, 1)
v47.BackgroundTransparency = 1
v47.BorderSizePixel = 0
v47.Size = UDim2.new(1, 0, 1, 1)
v47.CanvasSize = UDim2.new(0, 0, 0, 0)
v47.ScrollBarThickness = 4
v48.Name = "Source"
v48.Parent = v47
v48.BackgroundColor3 = Color3.new(1, 1, 1)
v48.BackgroundTransparency = 1
v48.Position = UDim2.new(0, 40, 0, 0)
v48.Size = UDim2.new(1, - 40, 0, 10000)
v48.ZIndex = 3
v48.ClearTextOnFocus = false
v48.Font = Enum.Font.Code
v48.MultiLine = true
v48.PlaceholderColor3 = Color3.new(0.8, 0.8, 0.8)
v48.Text = ""
v48.TextColor3 = Color3.new(1, 1, 1)
v48.TextSize = 15
v48.TextStrokeColor3 = Color3.new(1, 1, 1)
v48.TextWrapped = true
v48.TextXAlignment = Enum.TextXAlignment.Left
v48.TextYAlignment = Enum.TextYAlignment.Top
v49.Name = "Comments"
v49.Parent = v48
v49.BackgroundColor3 = Color3.new(1, 1, 1)
v49.BackgroundTransparency = 1
v49.Size = UDim2.new(1, 0, 1, 0)
v49.ZIndex = 5
v49.Font = Enum.Font.Code
v49.Text = ""
v49.TextColor3 = Color3.new(0.231373, 0.784314, 0.231373)
v49.TextSize = 15
v49.TextXAlignment = Enum.TextXAlignment.Left
v49.TextYAlignment = Enum.TextYAlignment.Top
v50.Name = "Globals"
v50.Parent = v48
v50.BackgroundColor3 = Color3.new(1, 1, 1)
v50.BackgroundTransparency = 1
v50.Size = UDim2.new(1, 0, 1, 0)
v50.ZIndex = 5
v50.Font = Enum.Font.Code
v50.Text = ""
v50.TextColor3 = Color3.new(0.517647, 0.839216, 0.968628)
v50.TextSize = 15
v50.TextXAlignment = Enum.TextXAlignment.Left
v50.TextYAlignment = Enum.TextYAlignment.Top
v51.Name = "Keywords"
v51.Parent = v48
v51.BackgroundColor3 = Color3.new(1, 1, 1)
v51.BackgroundTransparency = 1
v51.Size = UDim2.new(1, 0, 1, 0)
v51.ZIndex = 5
v51.Font = Enum.Font.Code
v51.Text = ""
v51.TextColor3 = Color3.new(0.972549, 0.427451, 0.486275)
v51.TextSize = 15
v51.TextXAlignment = Enum.TextXAlignment.Left
v51.TextYAlignment = Enum.TextYAlignment.Top
v52.Name = "RemoteHighlight"
v52.Parent = v48
v52.BackgroundColor3 = Color3.new(1, 1, 1)
v52.BackgroundTransparency = 1
v52.Size = UDim2.new(1, 0, 1, 0)
v52.ZIndex = 5
v52.Font = Enum.Font.Code
v52.Text = ""
v52.TextColor3 = Color3.new(0, 0.568627, 1)
v52.TextSize = 15
v52.TextXAlignment = Enum.TextXAlignment.Left
v52.TextYAlignment = Enum.TextYAlignment.Top
v53.Name = "Strings"
v53.Parent = v48
v53.BackgroundColor3 = Color3.new(1, 1, 1)
v53.BackgroundTransparency = 1
v53.Size = UDim2.new(1, 0, 1, 0)
v53.ZIndex = 5
v53.Font = Enum.Font.Code
v53.Text = ""
v53.TextColor3 = Color3.new(0.678431, 0.945098, 0.584314)
v53.TextSize = 15
v53.TextXAlignment = Enum.TextXAlignment.Left
v53.TextYAlignment = Enum.TextYAlignment.Top
v54.Name = "Tokens"
v54.Parent = v48
v54.BackgroundColor3 = Color3.new(1, 1, 1)
v54.BackgroundTransparency = 1
v54.Size = UDim2.new(1, 0, 1, 0)
v54.ZIndex = 5
v54.Font = Enum.Font.Code
v54.Text = ""
v54.TextColor3 = Color3.new(1, 1, 1)
v54.TextSize = 15
v54.TextXAlignment = Enum.TextXAlignment.Left
v54.TextYAlignment = Enum.TextYAlignment.Top
v55.Name = "Numbers"
v55.Parent = v48
v55.BackgroundColor3 = Color3.new(1, 1, 1)
v55.BackgroundTransparency = 1
v55.Size = UDim2.new(1, 0, 1, 0)
v55.ZIndex = 4
v55.Font = Enum.Font.Code
v55.Text = ""
v55.TextColor3 = Color3.new(1, 0.776471, 0)
v55.TextSize = 15
v55.TextXAlignment = Enum.TextXAlignment.Left
v55.TextYAlignment = Enum.TextYAlignment.Top
v56.Name = "Info"
v56.Parent = v48
v56.BackgroundColor3 = Color3.new(1, 1, 1)
v56.BackgroundTransparency = 1
v56.Size = UDim2.new(1, 0, 1, 0)
v56.ZIndex = 5
v56.Font = Enum.Font.Code
v56.Text = ""
v56.TextColor3 = Color3.new(0, 0.635294, 1)
v56.TextSize = 15
v56.TextXAlignment = Enum.TextXAlignment.Left
v56.TextYAlignment = Enum.TextYAlignment.Top
v57.Name = "Lines"
v57.Parent = v47
v57.BackgroundColor3 = Color3.new(1, 1, 1)
v57.BackgroundTransparency = 1
v57.BorderSizePixel = 0
v57.Size = UDim2.new(0, 40, 0, 10000)
v57.ZIndex = 4
v57.Font = Enum.Font.Code
v57.Text = "1\n"
v57.TextColor3 = Color3.new(1, 1, 1)
v57.TextSize = 15
v57.TextWrapped = true
v57.TextYAlignment = Enum.TextYAlignment.Top
v58.Name = "ColorPicker"
v58.Parent = v4
v58.BackgroundColor3 = Color3.new(1, 1, 1)
v58.BackgroundTransparency = 1
v58.Size = UDim2.new(0, 180, 0, 110)
v58.Image = "rbxassetid://2851929490"
v58.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
v58.ScaleType = Enum.ScaleType.Slice
v58.SliceCenter = Rect.new(4, 4, 4, 4)
v59.Name = "Palette"
v59.Parent = v58
v59.BackgroundColor3 = Color3.new(1, 1, 1)
v59.BackgroundTransparency = 1
v59.Position = UDim2.new(0.0500000007, 0, 0.0500000007, 0)
v59.Size = UDim2.new(0, 100, 0, 100)
v59.Image = "rbxassetid://698052001"
v59.ScaleType = Enum.ScaleType.Slice
v59.SliceCenter = Rect.new(4, 4, 4, 4)
v60.Name = "Indicator"
v60.Parent = v59
v60.BackgroundColor3 = Color3.new(1, 1, 1)
v60.BackgroundTransparency = 1
v60.Size = UDim2.new(0, 5, 0, 5)
v60.ZIndex = 2
v60.Image = "rbxassetid://2851926732"
v60.ImageColor3 = Color3.new(0, 0, 0)
v60.ScaleType = Enum.ScaleType.Slice
v60.SliceCenter = Rect.new(12, 12, 12, 12)
v61.Name = "Sample"
v61.Parent = v58
v61.BackgroundColor3 = Color3.new(1, 1, 1)
v61.BackgroundTransparency = 1
v61.Position = UDim2.new(0.800000012, 0, 0.0500000007, 0)
v61.Size = UDim2.new(0, 25, 0, 25)
v61.Image = "rbxassetid://2851929490"
v61.ScaleType = Enum.ScaleType.Slice
v61.SliceCenter = Rect.new(4, 4, 4, 4)
v62.Name = "Saturation"
v62.Parent = v58
v62.BackgroundColor3 = Color3.new(1, 1, 1)
v62.Position = UDim2.new(0.649999976, 0, 0.0500000007, 0)
v62.Size = UDim2.new(0, 15, 0, 100)
v62.Image = "rbxassetid://3641079629"
v63.Name = "Indicator"
v63.Parent = v62
v63.BackgroundColor3 = Color3.new(1, 1, 1)
v63.BorderSizePixel = 0
v63.Size = UDim2.new(0, 20, 0, 2)
v63.ZIndex = 2
v64.Name = "Switch"
v64.Parent = v4
v64.BackgroundColor3 = Color3.new(1, 1, 1)
v64.BackgroundTransparency = 1
v64.BorderSizePixel = 0
v64.Position = UDim2.new(0.229411766, 0, 0.20714286, 0)
v64.Size = UDim2.new(0, 20, 0, 20)
v64.ZIndex = 2
v64.Font = Enum.Font.SourceSans
v64.Text = ""
v64.TextColor3 = Color3.new(1, 1, 1)
v64.TextSize = 18
v65.Name = "TextButton_Roundify_4px"
v65.Parent = v64
v65.BackgroundColor3 = Color3.new(1, 1, 1)
v65.BackgroundTransparency = 1
v65.Size = UDim2.new(1, 0, 1, 0)
v65.Image = "rbxassetid://2851929490"
v65.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
v65.ImageTransparency = 0.5
v65.ScaleType = Enum.ScaleType.Slice
v65.SliceCenter = Rect.new(4, 4, 4, 4)
v66.Name = "Title"
v66.Parent = v64
v66.BackgroundColor3 = Color3.new(1, 1, 1)
v66.BackgroundTransparency = 1
v66.Position = UDim2.new(1.20000005, 0, 0, 0)
v66.Size = UDim2.new(0, 20, 0, 20)
v66.Font = Enum.Font.GothamSemibold
v66.Text = "Switch"
v66.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
v66.TextSize = 14
v66.TextXAlignment = Enum.TextXAlignment.Left
v67.Name = "Button"
v67.Parent = v4
v67.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
v67.BackgroundTransparency = 1
v67.BorderSizePixel = 0
v67.Size = UDim2.new(0, 91, 0, 20)
v67.ZIndex = 2
v67.Font = Enum.Font.GothamSemibold
v67.TextColor3 = Color3.new(1, 1, 1)
v67.TextSize = 14
v68.Name = "TextButton_Roundify_4px"
v68.Parent = v67
v68.BackgroundColor3 = Color3.new(1, 1, 1)
v68.BackgroundTransparency = 1
v68.Size = UDim2.new(1, 0, 1, 0)
v68.Image = "rbxassetid://2851929490"
v68.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
v68.ScaleType = Enum.ScaleType.Slice
v68.SliceCenter = Rect.new(4, 4, 4, 4)
v69.Name = "DropdownButton"
v69.Parent = v4
v69.BackgroundColor3 = Color3.new(0.129412, 0.133333, 0.141176)
v69.BorderSizePixel = 0
v69.Size = UDim2.new(1, 0, 0, 20)
v69.ZIndex = 3
v69.Font = Enum.Font.GothamBold
v69.Text = "      Button"
v69.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
v69.TextSize = 14
v69.TextXAlignment = Enum.TextXAlignment.Left
v70.Name = "Keybind"
v70.Parent = v4
v70.BackgroundColor3 = Color3.new(1, 1, 1)
v70.BackgroundTransparency = 1
v70.Size = UDim2.new(0, 200, 0, 20)
v70.Image = "rbxassetid://2851929490"
v70.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
v70.ScaleType = Enum.ScaleType.Slice
v70.SliceCenter = Rect.new(4, 4, 4, 4)
v71.Name = "Title"
v71.Parent = v70
v71.BackgroundColor3 = Color3.new(1, 1, 1)
v71.BackgroundTransparency = 1
v71.Size = UDim2.new(0, 0, 1, 0)
v71.Font = Enum.Font.GothamBold
v71.Text = "Keybind"
v71.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
v71.TextSize = 14
v71.TextXAlignment = Enum.TextXAlignment.Left
v72.Name = "Input"
v72.Parent = v70
v72.BackgroundColor3 = Color3.new(1, 1, 1)
v72.BackgroundTransparency = 1
v72.BorderSizePixel = 0
v72.Position = UDim2.new(1, - 85, 0, 2)
v72.Size = UDim2.new(0, 80, 1, - 4)
v72.ZIndex = 2
v72.Font = Enum.Font.GothamSemibold
v72.Text = "RShift"
v72.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
v72.TextSize = 12
v72.TextWrapped = true
v73.Name = "Input_Roundify_4px"
v73.Parent = v72
v73.BackgroundColor3 = Color3.new(1, 1, 1)
v73.BackgroundTransparency = 1
v73.Size = UDim2.new(1, 0, 1, 0)
v73.Image = "rbxassetid://2851929490"
v73.ImageColor3 = Color3.new(0.290196, 0.294118, 0.313726)
v73.ScaleType = Enum.ScaleType.Slice
v73.SliceCenter = Rect.new(4, 4, 4, 4)
v74.Name = "Windows"
v74.Parent = vu3
v74.BackgroundColor3 = Color3.new(1, 1, 1)
v74.BackgroundTransparency = 1
v74.Position = UDim2.new(0, 20, 0, 20)
v74.Size = UDim2.new(1, 20, 1, - 20)
local vu76 = game:GetService("UserInputService")
local vu77 = game:GetService("TweenService")
local vu78 = game:GetService("RunService")
local vu79 = game:GetService("Players").LocalPlayer:GetMouse()
local v80 = vu3
local vu81 = vu3.WaitForChild(v80, "Prefabs")
local v82 = vu3
local vu83 = vu3.FindFirstChild(v82, "Windows")
local vu84 = {
    binding = false
}
vu76.InputBegan:Connect(function(p85, _)
    if p85.KeyCode == (typeof(vu2.toggle_key) == "EnumItem" and vu2.toggle_key or Enum.KeyCode.RightShift) and (script.Parent and not vu84.binding) then
        script.Parent.Enabled = not script.Parent.Enabled
    end
end)
local function vu89(p86, p87, p88)
    vu77:Create(p86, TweenInfo.new(p88 or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p87):Play()
end
local function vu102(p90, p91, p92)
    local v93 = p90 / 255
    local v94 = p91 / 255
    local v95 = p92 / 255
    local v96 = math.max(v93, v94, v95)
    local v97 = math.min(v93, v94, v95)
    local v98 = nil
    local v99 = v96 - v97
    local v100 = v96 == 0 and 0 or v99 / v96
    local v101
    if v96 == v97 then
        v101 = 0
    else
        if v96 == v93 then
            v98 = (v94 - v95) / v99
            if v94 < v95 then
                v98 = v98 + 6
            end
        elseif v96 == v94 then
            v98 = (v95 - v93) / v99 + 2
        elseif v96 == v95 then
            v98 = (v93 - v94) / v99 + 4
        end
        v101 = v98 / 6
    end
    return v101, v100, v96
end
local function vu107(pu103, pu104)
    local v105, v106 = pcall(function()
        return pu103[tostring(pu104)]
    end)
    if v105 then
        return v106
    end
end
local function vu109(p108)
    return p108.TextBounds.X + 15
end
local function vu112()
    local v110 = vu76
    local v111 = vu76
    return Vector2.new(v110:GetMouseLocation().X + 1, v111:GetMouseLocation().Y - 35)
end
local function vu120(pu113, pu114, pu115)
    spawn(function()
        pu113.ClipsDescendants = true
        local v116 = vu81:FindFirstChild("Circle"):Clone()
        v116.Parent = pu113
        v116.ZIndex = 1000
        local v117 = pu114 - v116.AbsolutePosition.X
        local v118 = pu115 - v116.AbsolutePosition.Y
        v116.Position = UDim2.new(0, v117, 0, v118)
        local v119 = 0
        if pu113.AbsoluteSize.X <= pu113.AbsoluteSize.Y then
            if pu113.AbsoluteSize.X >= pu113.AbsoluteSize.Y then
                if pu113.AbsoluteSize.X == pu113.AbsoluteSize.Y then
                    v119 = pu113.AbsoluteSize.X * 1.5
                end
            else
                v119 = pu113.AbsoluteSize.Y * 1.5
            end
        else
            v119 = pu113.AbsoluteSize.X * 1.5
        end
        v116:TweenSizeAndPosition(UDim2.new(0, v119, 0, v119), UDim2.new(0.5, - v119 / 2, 0.5, - v119 / 2), "Out", "Quad", 0.5, false, nil)
        vu89(v116, {
            ImageTransparency = 1
        }, 0.5)
        wait(0.5)
        v116:Destroy()
    end)
end
local vu121 = 0
local function vu131()
    local v122 = vu81:FindFirstChild("UIListLayout"):Clone()
    v122.Parent = vu83
    local v123 = next
    local v124, v125 = vu83:GetChildren()
    local v126 = {}
    while true do
        local v127
        v125, v127 = v123(v124, v125)
        if v125 == nil then
            break
        end
        if not v127:IsA("UIListLayout") then
            v126[v127] = v127.AbsolutePosition
        end
    end
    v122:Destroy()
    local v128 = next
    local v129 = nil
    while true do
        local v130
        v129, v130 = v128(v126, v129)
        if v129 == nil then
            break
        end
        v129.Position = UDim2.new(0, v130.X, 0, v130.Y)
    end
end
function v1.FormatWindows(_)
    vu131()
end
function v1.AddWindow(_, p132, pu133)
    local v134 = game:GetService("CoreGui"):FindFirstChild("ui-engine-v2 // " .. tostring(p132))
    if v134 then
        v134:SetAttribute("dead", true)
        v134:Destroy()
    end
    vu3.Name = "ui-engine-v2 // " .. tostring(p132)
    vu3:SetAttribute("dead", false)
    vu121 = vu121 + 1
    local vu135 = false
    local v136 = tostring(p132 or "New Window")
    if typeof(pu133) ~= "table" or not pu133 then
        pu133 = vu2
    end
    pu133.tween_time = 0.1
    local vu137 = vu81:FindFirstChild("Window"):Clone()
    vu137.Parent = vu83
    local v138 = vu137
    vu137.FindFirstChild(v138, "Title").Text = v136
    vu137.Size = UDim2.new(0, pu133.min_size.X, 0, pu133.min_size.Y)
    vu137.ZIndex = vu137.ZIndex + vu121 * 10
    local v139 = vu137
    vu137.FindFirstChild(v139, "Title")
    local v140 = vu137
    local vu141 = vu137.FindFirstChild(v140, "Bar")
    local v142 = vu141
    local vu143 = vu141.FindFirstChild(v142, "Base")
    local v144 = vu141
    local vu145 = vu141.FindFirstChild(v144, "Top")
    local v146 = vu137
    local vu147 = vu137.FindFirstChild(v146, "TabSelection"):FindFirstChild("Frame")
    local v148 = vu141
    vu141.FindFirstChild(v148, "Toggle")
    spawn(function()
        while true do
            vu141.BackgroundColor3 = pu133.main_color
            vu143.BackgroundColor3 = pu133.main_color
            vu143.ImageColor3 = pu133.main_color
            vu145.ImageColor3 = pu133.main_color
            vu147.BackgroundColor3 = pu133.main_color
            vu78.Heartbeat:Wait()
        end
    end)
    local v149 = vu137
    local vu150 = vu137.WaitForChild(v149, "Resizer")
    local v151 = {}
    vu137.Draggable = true
    local vu152 = vu79.Icon
    local vu153 = false
    vu150.MouseEnter:Connect(function()
        vu137.Draggable = false
        if pu133.can_resize then
            vu152 = vu79.Icon
        end
        vu153 = true
    end)
    vu150.MouseLeave:Connect(function()
        vu153 = false
        if pu133.can_resize then
            vu79.Icon = vu152
        end
        vu137.Draggable = true
    end)
    local vu154 = false
    vu76.InputBegan:Connect(function(p155)
        if p155.UserInputType == Enum.UserInputType.MouseButton1 then
            vu154 = true
            spawn(function()
                if vu153 and (vu150.Active and pu133.can_resize) then
                    while vu154 and vu150.Active do
                        local v156 = vu112()
                        local v157 = v156.X - vu137.AbsolutePosition.X
                        local v158 = v156.Y - vu137.AbsolutePosition.Y
                        if pu133.min_size.X > v157 or pu133.min_size.Y > v158 then
                            if pu133.min_size.X > v157 then
                                if pu133.min_size.Y > v158 then
                                    vu89(vu137, {
                                        Size = UDim2.new(0, pu133.min_size.X, 0, pu133.min_size.Y)
                                    }, pu133.tween_time)
                                else
                                    vu89(vu137, {
                                        Size = UDim2.new(0, pu133.min_size.X, 0, v158)
                                    }, pu133.tween_time)
                                end
                            else
                                vu89(vu137, {
                                    Size = UDim2.new(0, v157, 0, pu133.min_size.Y)
                                }, pu133.tween_time)
                            end
                        else
                            vu89(vu137, {
                                Size = UDim2.new(0, v157, 0, v158)
                            }, pu133.tween_time)
                        end
                        vu78.Heartbeat:Wait()
                    end
                end
            end)
        end
    end)
    vu76.InputEnded:Connect(function(p159)
        if p159.UserInputType == Enum.UserInputType.MouseButton1 then
            vu154 = false
        end
    end)
    local v160 = vu137
    local vu161 = vu137.FindFirstChild(v160, "Bar"):FindFirstChild("Toggle")
    local vu162 = true
    local vu163 = true
    local vu164 = {}
    local vu165 = vu137.AbsoluteSize.Y
    vu161.MouseButton1Click:Connect(function()
        if vu163 then
            vu163 = false
            if vu162 then
                vu164 = {}
                local v166 = next
                local v167, v168 = vu137:FindFirstChild("Tabs"):GetChildren()
                while true do
                    local v169
                    v168, v169 = v166(v167, v168)
                    if v168 == nil then
                        break
                    end
                    vu164[v169] = v169.Visible
                    v169.Visible = false
                end
                vu150.Active = false
                vu165 = vu137.AbsoluteSize.Y
                vu89(vu161, {
                    Rotation = 0
                }, pu133.tween_time)
                vu89(vu137, {
                    Size = UDim2.new(0, vu137.AbsoluteSize.X, 0, 26)
                }, pu133.tween_time)
                vu161.Parent:FindFirstChild("Base").Transparency = 1
            else
                local v170 = next
                local v171 = vu164
                local v172 = nil
                while true do
                    local v173
                    v172, v173 = v170(v171, v172)
                    if v172 == nil then
                        break
                    end
                    v172.Visible = v173
                end
                vu150.Active = true
                vu89(vu161, {
                    Rotation = 90
                }, pu133.tween_time)
                vu89(vu137, {
                    Size = UDim2.new(0, vu137.AbsoluteSize.X, 0, vu165)
                }, pu133.tween_time)
                vu161.Parent:FindFirstChild("Base").Transparency = 0
            end
            vu162 = not vu162
            wait(pu133.tween_time)
            vu163 = true
        end
    end)
    local v174 = vu137
    local vu175 = vu137.FindFirstChild(v174, "Tabs")
    local v176 = vu137
    local vu177 = vu137.FindFirstChild(v176, "TabSelection")
    local v178 = vu177
    local vu179 = vu177.FindFirstChild(v178, "TabButtons")
    function v151.AddTab(_, p180)
        local vu181 = {}
        local v182 = tostring(p180 or "New Tab")
        vu177.Visible = true
        local vu183 = vu81:FindFirstChild("TabButton"):Clone()
        vu183.Parent = vu179
        vu183.Text = v182
        vu183.Size = UDim2.new(0, vu109(vu183), 0, 20)
        vu183.ZIndex = vu183.ZIndex + vu121 * 10
        local v184 = vu183
        local v185 = vu183
        vu183.GetChildren(v184)[1].ZIndex = vu183.GetChildren(v185)[1].ZIndex + vu121 * 10
        local vu186 = vu81:FindFirstChild("Tab"):Clone()
        vu186.Parent = vu175
        vu186.ZIndex = vu186.ZIndex + vu121 * 10
        local function vu195()
            if not vu135 then
                local v187 = next
                local v188, v189 = vu179:GetChildren()
                while true do
                    local v190
                    v189, v190 = v187(v188, v189)
                    if v189 == nil then
                        break
                    end
                    if not v190:IsA("UIListLayout") then
                        v190:GetChildren()[1].ImageColor3 = Color3.fromRGB(52, 53, 56)
                        vu89(v190, {
                            Size = UDim2.new(0, v190.AbsoluteSize.X, 0, 20)
                        }, pu133.tween_time)
                    end
                end
                local v191 = next
                local v192, v193 = vu175:GetChildren()
                while true do
                    local v194
                    v193, v194 = v191(v192, v193)
                    if v193 == nil then
                        break
                    end
                    v194.Visible = false
                end
                vu89(vu183, {
                    Size = UDim2.new(0, vu183.AbsoluteSize.X, 0, 25)
                }, pu133.tween_time)
                vu183:GetChildren()[1].ImageColor3 = Color3.fromRGB(73, 75, 79)
                vu186.Visible = true
                vu3.Enabled = true
            end
        end
        vu183.MouseButton1Click:Connect(function()
            vu195()
        end)
        function vu181.Show(_)
            vu195()
        end
        function vu181.AddLabel(_, p196)
            local v197 = {}
            local v198 = tostring(p196 or "New Label")
            local vu199 = vu81:FindFirstChild("Label"):Clone()
            vu199.Parent = vu186
            vu199.Text = v198
            vu199.Size = UDim2.new(0, vu109(vu199), 0, 20)
            vu199.ZIndex = vu199.ZIndex + vu121 * 10
            vu199.RichText = true
            function v197.Update(_, p200)
                vu199.Text = p200
            end
            return v197
        end
        function vu181.AddFolderLabel(_, p201)
            local v202 = tostring(p201 or "New Label")
            local v203 = vu81:FindFirstChild("Label"):Clone()
            v203.Parent = vu186
            v203.RichText = true
            v203.Text = v202
            v203.Size = UDim2.new(0, vu109(v203), 0, 20)
            v203.ZIndex = v203.ZIndex + vu121 * 10
            return v203
        end
        function vu181.AddButton(_, p204, p205, p206)
            local v207 = tostring(p204 or "New Button")
            local vu208 = (typeof(p205) ~= "function" or not p205) and function()
            end or p205
            Config = {
                runOnOpen = false,
                runOnClosure = false
            }
            if typeof(p206) == "table" and p206 ~= nil then
                Config = p206
            end
            local vu209 = vu81:FindFirstChild("Button"):Clone()
            vu209.Parent = vu186
            vu209.Text = v207
            vu209.RichText = true
            vu209.Size = UDim2.new(0, vu109(vu209), 0, 20)
            vu209.ZIndex = vu209.ZIndex + vu121 * 10
            local v210 = vu209
            local v211 = vu209
            vu209.GetChildren(v210)[1].ZIndex = vu209.GetChildren(v211)[1].ZIndex + vu121 * 10
            spawn(function()
                while true do
                    if vu209 and vu209:GetChildren()[1] then
                        vu209:GetChildren()[1].ImageColor3 = pu133.main_color
                    end
                    vu78.Heartbeat:Wait()
                end
            end)
            vu209.MouseButton1Click:Connect(function()
                vu120(vu209, vu79.X, vu79.Y)
                pcall(vu208)
            end)
            if Config.runOnOpen == true then
                pcall(vu208)
            end
            vu3:GetAttributeChangedSignal("dead"):Connect(function()
                if vu3:GetAttribute("dead") == true and Config.runOnClosure == true then
                    pcall(vu208)
                end
            end)
            return vu209
        end
        function vu181.AddSwitch(_, p212, p213)
            local vu214 = {}
            local v215 = tostring(p212 or "New Switch")
            local vu216 = (typeof(p213) ~= "function" or not p213) and function()
            end or p213
            local vu217 = vu81:FindFirstChild("Switch"):Clone()
            vu217.Parent = vu186
            local v218 = vu217
            vu217.FindFirstChild(v218, "Title").Text = v215
            local v219 = vu217
            local v220 = vu217
            vu217.FindFirstChild(v219, "Title").ZIndex = vu217.FindFirstChild(v220, "Title").ZIndex + vu121 * 10
            vu217.ZIndex = vu217.ZIndex + vu121 * 10
            local v221 = vu217
            local v222 = vu217
            vu217.GetChildren(v221)[1].ZIndex = vu217.GetChildren(v222)[1].ZIndex + vu121 * 10
            spawn(function()
                while true do
                    if vu217 and vu217:GetChildren()[1] then
                        vu217:GetChildren()[1].ImageColor3 = pu133.main_color
                    end
                    vu78.Heartbeat:Wait()
                end
            end)
            local vu223 = false
            vu217.MouseButton1Click:Connect(function()
                vu223 = not vu223
                vu217.Text = vu223 and utf8.char(10003) or ""
                pcall(vu216, vu223)
            end)
            function vu214.Set(_, p224)
                if typeof(p224) ~= "boolean" or not p224 then
                    p224 = false
                end
                vu223 = p224
                vu217.Text = vu223 and utf8.char(10003) or ""
                pcall(vu216, vu223)
            end
            vu3:GetAttributeChangedSignal("dead"):Connect(function()
                if vu3:GetAttribute("dead") == true then
                    vu214:Set(false)
                end
            end)
            return vu214, vu217
        end
        function vu181.AddFolderSwitch(_, p225, p226)
            local v227 = tostring(p225 or "New Switch")
            local vu228 = (typeof(p226) ~= "function" or not p226) and function()
            end or p226
            local vu229 = vu81:FindFirstChild("Switch"):Clone()
            vu229.Parent = vu186
            local v230 = vu229
            vu229.FindFirstChild(v230, "Title").Text = v227
            local v231 = vu229
            local v232 = vu229
            vu229.FindFirstChild(v231, "Title").ZIndex = vu229.FindFirstChild(v232, "Title").ZIndex + vu121 * 10
            vu229.ZIndex = vu229.ZIndex + vu121 * 10
            local v233 = vu229
            local v234 = vu229
            vu229.GetChildren(v233)[1].ZIndex = vu229.GetChildren(v234)[1].ZIndex + vu121 * 10
            spawn(function()
                while true do
                    if vu229 and vu229:GetChildren()[1] then
                        vu229:GetChildren()[1].ImageColor3 = pu133.main_color
                    end
                    vu78.Heartbeat:Wait()
                end
            end)
            local vu235 = false
            vu229.MouseButton1Click:Connect(function()
                vu235 = not vu235
                vu229.Text = vu235 and utf8.char(10003) or ""
                pcall(vu228, vu235)
            end)
            vu3:GetAttributeChangedSignal("dead"):Connect(function()
                if vu3:GetAttribute("dead") == true then
                    vu235 = false
                    vu229.Text = vu235 and utf8.char(10003) or ""
                    pcall(vu228, vu235)
                end
            end)
            return vu229
        end
        function vu181.AddTextBox(_, p236, p237, p238)
            local v239 = tostring(p236 or "New TextBox")
            local vu240 = (typeof(p237) ~= "function" or not p237) and function()
            end or p237
            local vu241 = {
                clear = ((typeof(p238) ~= "table" or not p238) and {
                    clear = true
                } or p238).clear == true
            }
            local vu242 = vu81:FindFirstChild("TextBox"):Clone()
            vu242.Parent = vu186
            vu242.PlaceholderText = v239
            vu242.ZIndex = vu242.ZIndex + vu121 * 10
            local v243 = vu242
            local v244 = vu242
            vu242.GetChildren(v243)[1].ZIndex = vu242.GetChildren(v244)[1].ZIndex + vu121 * 10
            vu242.FocusLost:Connect(function(p245)
                if p245 and # vu242.Text > 0 then
                    pcall(vu240, vu242.Text)
                    if vu241.clear then
                        vu242.Text = ""
                    end
                end
            end)
            return vu242
        end
        function vu181.AddSlider(_, p246, p247, p248)
            local v249 = {}
            local v250 = tostring(p246 or "New Slider")
            local vu251 = (typeof(p247) ~= "function" or not p247) and function()
            end or p247
            local v252 = (typeof(p248) ~= "table" or not p248) and {} or p248
            local vu253 = {
                min = v252.min or 0,
                max = v252.max or 100,
                readonly = v252.readonly or false
            }
            local vu254 = vu81:FindFirstChild("Slider"):Clone()
            vu254.Parent = vu186
            vu254.ZIndex = vu254.ZIndex + vu121 * 10
            local v255 = vu254
            local v256 = vu254.FindFirstChild(v255, "Title")
            local v257 = vu254
            local vu258 = vu254.FindFirstChild(v257, "Indicator")
            local v259 = vu254
            local vu260 = vu254.FindFirstChild(v259, "Value")
            v256.ZIndex = v256.ZIndex + vu121 * 10
            vu258.ZIndex = vu258.ZIndex + vu121 * 10
            vu260.ZIndex = vu260.ZIndex + vu121 * 10
            v256.Text = v250
            local vu261 = false
            vu254.MouseEnter:Connect(function()
                vu261 = true
                vu137.Draggable = false
            end)
            vu254.MouseLeave:Connect(function()
                vu261 = false
                vu137.Draggable = true
            end)
            local vu262 = false
            vu76.InputBegan:Connect(function(p263)
                if p263.UserInputType == Enum.UserInputType.MouseButton1 then
                    vu262 = true
                    spawn(function()
                        if vu261 and not vu253.readonly then
                            while vu262 and not vu135 do
                                local v264 = vu112()
                                local v265 = (vu254.AbsoluteSize.X - (vu254.AbsoluteSize.X - (v264.X - vu254.AbsolutePosition.X) + 1)) / vu254.AbsoluteSize.X
                                local v266 = 0
                                local v267 = 1
                                if v266 <= v265 and v265 <= v267 then
                                    v267 = v265
                                elseif v265 < v266 then
                                    v267 = v266
                                elseif v267 >= v265 then
                                    v267 = v266
                                end
                                vu89(vu258, {
                                    Size = UDim2.new(v267 or v266, 0, 0, 20)
                                }, pu133.tween_time)
                                local v268 = math.floor((v267 or v266) * 100)
                                local v269 = vu253.max
                                local v270 = vu253.min
                                local v271 = v269 - v270
                                local v272 = math.floor(v271 / 100 * v268 + v270)
                                vu260.Text = tostring(v272)
                                pcall(vu251, v272)
                                vu78.Heartbeat:Wait()
                            end
                        end
                    end)
                end
            end)
            vu76.InputEnded:Connect(function(p273)
                if p273.UserInputType == Enum.UserInputType.MouseButton1 then
                    vu262 = false
                end
            end)
            function v249.Set(_, p274)
                local v275 = tonumber(p274) or 0
                if 0 > v275 or v275 > 100 then
                    v275 = false
                end
                local v276 = v275 / 100
                vu89(vu258, {
                    Size = UDim2.new(v276 or 0, 0, 0, 20)
                }, pu133.tween_time)
                local v277 = math.floor((v276 or 0) * 100)
                local v278 = vu253.max
                local v279 = vu253.min
                local v280 = v278 - v279
                local v281 = math.floor(v280 / 100 * v277 + v279)
                vu260.Text = tostring(v281)
                pcall(vu251, v281)
            end
            v249:Set(vu253.min)
            return v249, vu254
        end
        function vu181.AddKeybind(_, p282, p283, p284)
            local vu285 = {}
            local v286 = tostring(p282 or "New Keybind")
            local vu287 = (typeof(p283) ~= "function" or not p283) and function()
            end or p283
            local v288 = {
                standard = ((typeof(p284) ~= "table" or not p284) and {} or p284).standard or Enum.KeyCode.RightShift
            }
            local v289 = vu81:FindFirstChild("Keybind"):Clone()
            local vu290 = v289:FindFirstChild("Input")
            local v291 = v289:FindFirstChild("Title")
            v289.ZIndex = v289.ZIndex + vu121 * 10
            vu290.ZIndex = vu290.ZIndex + vu121 * 10
            local v292 = vu290
            local v293 = vu290
            vu290.GetChildren(v292)[1].ZIndex = vu290.GetChildren(v293)[1].ZIndex + vu121 * 10
            v291.ZIndex = v291.ZIndex + vu121 * 10
            v289.Parent = vu186
            v291.Text = "  " .. v286
            v289.Size = UDim2.new(0, vu109(v291) + 80, 0, 20)
            local vu294 = {
                RightControl = "RightCtrl",
                LeftControl = "LeftCtrl",
                LeftShift = "LShift",
                RightShift = "RShift",
                MouseButton1 = "Mouse1",
                MouseButton2 = "Mouse2"
            }
            local vu295 = v288.standard
            function vu285.SetKeybind(_, p296)
                vu290.Text = vu294[p296.Name] or p296.Name
                vu295 = p296
            end
            vu76.InputBegan:Connect(function(p297, p298)
                if vu84.binding then
                    spawn(function()
                        wait()
                        vu84.binding = false
                    end)
                elseif p297.KeyCode == vu295 and (not p298 and vu3) and vu3:GetAttribute("dead") == false then
                    pcall(vu287, vu295)
                end
            end)
            vu285:SetKeybind(v288.standard)
            vu290.MouseButton1Click:Connect(function()
                if not vu84.binding then
                    vu290.Text = "..."
                    vu84.binding = true
                    local v299, _ = vu76.InputBegan:Wait()
                    vu285:SetKeybind(v299.KeyCode)
                end
            end)
            return vu285, vu295
        end
        function vu181.AddGuiToggle(_, p300, p301)
            local vu302 = {}
            local v303 = tostring(p300 or "New Keybind")
            local v304 = {
                standard = ((typeof(p301) ~= "table" or not p301) and {} or p301).standard or Enum.KeyCode.RightShift
            }
            local v305 = vu81:FindFirstChild("Keybind"):Clone()
            local vu306 = v305:FindFirstChild("Input")
            local v307 = v305:FindFirstChild("Title")
            v305.ZIndex = v305.ZIndex + vu121 * 10
            vu306.ZIndex = vu306.ZIndex + vu121 * 10
            local v308 = vu306
            local v309 = vu306
            vu306.GetChildren(v308)[1].ZIndex = vu306.GetChildren(v309)[1].ZIndex + vu121 * 10
            v307.ZIndex = v307.ZIndex + vu121 * 10
            v305.Parent = vu186
            v307.Text = "  " .. v303
            v305.Size = UDim2.new(0, vu109(v307) + 80, 0, 20)
            local vu310 = {
                RightControl = "RightCtrl",
                LeftControl = "LeftCtrl",
                LeftShift = "LShift",
                RightShift = "RShift",
                MouseButton1 = "Mouse1",
                MouseButton2 = "Mouse2"
            }
            local vu311 = v304.standard
            function vu302.SetKeybind(_, p312)
                vu306.Text = vu310[p312.Name] or p312.Name
                vu311 = p312
            end
            vu76.InputBegan:Connect(function(p313, p314)
                if vu84.binding then
                    spawn(function()
                        wait()
                        vu84.binding = false
                    end)
                elseif p313.KeyCode == vu311 and (not p314 and vu3) and vu3:GetAttribute("dead") == false then
                    vu3.Enabled = not vu3.Enabled
                end
            end)
            vu302:SetKeybind(v304.standard)
            vu306.MouseButton1Click:Connect(function()
                if not vu84.binding then
                    vu306.Text = "..."
                    vu84.binding = true
                    local v315, _ = vu76.InputBegan:Wait()
                    vu302:SetKeybind(v315.KeyCode)
                end
            end)
            return vu302, vu311
        end
        function vu181.AddDropdown(_, p316, p317)
            local v318 = {}
            local v319 = tostring(p316 or "New Dropdown")
            local vu320 = (typeof(p317) ~= "function" or not p317) and function()
            end or p317
            local vu321 = vu81:FindFirstChild("Dropdown"):Clone()
            local v322 = vu321
            local vu323 = vu321.FindFirstChild(v322, "Box")
            local v324 = vu323
            local vu325 = vu323.FindFirstChild(v324, "Objects")
            local v326 = vu321
            local vu327 = vu321.FindFirstChild(v326, "Indicator")
            vu321.ZIndex = vu321.ZIndex + vu121 * 10
            vu323.ZIndex = vu323.ZIndex + vu121 * 10
            vu325.ZIndex = vu325.ZIndex + vu121 * 10
            vu327.ZIndex = vu327.ZIndex + vu121 * 10
            local v328 = vu321
            local v329 = vu321
            vu321.GetChildren(v328)[3].ZIndex = vu321.GetChildren(v329)[3].ZIndex + vu121 * 10
            vu321.Parent = vu186
            vu321.Text = "      " .. v319
            vu323.Size = UDim2.new(1, 0, 0, 0)
            local vu330 = false
            vu321.MouseButton1Click:Connect(function()
                vu330 = not vu330
                local v331 = (# vu325:GetChildren() - 1) * 20
                if # vu325:GetChildren() - 1 >= 10 then
                    local v332 = vu325
                    vu325.CanvasSize = UDim2.new(0, 0, (# v332:GetChildren() - 1) * 0.1, 0)
                    v331 = 200
                end
                if vu330 then
                    if vu135 then
                        return
                    end
                    vu135 = true
                    vu89(vu323, {
                        Size = UDim2.new(1, 0, 0, v331)
                    }, pu133.tween_time)
                    vu89(vu327, {
                        Rotation = 90
                    }, pu133.tween_time)
                else
                    vu135 = false
                    vu89(vu323, {
                        Size = UDim2.new(1, 0, 0, 0)
                    }, pu133.tween_time)
                    vu89(vu327, {
                        Rotation = - 90
                    }, pu133.tween_time)
                end
            end)
            function v318.Add(_, p333)
                local v334 = {}
                local vu335 = tostring(p333 or "New Object")
                local vu336 = vu81:FindFirstChild("DropdownButton"):Clone()
                vu336.Parent = vu325
                vu336.Text = vu335
                vu336.ZIndex = vu336.ZIndex + vu121 * 10
                vu336.MouseEnter:Connect(function()
                    vu336.BackgroundColor3 = pu133.main_color
                end)
                vu336.MouseLeave:Connect(function()
                    vu336.BackgroundColor3 = Color3.fromRGB(33, 34, 36)
                end)
                if vu330 then
                    local v337 = (# vu325:GetChildren() - 1) * 20
                    if # vu325:GetChildren() - 1 >= 10 then
                        local v338 = vu325
                        vu325.CanvasSize = UDim2.new(0, 0, (# v338:GetChildren() - 1) * 0.1, 0)
                        v337 = 200
                    end
                    vu89(vu323, {
                        Size = UDim2.new(1, 0, 0, v337)
                    }, pu133.tween_time)
                end
                vu336.MouseButton1Click:Connect(function()
                    if vu135 then
                        vu321.Text = "      [ " .. vu335 .. " ]"
                        vu135 = false
                        vu330 = false
                        vu89(vu323, {
                            Size = UDim2.new(1, 0, 0, 0)
                        }, pu133.tween_time)
                        vu89(vu327, {
                            Rotation = - 90
                        }, pu133.tween_time)
                        pcall(vu320, vu335)
                    end
                end)
                function v334.Remove(_)
                    vu336:Destroy()
                end
                return vu336, v334
            end
            return v318, vu321
        end
        function vu181.AddColorPicker(_, p339)
            local v340 = {}
            local vu341 = (typeof(p339) ~= "function" or not p339) and function()
            end or p339
            local v342 = vu81:FindFirstChild("ColorPicker"):Clone()
            v342.Parent = vu186
            v342.ZIndex = v342.ZIndex + vu121 * 10
            local vu343 = v342:FindFirstChild("Palette")
            local vu344 = v342:FindFirstChild("Sample")
            local vu345 = v342:FindFirstChild("Saturation")
            vu343.ZIndex = vu343.ZIndex + vu121 * 10
            vu344.ZIndex = vu344.ZIndex + vu121 * 10
            vu345.ZIndex = vu345.ZIndex + vu121 * 10
            local vu346 = 0
            local vu347 = 1
            local vu348 = 1
            local function vu350()
                local v349 = Color3.fromHSV(vu346, vu347, vu348)
                vu344.ImageColor3 = v349
                vu345.ImageColor3 = Color3.fromHSV(vu346, 1, 1)
                pcall(vu341, v349)
            end
            vu344.ImageColor3 = Color3.fromHSV(vu346, vu347, vu348)
            vu345.ImageColor3 = Color3.fromHSV(vu346, 1, 1)
            local vu351 = false
            local vu352 = false
            vu343.MouseEnter:Connect(function()
                vu137.Draggable = false
                vu351 = true
            end)
            vu343.MouseLeave:Connect(function()
                vu137.Draggable = true
                vu351 = false
            end)
            vu345.MouseEnter:Connect(function()
                vu137.Draggable = false
                vu352 = true
            end)
            vu345.MouseLeave:Connect(function()
                vu137.Draggable = true
                vu352 = false
            end)
            local v353 = vu343
            local vu354 = vu343.FindFirstChild(v353, "Indicator")
            local v355 = vu345
            local vu356 = vu345.FindFirstChild(v355, "Indicator")
            vu354.ZIndex = vu354.ZIndex + vu121 * 10
            vu356.ZIndex = vu356.ZIndex + vu121 * 10
            local vu357 = false
            vu76.InputBegan:Connect(function(p358)
                if p358.UserInputType == Enum.UserInputType.MouseButton1 then
                    vu357 = true
                    spawn(function()
                        while vu357 and (vu351 and not vu135) do
                            local v359 = vu112()
                            local v360 = vu343.AbsoluteSize.X - (v359.X - vu343.AbsolutePosition.X) + 1
                            local v361 = vu343.AbsoluteSize.Y - (v359.Y - vu343.AbsolutePosition.Y) + 1.5
                            Color3.fromHSV(v360 / 100, v361 / 100, 0)
                            vu346 = v360 / 100
                            vu347 = v361 / 100
                            vu89(vu354, {
                                Position = UDim2.new(0, math.abs(v360 - 100) - vu354.AbsoluteSize.X / 2, 0, math.abs(v361 - 100) - vu354.AbsoluteSize.Y / 2)
                            }, pu133.tween_time)
                            vu350()
                            vu78.Heartbeat:Wait()
                        end
                        while vu357 and (vu352 and not vu135) do
                            local v362 = vu112()
                            local v363 = vu343.AbsoluteSize.Y - (v362.Y - vu343.AbsolutePosition.Y) + 1.5
                            vu348 = v363 / 100
                            vu89(vu356, {
                                Position = UDim2.new(0, 0, 0, math.abs(v363 - 100))
                            }, pu133.tween_time)
                            vu350()
                            vu78.Heartbeat:Wait()
                        end
                    end)
                end
            end)
            vu76.InputEnded:Connect(function(p364)
                if p364.UserInputType == Enum.UserInputType.MouseButton1 then
                    vu357 = false
                end
            end)
            function v340.Set(_, p365)
                if typeof(p365) ~= "Color3" or not p365 then
                    p365 = Color3.new(1, 1, 1)
                end
                local v366, _, _ = vu102(p365.r * 255, p365.g * 255, p365.b * 255)
                vu344.ImageColor3 = p365
                vu345.ImageColor3 = Color3.fromHSV(v366, 1, 1)
                pcall(vu341, p365)
            end
            return v340, v342
        end
        function vu181.AddConsole(_, p367)
            local v368 = (typeof(p367) ~= "table" or not p367) and {
                readonly = true,
                full = false
            } or p367
            local v369 = {
                y = tonumber(v368.y) or 200,
                source = v368.source or "Logs",
                readonly = v368.readonly == true,
                full = v368.full == true
            }
            local v370 = vu81:FindFirstChild("Console"):Clone()
            v370.Parent = vu186
            v370.ZIndex = v370.ZIndex + vu121 * 10
            v370.Size = UDim2.new(1, 0, v369.full and 1 or 0, v369.y)
            local vu371 = v370:GetChildren()[1]
            local vu372 = vu371:FindFirstChild("Source")
            local vu373 = vu371:FindFirstChild("Lines")
            vu372.ZIndex = vu372.ZIndex + vu121 * 10
            vu373.ZIndex = vu373.ZIndex + vu121 * 10
            vu372.TextEditable = not v369.readonly
            local v374 = next
            local v375, v376 = vu372:GetChildren()
            local v377 = {}
            while true do
                local v378
                v376, v378 = v374(v375, v376)
                if v376 == nil then
                    break
                end
                v378.ZIndex = v378.ZIndex + vu121 * 10 + 1
            end
            vu372.Comments.ZIndex = vu372.Comments.ZIndex + 1
            local vu379 = {
                "and",
                "break",
                "do",
                "else",
                "elseif",
                "end",
                "false",
                "for",
                "function",
                "goto",
                "if",
                "in",
                "local",
                "nil",
                "not",
                "or",
                "repeat",
                "return",
                "then",
                "true",
                "until",
                "while"
            }
            local vu380 = {
                "getrawmetatable",
                "newcclosure",
                "islclosure",
                "setclipboard",
                "game",
                "workspace",
                "script",
                "math",
                "string",
                "table",
                "print",
                "wait",
                "BrickColor",
                "Color3",
                "next",
                "pairs",
                "ipairs",
                "select",
                "unpack",
                "Instance",
                "Vector2",
                "Vector3",
                "CFrame",
                "Ray",
                "UDim2",
                "Enum",
                "assert",
                "error",
                "warn",
                "tick",
                "loadstring",
                "_G",
                "shared",
                "getfenv",
                "setfenv",
                "newproxy",
                "setmetatable",
                "getmetatable",
                "os",
                "debug",
                "pcall",
                "ypcall",
                "xpcall",
                "rawequal",
                "rawset",
                "rawget",
                "tonumber",
                "tostring",
                "type",
                "typeof",
                "_VERSION",
                "coroutine",
                "delay",
                "require",
                "spawn",
                "LoadLibrary",
                "settings",
                "stats",
                "time",
                "UserSettings",
                "version",
                "Axes",
                "ColorSequence",
                "Faces",
                "ColorSequenceKeypoint",
                "NumberRange",
                "NumberSequence",
                "NumberSequenceKeypoint",
                "gcinfo",
                "elapsedTime",
                "collectgarbage",
                "PhysicalProperties",
                "Rect",
                "Region3",
                "Region3int16",
                "UDim",
                "Vector2int16",
                "Vector3int16",
                "load",
                "fire",
                "Fire"
            }
            local function vu391(p381, p382)
                local v383, v384, v385 = pairs(p382)
                local vu386 = {}
                local vu387 = {
                    ["="] = true,
                    ["."] = true,
                    [","] = true,
                    ["("] = true,
                    [")"] = true,
                    ["["] = true,
                    ["]"] = true,
                    ["{"] = true,
                    ["}"] = true,
                    [":"] = true,
                    ["*"] = true,
                    ["/"] = true,
                    ["+"] = true,
                    ["-"] = true,
                    ["%"] = true,
                    [";"] = true,
                    ["~"] = true
                }
                while true do
                    local v388
                    v385, v388 = v383(v384, v385)
                    if v385 == nil then
                        break
                    end
                    vu386[v388] = true
                end
                return p381:gsub(".", function(p389)
                    return vu387[p389] ~= nil and " " or p389
                end):gsub("%S+", function(p390)
                    if vu386[p390] == nil then
                        return (" "):rep(# p390)
                    else
                        return p390
                    end
                end)
            end
            local function vu396(p392)
                local vu393 = {
                    ["="] = true,
                    ["."] = true,
                    [","] = true,
                    ["("] = true,
                    [")"] = true,
                    ["["] = true,
                    ["]"] = true,
                    ["{"] = true,
                    ["}"] = true,
                    [":"] = true,
                    ["*"] = true,
                    ["/"] = true,
                    ["+"] = true,
                    ["-"] = true,
                    ["%"] = true,
                    [";"] = true,
                    ["~"] = true
                }
                local vu394 = ""
                p392:gsub(".", function(p395)
                    if vu393[p395] == nil then
                        if p395 == "\n" then
                            vu394 = vu394 .. "\n"
                        elseif p395 == "\t" then
                            vu394 = vu394 .. "\t"
                        else
                            vu394 = vu394 .. " "
                        end
                    else
                        vu394 = vu394 .. p395
                    end
                end)
                return vu394
            end
            local function vu401(p397)
                local vu398 = ""
                local vu399 = false
                p397:gsub(".", function(p400)
                    if vu399 ~= false or p400 ~= "\"" then
                        if vu399 == true and p400 == "\"" then
                            vu399 = false
                        end
                    else
                        vu399 = true
                    end
                    if vu399 ~= false or p400 ~= "\"" then
                        if p400 == "\n" then
                            vu398 = vu398 .. "\n"
                        elseif p400 == "\t" then
                            vu398 = vu398 .. "\t"
                        elseif vu399 ~= true then
                            if vu399 == false then
                                vu398 = vu398 .. " "
                            end
                        else
                            vu398 = vu398 .. p400
                        end
                    else
                        vu398 = vu398 .. "\""
                    end
                end)
                return vu398
            end
            local function vu406(p402)
                local vu403 = ""
                local vu404 = false
                p402:gsub(".", function(p405)
                    if vu404 ~= false or p405 ~= "[" then
                        if vu404 == true and p405 == "]" then
                            vu404 = false
                        end
                    else
                        vu404 = true
                    end
                    if vu404 ~= false or p405 ~= "]" then
                        if p405 == "\n" then
                            vu403 = vu403 .. "\n"
                        elseif p405 == "\t" then
                            vu403 = vu403 .. "\t"
                        elseif vu404 ~= true then
                            if vu404 == false then
                                vu403 = vu403 .. " "
                            end
                        else
                            vu403 = vu403 .. p405
                        end
                    else
                        vu403 = vu403 .. "]"
                    end
                end)
                return vu403
            end
            local function vu413(p407)
                local vu408 = ""
                p407:gsub("[^\r\n]+", function(pu409)
                    local vu410 = false
                    local vu411 = 0
                    pu409:gsub(".", function(p412)
                        vu411 = vu411 + 1
                        if pu409:sub(vu411, vu411 + 1) == "--" then
                            vu410 = true
                        end
                        if vu410 ~= true then
                            vu408 = vu408 .. " "
                        else
                            vu408 = vu408 .. p412
                        end
                    end)
                    vu408 = vu408
                end)
                return vu408
            end
            local function vu417(p414)
                local vu415 = ""
                p414:gsub(".", function(p416)
                    if tonumber(p416) == nil then
                        if p416 == "\n" then
                            vu415 = vu415 .. "\n"
                        elseif p416 == "\t" then
                            vu415 = vu415 .. "\t"
                        else
                            vu415 = vu415 .. " "
                        end
                    else
                        vu415 = vu415 .. p416
                    end
                end)
                return vu415
            end
            local function v425(p418)
                if p418 == "Text" then
                    vu372.Text = vu372.Text:gsub("\r", "")
                    vu372.Text = vu372.Text:gsub("\t", "      ")
                    local v419 = vu372.Text
                    vu372.Keywords.Text = vu391(v419, vu379)
                    vu372.Globals.Text = vu391(v419, vu380)
                    vu372.RemoteHighlight.Text = vu391(v419, {
                        "FireServer",
                        "fireServer",
                        "InvokeServer",
                        "invokeServer"
                    })
                    vu372.Tokens.Text = vu396(v419)
                    vu372.Numbers.Text = vu417(v419)
                    vu372.Strings.Text = vu401(v419)
                    vu372.Comments.Text = vu413(v419)
                    local vu420 = 1
                    v419:gsub("\n", function()
                        vu420 = vu420 + 1
                    end)
                    vu373.Text = ""
                    local v421 = vu420
                    for v422 = 1, vu420 do
                        vu373.Text = vu373.Text .. v422 .. "\n"
                    end
                    vu371.CanvasSize = UDim2.new(0, 0, v421 * 0.153846154, 0)
                end
                if p418 == "Text" then
                    vu372.Text = vu372.Text:gsub("\r", "")
                    vu372.Text = vu372.Text:gsub("\t", "      ")
                    local v423 = vu372.Text
                    vu372.Info.Text = vu406(v423)
                    local vu424 = 1
                    v423:gsub("\n", function()
                        vu424 = vu424 + 1
                    end)
                    vu371.CanvasSize = UDim2.new(0, 0, vu424 * 0.153846154, 0)
                end
            end
            if v369.source ~= "Lua" then
                if v369.source == "Logs" then
                    vu373.Visible = false
                    highlight_logs("Text")
                    vu372.Changed:Connect(highlight_logs)
                end
            else
                v425("Text")
                vu372.Changed:Connect(v425)
            end
            function v377.Set(_, p426)
                vu372.Text = tostring(p426)
            end
            function v377.Get(_)
                return vu372.Text
            end
            function v377.Log(_, p427)
                vu372.Text = vu372.Text .. "[*] " .. tostring(p427) .. "\n"
            end
            return v377, v370
        end
        function vu181.AddHorizontalAlignment(_)
            local v428 = {}
            local vu429 = vu81:FindFirstChild("HorizontalAlignment"):Clone()
            vu429.Parent = vu186
            function v428.AddButton(_, ...)
                local v430 = {
                    vu181:AddButton(...)
                }
                if typeof(v430[1]) ~= "table" then
                    local v431 = v430[1]
                    v431.Parent = vu429
                    return v431
                end
                local v432 = v430[1]
                local v433 = v430[2]
                v433.Parent = vu429
                return v432, v433
            end
            return v428, vu429
        end
        function vu181.AddFolder(_, p434)
            local v435 = {}
            local v436 = tostring(p434 or "New Folder")
            local vu437 = vu81:FindFirstChild("Folder"):Clone()
            local v438 = vu437
            local vu439 = vu437.FindFirstChild(v438, "Button")
            local v440 = vu437
            local vu441 = vu437.FindFirstChild(v440, "Objects")
            local v442 = vu439
            local vu443 = vu439.FindFirstChild(v442, "Toggle")
            vu437.ZIndex = vu437.ZIndex + vu121 * 10
            vu439.ZIndex = vu439.ZIndex + vu121 * 10
            vu441.ZIndex = vu441.ZIndex + vu121 * 10
            vu443.ZIndex = vu443.ZIndex + vu121 * 10
            local v444 = vu439
            local v445 = vu439
            vu439.GetChildren(v444)[1].ZIndex = vu439.GetChildren(v445)[1].ZIndex + vu121 * 10
            vu437.Parent = vu186
            vu439.Text = "         " .. v436
            spawn(function()
                while true do
                    if vu439 and vu439:GetChildren()[1] then
                        vu439:GetChildren()[1].ImageColor3 = pu133.main_color
                    end
                    vu78.Heartbeat:Wait()
                end
            end)
            local function vu451()
                local v446 = next
                local v447, v448 = vu441:GetChildren()
                local v449 = 25
                while true do
                    local v450
                    v448, v450 = v446(v447, v448)
                    if v448 == nil then
                        break
                    end
                    if not v450:IsA("UIListLayout") then
                        v449 = v449 + v450.AbsoluteSize.Y + 5
                    end
                end
                return v449
            end
            local vu452 = false
            vu439.MouseButton1Click:Connect(function()
                if vu452 then
                    vu89(vu443, {
                        Rotation = 0
                    }, pu133.tween_time)
                    vu441.Visible = false
                else
                    vu89(vu443, {
                        Rotation = 90
                    }, pu133.tween_time)
                    vu441.Visible = true
                end
                vu452 = not vu452
            end)
            spawn(function()
                while true do
                    vu89(vu437, {
                        Size = UDim2.new(1, 0, 0, vu452 and vu451() or 20)
                    }, pu133.tween_time)
                    wait()
                end
            end)
            local v453 = next
            local v454 = vu181
            local v455 = vu437
            local vu456 = vu441
            local v457 = nil
            while true do
                local vu458
                v457, vu458 = v453(v454, v457)
                if v457 == nil then
                    break
                end
                v435[v457] = function(...)
                    local v459 = {
                        vu458(...)
                    }
                    if typeof(v459[1]) ~= "table" then
                        local v460 = v459[1]
                        v460.Parent = vu456
                        return v460
                    end
                    local v461 = v459[1]
                    local v462 = v459[2]
                    v462.Parent = vu456
                    return v461, v462
                end
            end
            return v435, v455
        end
        return vu181, vu186
    end
    local v463 = next
    local v464 = vu137
    local v465, v466 = vu137.GetDescendants(v464)
    local v467 = vu137
    while true do
        local v468, v469 = v463(v465, v466)
        if v468 == nil then
            break
        end
        v466 = v468
        if vu107(v469, "ZIndex") then
            v469.ZIndex = v469.ZIndex + vu121 * 10
        end
    end
    return v151, v467
end
return v1
