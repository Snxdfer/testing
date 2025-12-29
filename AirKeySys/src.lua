-- By 00Fazee 31/08/2025
-- Air Key System v1.1 (UI Escalada - Código completo)

local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")

-- intenta crear Font/FontFace de manera compatible
local function fontFix(arg)
	-- En algunos entornos Font.new está disponible; si no, devuelve nil y usa Enum.Font por compatibilidad
	local ok, f = pcall(function() return Font.new(arg.Family, arg.Weight, arg.Style) end)
	if ok and f then
		return f
	end
	return nil
end

local function createObject(className, properties)
	local obj = Instance.new(className)
	local parentObj = nil
	for propName, propValue in pairs(properties or {}) do
		if propName ~= "Parent" then
			-- proteger asignaciones que pueden fallar
			pcall(function() obj[propName] = propValue end)
		else
			parentObj = propValue
		end
	end
	-- asignar Parent al final (si es nil, queda en nil y el script puede setearlo)
	obj.Parent = parentObj
	return obj
end

local function WhitelistCreate(titleText, descText, clipboardText)
	-- eliminar GUI existente
	local existingGui = game.CoreGui:FindFirstChild("Rnd")
	if existingGui then
		existingGui:Destroy()
	end

	-- root
	local mainGui = createObject("ScreenGui", {
		Name = "Rnd",
		Parent = game.CoreGui,
		ResetOnSpawn = false,
	})

	-- frame principal (más grande)
	local mainFrame = createObject("Frame", {
		Parent = mainGui,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 0), -- animará desde 0
		BackgroundColor3 = Color3.fromRGB(27, 27, 27),
		BorderSizePixel = 0,
		ClipsDescendants = true,
	})
	createObject("UICorner", {Parent = mainFrame, CornerRadius = UDim.new(0, 12)})
	createObject("UIStroke", {Parent = mainFrame, Thickness = 4, Transparency = 0.85})

	-- TÍTULO
	local titleLabel = createObject("TextLabel", {
		Parent = mainFrame,
		BackgroundTransparency = 1,
		Position = UDim2.new(0.06, 0, 0.06, 0),
		Size = UDim2.new(0, 360, 0, 30),
		Font = Enum.Font.Gotham,
		Text = titleText or "Air Key",
		TextColor3 = Color3.fromRGB(255,255,255),
		TextSize = 20,
		TextXAlignment = Enum.TextXAlignment.Left,
	})
	-- intentar FontFace personalizado si disponible
	local ff = fontFix{
		Family = "rbxasset://fonts/families/GothamSSm.json",
		Weight = Enum.FontWeight.Regular,
		Style = Enum.FontStyle.Normal
	}
	if ff then pcall(function() titleLabel.FontFace = ff end) end

	-- DESCRIPCIÓN
	local descLabel = createObject("TextLabel", {
		Parent = mainFrame,
		BackgroundTransparency = 1,
		Position = UDim2.new(0.06, 0, 0.13, 0),
		Size = UDim2.new(0, 380, 0, 20),
		Font = Enum.Font.Gotham,
		Text = descText or "A simple key system using work.ink",
		TextColor3 = Color3.fromRGB(255,255,255),
		TextSize = 13,
		TextTransparency = 0.35,
		TextXAlignment = Enum.TextXAlignment.Left,
	})
	if ff then pcall(function() descLabel.FontFace = ff end) end

	-- IMAGEN DECORATIVA (fondo sutil)
	local mainImage = createObject("ImageLabel", {
		Parent = mainFrame,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0.45, 0),
		Size = UDim2.new(0, 420, 0, 140),
		Image = "http://www.roblox.com/asset/?id=277037193",
		ImageTransparency = 0.95,
		Selectable = false,
	})
	createObject("UICorner", {Parent = mainImage, CornerRadius = UDim.new(0, 8)})

	-- INPUT (más grande)
	local keyInput = createObject("TextBox", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(61,61,61),
		BorderSizePixel = 0,
		Position = UDim2.new(0.06, 0, 0.22, 0),
		Size = UDim2.new(0, 320, 0, 34),
		PlaceholderText = "Enter Key or Code provided by work.ink",
		Text = "",
		TextColor3 = Color3.fromRGB(255,255,255),
		TextSize = 14,
		Font = Enum.Font.SourceSans,
		TextXAlignment = Enum.TextXAlignment.Left,
		CursorPosition = -1,
	})
	createObject("UICorner", {Parent = keyInput, CornerRadius = UDim.new(0, 6)})
	createObject("UIPadding", {Parent = keyInput, PaddingLeft = UDim.new(0, 10)})
	createObject("UIStroke", {Parent = keyInput, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(99,99,99), Thickness = 0.8})

	-- BOTONES grandes
	local loginButton = createObject("TextButton", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(91,161,78),
		BorderSizePixel = 0,
		Position = UDim2.new(0.06, 0, 0.305, 0),
		Size = UDim2.new(0, 100, 0, 34),
		AutoButtonColor = false,
		Font = Enum.Font.Gotham,
		Text = "LOGIN",
		TextColor3 = Color3.fromRGB(255,255,255),
		TextSize = 15,
	})
	createObject("UICorner", {Parent = loginButton, CornerRadius = UDim.new(0, 6)})
	createObject("UIStroke", {Parent = loginButton, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(115,238,101), Thickness = 1})

	local getLinkButton = createObject("TextButton", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(83,145,162),
		BorderSizePixel = 0,
		Position = UDim2.new(0.30, 0, 0.305, 0),
		Size = UDim2.new(0, 140, 0, 34),
		AutoButtonColor = false,
		Font = Enum.Font.Gotham,
		Text = "GET LINK",
		TextColor3 = Color3.fromRGB(255,255,255),
		TextSize = 15,
	})
	createObject("UICorner", {Parent = getLinkButton, CornerRadius = UDim.new(0, 6)})
	createObject("UIStroke", {Parent = getLinkButton, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(124,221,243), Thickness = 1, Transparency = 0.15})

	local cancelButton = createObject("TextButton", {
		Parent = mainFrame,
		BackgroundColor3 = Color3.fromRGB(153,88,88),
		BorderSizePixel = 0,
		Position = UDim2.new(0.06, 0, 0.82, 0),
		Size = UDim2.new(0, 100, 0, 34),
		AutoButtonColor = false,
		Font = Enum.Font.Gotham,
		Text = "CANCEL",
		TextColor3 = Color3.fromRGB(255,255,255),
		TextSize = 15,
	})
	createObject("UICorner", {Parent = cancelButton, CornerRadius = UDim.new(0, 6)})
	createObject("UIStroke", {Parent = cancelButton, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255,151,151), Thickness = 1})

	-- ICONOS (más grandes) - usando image sprites integradas
	local adjustIcon = createObject("ImageButton", {
		Name = "adjust",
		Parent = loginButton,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.91, 0, 0.5, 0),
		Size = UDim2.new(0, 16, 0, 16),
		Image = "rbxassetid://3926307971",
		ImageRectOffset = Vector2.new(444, 324),
		ImageRectSize = Vector2.new(36, 36),
	})
	local linkIcon = createObject("ImageButton", {
		Name = "link",
		Parent = getLinkButton,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.92, 0, 0.5, 0),
		Size = UDim2.new(0, 16, 0, 16),
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(164, 404),
		ImageRectSize = Vector2.new(36, 36),
	})
	local closeIcon = createObject("ImageButton", {
		Name = "close",
		Parent = cancelButton,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.91, 0, 0.5, 0),
		Size = UDim2.new(0, 16, 0, 16),
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(284, 4),
		ImageRectSize = Vector2.new(24, 24),
	})

	-- lock icon decorativo
	local lockIcon = createObject("ImageButton", {
		Name = "lock",
		Parent = mainFrame,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.74, 0, 0.30, 0),
		Size = UDim2.new(0, 20, 0, 20),
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(4, 684),
		ImageRectSize = Vector2.new(36, 36),
		ImageTransparency = 0.6,
	})

	-- util: tween genérico
	local function tweenObject(target, duration, properties, style, direction)
		style = style or Enum.EasingStyle.Circular
		direction = direction or Enum.EasingDirection.Out
		local ti = TweenInfo.new(duration, style, direction)
		local t = TweenService:Create(target, ti, properties)
		t:Play()
		return t
	end

	-- http request fallback (syn, request, or http_request)
	local httpRequest = nil
	if syn and syn.request then
		httpRequest = syn.request
	elseif http and http.request then
		httpRequest = http.request
	elseif http_request then
		httpRequest = http_request
	end

	local function getUrlBody(url)
		if not httpRequest then
			return nil
		end
		local ok, res = pcall(function()
			return httpRequest({Url = url, Method = "GET", Headers = {["Content-Type"] = "application/json"}})
		end)
		if not ok or not res then return nil end
		return res.Body
	end

	-- valida la key usando work.ink (mismo comportamiento: agrega 'W' y corta a 36)
	local function isKeyValid(key)
		if not key or type(key) ~= "string" then return false end
		local tkey = key .. "W"
		tkey = tostring(tkey):sub(1, 36)
		local body = getUrlBody("https://redirect-api.work.ink/tokenValid/" .. tkey)
		if not body then return false end
		local ok, decoded = pcall(function() return HttpService:JSONDecode(body) end)
		if not ok or type(decoded) ~= "table" then return false end
		return decoded.valid and true or false
	end

	-- efectos
	local function playClickEffect(parent)
		if not parent then return end
		parent.ClipsDescendants = true
		local effect = createObject("Frame", {
			Parent = parent,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 0, 0, 0),
			BackgroundColor3 = Color3.fromRGB(255,255,255),
			BackgroundTransparency = 0.8,
			BorderSizePixel = 0,
		})
		createObject("UICorner", {Parent = effect, CornerRadius = UDim.new(1,0)})
		tweenObject(effect, 0.9, {Size = UDim2.new(0, 120, 0, 120)}, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
		tweenObject(effect, 0.45, {BackgroundTransparency = 1}, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
		delay(1, function() if effect and effect.Parent then effect:Destroy() end end)
	end

	local function shakeFrame(frame)
		if not frame then return end
		local orig = frame.Position
		tweenObject(frame, 0.12, {Position = orig + UDim2.new(0,-10,0,0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		wait(0.08)
		tweenObject(frame, 0.10, {Position = orig + UDim2.new(0,10,0,0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		wait(0.08)
		tweenObject(frame, 0.12, {Position = orig}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	end

	local function playSound(assetId)
		if not assetId then return end
		local s = Instance.new("Sound")
		s.Parent = SoundService
		s.SoundId = "rbxassetid://" .. tostring(assetId)
		s.PlayOnRemove = true
		pcall(function() s:Destroy() end)
	end

	local function closeGui()
		tweenObject(mainFrame, 0.25, {Size = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Circular, Enum.EasingDirection.In)
		wait(0.3)
		if mainGui and mainGui.Parent then
			mainGui:Destroy()
		end
	end

	-- animación apertura + sonido
	tweenObject(mainFrame, 0.35, {Size = UDim2.new(0, 420, 0, 320)}, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
	playSound(8379220604)

	-- lógica de botones
	local Whitelisted = false

	loginButton.MouseButton1Down:Connect(function()
		playSound(7433801607)
		playClickEffect(loginButton)
		wait(0.18)
		local keyText = tostring(keyInput.Text or "")
		if keyText:len() == 36 and isKeyValid(keyText) then
			Whitelisted = true
			playSound(3422389728)
			wait(0.18)
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
		-- intentar poner en el portapapeles (fallbacks silenciosos)
		pcall(function() setclipboard(tostring(clipboardText or "")) end)
	end)

	-- esperar a que el usuario sea 'Whitelisted' (comportamiento original)
	repeat wait() until Whitelisted
end

return WhitelistCreate
