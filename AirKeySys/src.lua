-- By 00Fazee 31/08/2025
-- Air Key System v1.1 (Scaled 1.5x) + Draggable (PC & Mobile)

function fontFix(arg)
	return Font.new(arg.Family, arg.Weight, arg.Style)
end

function createObject(className, properties)
	local obj = Instance.new(className)
	local parentObj
	for propName, propValue in pairs(properties) do
		if propName ~= "Parent" then
			obj[propName] = propValue
		else
			parentObj = propValue
		end
	end
	obj.Parent = parentObj
	return obj
end

local UserInputService = game:GetService("UserInputService")

function WhitelistCreate(titleText, descText, clipboardText)
	local existingGui = game.CoreGui:FindFirstChild('Rnd')
	if existingGui then
		existingGui:Destroy()
	end

	local mainGui = createObject("ScreenGui", {
		Name = "Rnd",
		Parent = game.CoreGui,
	})

	local mainFrame = createObject("Frame", {
		Parent = mainGui,
		ClipsDescendants = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(27, 27, 27),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 0),
	})

	local mainFrameCorner = createObject("UICorner", {Parent = mainFrame})

	local mainFrameStroke = createObject("UIStroke", {
		Parent = mainFrame,
		Thickness = 3.8,
		Transparency = 0.9,
	})

	local titleLabel = createObject("TextLabel", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.0644, 0, 0.0829, 0),
		Size = UDim2.new(0, 281, 0, 27),
		Font = Enum.Font.Gotham,
		FontFace = fontFix{
			Family = "rbxasset://fonts/families/GothamSSm.json",
			Weight = Enum.FontWeight.Regular,
			Style = Enum.FontStyle.Normal
		},
		Text = titleText or "Air Key",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 21,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local descLabel = createObject("TextLabel", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.0644, 0, 0.1615, 0),
		Size = UDim2.new(0, 405, 0, 17),
		Font = Enum.Font.Gotham,
		FontFace = fontFix{
			Family = "rbxasset://fonts/families/GothamSSm.json",
			Weight = Enum.FontWeight.Regular,
			Style = Enum.FontStyle.Normal
		},
		Text = descText or "A simple key system using work.ink",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 15,
		TextTransparency = 0.47,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local whiteGradient = createObject("Decal", {
		Name = "White Gradient",
		Parent = descLabel,
		Texture = "http://www.roblox.com/asset/?id=277037193",
	})

	local mainImage = createObject("ImageLabel", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0.4323, 0),
		Size = UDim2.new(0, 489, 0, 195),
		Image = "http://www.roblox.com/asset/?id=277037193",
		ImageTransparency = 0.93,
	})

	local mainImageCorner = createObject("UICorner", {Parent = mainImage})

	local loginButton = createObject("TextButton", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(91, 161, 78),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.064, 0, 0.4015, 0),
		Size = UDim2.new(0, 95, 0, 32),
		AutoButtonColor = false,
		Font = Enum.Font.Gotham,
		FontFace = fontFix{
			Family = "rbxasset://fonts/families/GothamSSm.json",
			Weight = Enum.FontWeight.Regular,
			Style = Enum.FontStyle.Normal
		},
		RichText = true,
		Text = "LOGIN",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 16,
	})

	local loginButtonStroke = createObject("UIStroke", {
		Parent = loginButton,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(115, 238, 101),
		LineJoinMode = Enum.LineJoinMode.Miter,
		Thickness = 0.7,
	})

	local adjustButton = createObject("ImageButton", {
		Name = "adjust",
		Parent = loginButton,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		LayoutOrder = 6,
		Position = UDim2.new(0.936, 0, 0.5, 0),
		Size = UDim2.new(0, 15, 0, 15),
		ZIndex = 2,
		Image = "rbxassetid://3926307971",
		ImageRectOffset = Vector2.new(444, 324),
		ImageRectSize = Vector2.new(36, 36),
	})

	local loginButtonPadding = createObject("UIPadding", {Parent = loginButton, PaddingRight = UDim.new(0, 15)})

	local keyInput = createObject("TextBox", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(61, 61, 61),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.0644, 0, 0.2664, 0),
		Size = UDim2.new(0, 353, 0, 32),
		CursorPosition = -1,
		Font = Enum.Font.SourceSans,
		FontFace = fontFix{
			Family = "rbxasset://fonts/families/SourceSansPro.json",
			Weight = Enum.FontWeight.Regular,
			Style = Enum.FontStyle.Normal
		},
		PlaceholderText = "Enter Key or Code provided by work.ink",
		Text = "",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local keyInputStroke = createObject("UIStroke", {
		Parent = keyInput,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(99, 99, 99),
		LineJoinMode = Enum.LineJoinMode.Miter,
		Thickness = 0.7,
	})

	local keyInputPadding = createObject("UIPadding", {Parent = keyInput, PaddingLeft = UDim.new(0, 14)})

	local getLinkButton = createObject("TextButton", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(83, 145, 162),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.2941, 0, 0.4015, 0),
		Size = UDim2.new(0, 126, 0, 32),
		AutoButtonColor = false,
		Font = Enum.Font.Gotham,
		FontFace = fontFix{
			Family = "rbxasset://fonts/families/GothamSSm.json",
			Weight = Enum.FontWeight.Regular,
			Style = Enum.FontStyle.Normal
		},
		RichText = true,
		Text = "GET LINK",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 16,
	})

	local getLinkButtonStroke = createObject("UIStroke", {
		Parent = getLinkButton,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(124, 221, 243),
		LineJoinMode = Enum.LineJoinMode.Miter,
		Thickness = 0.7,
		Transparency = 0.1,
	})

	local linkIcon = createObject("ImageButton", {
		Name = "link",
		Parent = getLinkButton,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.9154, 0, 0.5, 0),
		Size = UDim2.new(0, 15, 0, 15),
		ZIndex = 2,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(164, 404),
		ImageRectSize = Vector2.new(36, 36),
	})

	local getLinkPadding = createObject("UIPadding", {Parent = getLinkButton, PaddingRight = UDim.new(0, 22)})

	local lockIcon = createObject("ImageButton", {
		Name = "lock",
		Parent = mainFrame,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.6135, 0, 0.4432, 0),
		Size = UDim2.new(0, 17, 0, 17),
		ZIndex = 2,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(4, 684),
		ImageRectSize = Vector2.new(36, 36),
		ImageTransparency = 0.66,
	})

	local cancelButton = createObject("TextButton", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(153, 88, 88),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.064, 0, 0.8338, 0),
		Size = UDim2.new(0, 95, 0, 32),
		AutoButtonColor = false,
		Font = Enum.Font.Gotham,
		FontFace = fontFix{
			Family = "rbxasset://fonts/families/GothamSSm.json",
			Weight = Enum.FontWeight.Regular,
			Style = Enum.FontStyle.Normal
		},
		RichText = true,
		Text = "CANCEL",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 16,
	})

	local cancelButtonStroke = createObject("UIStroke", {
		Parent = cancelButton,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(255, 151, 151),
		LineJoinMode = Enum.LineJoinMode.Miter,
		Thickness = 0.7,
	})

	local cancelButtonPadding = createObject("UIPadding", {Parent = cancelButton, PaddingRight = UDim.new(0, 15)})

	local closeIcon = createObject("ImageButton", {
		Name = "close",
		Parent = cancelButton,
		AnchorPoint = Vector2.new(0.5, 0.5),
		LayoutOrder = 5,
		BackgroundTransparency = 1,
		Position = UDim2.new(0.936, 0, 0.5, 0),
		Size = UDim2.new(0, 15, 0, 15),
		ZIndex = 2,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(284, 4),
		ImageRectSize = Vector2.new(24, 24),
	})

	local function tweenObject(target, easingStyle, duration, easingDirection, properties)
		game.TweenService:Create(target, TweenInfo.new(duration, easingStyle, easingDirection), properties):Play()
	end

	local httpRequest = (syn and syn.request) or (http and http.request) or http_request

	local function getUrlBody(url)
		return httpRequest({
			Url = url,
			Method = "GET",
			Headers = {["Content-Type"] = "application/json"},
		}).Body
	end

	local function isKeyValid(key)
		key = key .. 'W'
		key = tostring(key):sub(1, 36)
		local decoded = game.HttpService:JSONDecode(getUrlBody('https://redirect-api.work.ink/tokenValid/' .. key))
		return decoded.valid
	end

	local function playClickEffect(parent)
		parent.ClipsDescendants = true
		local effectFrame = createObject("Frame", {
			Parent = parent,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.8,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 0, 0, 0),
		})
		local effectCorner = createObject("UICorner", {Parent = effectFrame, CornerRadius = UDim.new(1, 0)})
		tweenObject(effectFrame, Enum.EasingStyle.Circular, 1, Enum.EasingDirection.Out, {Size = UDim2.new(0, 150, 0, 150)})
		tweenObject(effectFrame, Enum.EasingStyle.Circular, 0.5, Enum.EasingDirection.Out, {BackgroundTransparency = 1})
	end

	local function shakeFrame(frame)
		local originalPos = frame.Position
		tweenObject(frame, Enum.EasingStyle.Elastic, 0.4, Enum.EasingDirection.InOut, {Position = UDim2.new(0.415, 0, 0.5, 0)})
		tweenObject(frame, Enum.EasingStyle.Circular, 0.3, Enum.EasingDirection.Out, {Size = UDim2.new(0, 474, 0, 314)})
		wait(0.1)
		tweenObject(frame, Enum.EasingStyle.Elastic, 0.4, Enum.EasingDirection.InOut, {Position = UDim2.new(0.59, 0, 0.5, 0)})
		wait(0.1)
		tweenObject(frame, Enum.EasingStyle.Circular, 0.3, Enum.EasingDirection.Out, {Size = UDim2.new(0, 489, 0, 344)})
		tweenObject(frame, Enum.EasingStyle.Circular, 0.2, Enum.EasingDirection.Out, {Position = originalPos})
	end

	local function playSound(assetId)
		local sound = Instance.new("Sound")
		sound.Parent = game.SoundService
		sound.SoundId = "rbxassetid://" .. assetId
		sound.PlayOnRemove = true
		sound:Destroy()
	end

	local function closeGui()
		tweenObject(mainFrame, Enum.EasingStyle.Circular, 0.3, Enum.EasingDirection.Out, {Size = UDim2.new(0, 0, 0, 0)})
		wait(0.3)
		mainGui:Destroy()
	end

	-- Draggable implementation (works on PC & Mobile)
	do
		local dragging = false
		local dragInput = nil
		local dragStart = nil
		local startPos = nil

		local function update(input)
			if not dragging then return end
			local delta = input.Position - dragStart
			-- keep scale the same, only adjust offset
			mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end

		-- Start drag only when the input target is the mainFrame itself (prevents drag when interacting with buttons/textbox)
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				-- input.Target is the GUI object that was clicked/touched
				if input.Target == mainFrame then
					dragging = true
					dragStart = input.Position
					startPos = mainFrame.Position
					dragInput = input
					-- For touch, InputChanged will be fired for the touch input; for mouse, InputChanged will be fired as well
				end
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)

		-- End dragging when input ends (mouse button up or touch end)
		UserInputService.InputEnded:Connect(function(input, gameProcessed)
			if input == dragInput then
				dragging = false
				dragInput = nil
				dragStart = nil
				startPos = nil
			end
		end)
	end
	-- End draggable

	-- Animate GUI on open
	tweenObject(mainFrame, Enum.EasingStyle.Circular, 0.3, Enum.EasingDirection.Out, {Size = UDim2.new(0, 489, 0, 344)})
	playSound(8379220604)

	local Whitelisted = false

	loginButton.MouseButton1Down:Connect(function()
		playSound(7433801607)
		playClickEffect(loginButton)
		wait(0.2)
		if keyInput.Text:len() == 36 and isKeyValid(keyInput.Text) then
			Whitelisted = true
			playSound(3422389728)
			wait(0.2)
			closeGui()
		else
			playSound(654933750)
			shakeFrame(mainFrame)
		end
	end)

	cancelButton.MouseButton1Down:Connect(function()
		playClickEffect(cancelButton)
		playSound(1524543584)
		closeGui()
	end)

	getLinkButton.MouseButton1Down:Connect(function()
		playSound(7433801607)
		playClickEffect(getLinkButton)
		setclipboard(tostring(clipboardText))
	end)

	repeat wait() until Whitelisted
end

return WhitelistCreate
