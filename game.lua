local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local THEME = {
	Background = Color3.fromRGB(10, 10, 12),
	TopBar = Color3.fromRGB(20, 0, 0),
	Accent = Color3.fromRGB(200, 20, 20),
	AccentBright = Color3.fromRGB(255, 40, 40),
	Text = Color3.fromRGB(255, 255, 255),
	TextDim = Color3.fromRGB(180, 180, 180),
	ButtonBg = Color3.fromRGB(25, 25, 28),
	ButtonHover = Color3.fromRGB(45, 10, 10),
	ButtonActive = Color3.fromRGB(120, 10, 10),
	SectionBg = Color3.fromRGB(15, 15, 18),
	Border = Color3.fromRGB(60, 0, 0),
}

local old = playerGui:FindFirstChild("C00lkiddPanel")
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "C00lkiddPanel"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Name = "MainPanel"
panel.Size = UDim2.new(0, 420, 0, 320)
panel.Position = UDim2.new(0.5, -210, 0.5, -160)
panel.BackgroundColor3 = THEME.Background
panel.BorderSizePixel = 0
panel.ClipsDescendants = false
panel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 8)
panelCorner.Parent = panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = THEME.Accent
panelStroke.Thickness = 2
panelStroke.Parent = panel

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 38)
topBar.BackgroundColor3 = THEME.TopBar
topBar.BorderSizePixel = 0
topBar.Parent = panel

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 8)
topCorner.Parent = topBar

local topBarFill = Instance.new("Frame")
topBarFill.Size = UDim2.new(1, 0, 0, 10)
topBarFill.Position = UDim2.new(0, 0, 1, -10)
topBarFill.BackgroundColor3 = THEME.TopBar
topBarFill.BorderSizePixel = 0
topBarFill.Parent = topBar

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "C00lkidd Panel"
title.TextColor3 = THEME.AccentBright
title.Font = Enum.Font.Code
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "Close"
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -33, 0.5, -14)
closeBtn.BackgroundColor3 = THEME.ButtonBg
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = THEME.AccentBright
closeBtn.Font = Enum.Font.Code
closeBtn.TextSize = 14
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

local tabContainer = Instance.new("Frame")
tabContainer.Name = "Tabs"
tabContainer.Size = UDim2.new(0, 110, 1, -38)
tabContainer.Position = UDim2.new(0, 0, 0, 38)
tabContainer.BackgroundColor3 = THEME.SectionBg
tabContainer.BorderSizePixel = 0
tabContainer.Parent = panel

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 8)
tabCorner.Parent = tabContainer

local tabList = Instance.new("UIListLayout")
tabList.Padding = UDim.new(0, 4)
tabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabList.Parent = tabContainer

local contentArea = Instance.new("Frame")
contentArea.Name = "Content"
contentArea.Size = UDim2.new(1, -120, 1, -46)
contentArea.Position = UDim2.new(0, 115, 0, 42)
contentArea.BackgroundTransparency = 1
contentArea.Parent = panel

local dragging = false
local dragStart = nil
local startPos = nil

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = panel.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragging and dragStart and startPos then
			local delta = input.Position - dragStart
			panel.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

closeBtn.MouseEnter:Connect(function()
	closeBtn.BackgroundColor3 = THEME.ButtonActive
end)
closeBtn.MouseLeave:Connect(function()
	closeBtn.BackgroundColor3 = THEME.ButtonBg
end)

local tabs = {}
local activeTab = nil

local function createTab(name)
	local tabBtn = Instance.new("TextButton")
	tabBtn.Size = UDim2.new(1, -8, 0, 32)
	tabBtn.BackgroundColor3 = THEME.ButtonBg
	tabBtn.BorderSizePixel = 0
	tabBtn.Text = name
	tabBtn.TextColor3 = THEME.TextDim
	tabBtn.Font = Enum.Font.Code
	tabBtn.TextSize = 14
	tabBtn.Parent = tabContainer

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = tabBtn

	local content = Instance.new("ScrollingFrame")
	content.Size = UDim2.new(1, 0, 1, 0)
	content.BackgroundTransparency = 1
	content.BorderSizePixel = 0
	content.ScrollBarThickness = 4
	content.ScrollBarImageColor3 = THEME.Accent
	content.CanvasSize = UDim2.new(0, 0, 0, 0)
	content.AutomaticCanvasSize = Enum.AutomaticSize.Y
	content.Visible = false
	content.Parent = contentArea

	local contentList = Instance.new("UIListLayout")
	contentList.Padding = UDim.new(0, 6)
	contentList.Parent = content

	local function activate()
		for _, t in pairs(tabs) do
			t.button.TextColor3 = THEME.TextDim
			t.button.BackgroundColor3 = THEME.ButtonBg
			t.content.Visible = false
		end
		tabBtn.TextColor3 = THEME.AccentBright
		tabBtn.BackgroundColor3 = THEME.ButtonActive
		content.Visible = true
		activeTab = name
	end

	tabBtn.MouseButton1Click:Connect(activate)
	tabBtn.MouseEnter:Connect(function()
		if activeTab ~= name then
			tabBtn.BackgroundColor3 = THEME.ButtonHover
		end
	end)
	tabBtn.MouseLeave:Connect(function()
		if activeTab ~= name then
			tabBtn.BackgroundColor3 = THEME.ButtonBg
		end
	end)

	tabs[name] = { button = tabBtn, content = content }
	return content
end

local function createButton(parent, text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 34)
	btn.BackgroundColor3 = THEME.ButtonBg
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = THEME.Text
	btn.Font = Enum.Font.Code
	btn.TextSize = 14
	btn.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn

	local active = false
	btn.MouseButton1Click:Connect(function()
		active = not active
		if active then
			btn.BackgroundColor3 = THEME.ButtonActive
			btn.TextColor3 = THEME.AccentBright
		else
			btn.BackgroundColor3 = THEME.ButtonBg
			btn.TextColor3 = THEME.Text
		end
		if callback then callback(active) end
	end)

	btn.MouseEnter:Connect(function()
		if not active then btn.BackgroundColor3 = THEME.ButtonHover end
	end)
	btn.MouseLeave:Connect(function()
		if not active then btn.BackgroundColor3 = THEME.ButtonBg end
	end)

	return btn
end

local function createSlider(parent, text, min, max, default, callback)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 50)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.Text = text .. ": " .. tostring(default)
	label.TextColor3 = THEME.TextDim
	label.Font = Enum.Font.Code
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(1, 0, 0, 20)
	sliderBg.Position = UDim2.new(0, 0, 0, 24)
	sliderBg.BackgroundColor3 = THEME.ButtonBg
	sliderBg.BorderSizePixel = 0
	sliderBg.Parent = container

	local sliderCorner = Instance.new("UICorner")
	sliderCorner.CornerRadius = UDim.new(0, 4)
	sliderCorner.Parent = sliderBg

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = THEME.Accent
	fill.BorderSizePixel = 0
	fill.Parent = sliderBg

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 4)
	fillCorner.Parent = fill

	local dragging = false

	local function update(inputPos)
		local rel = math.clamp((inputPos - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
		local value = math.floor(min + rel * (max - min) + 0.5)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		label.Text = text .. ": " .. tostring(value)
		if callback then callback(value) end
	end

	sliderBg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			update(input.Position.X)
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	sliderBg.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement) then
			update(input.Position.X)
		end
	end)

	return container
end

local function createLabel(parent, text)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 24)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = THEME.AccentBright
	lbl.Font = Enum.Font.Code
	lbl.TextSize = 14
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = parent
	return lbl
end

local function createSliderWithInput(parent, text, min, max, default, callback)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 50)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.7, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.Text = text .. ": " .. tostring(default)
	label.TextColor3 = THEME.TextDim
	label.Font = Enum.Font.Code
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local inputBox = Instance.new("TextBox")
	inputBox.Size = UDim2.new(0.25, 0, 0, 20)
	inputBox.Position = UDim2.new(0.73, 0, 0, 0)
	inputBox.BackgroundColor3 = THEME.ButtonBg
	inputBox.BorderSizePixel = 0
	inputBox.Text = tostring(default)
	inputBox.TextColor3 = THEME.AccentBright
	inputBox.Font = Enum.Font.Code
	inputBox.TextSize = 13
	inputBox.ClearTextOnFocus = false
	inputBox.Parent = container

	local inputCorner = Instance.new("UICorner")
	inputCorner.CornerRadius = UDim.new(0, 4)
	inputCorner.Parent = inputBox

	local inputStroke = Instance.new("UIStroke")
	inputStroke.Color = THEME.Accent
	inputStroke.Thickness = 1
	inputStroke.Transparency = 0.5
	inputStroke.Parent = inputBox

	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(1, 0, 0, 20)
	sliderBg.Position = UDim2.new(0, 0, 0, 26)
	sliderBg.BackgroundColor3 = THEME.ButtonBg
	sliderBg.BorderSizePixel = 0
	sliderBg.Parent = container

	local sliderCorner = Instance.new("UICorner")
	sliderCorner.CornerRadius = UDim.new(0, 4)
	sliderCorner.Parent = sliderBg

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = THEME.Accent
	fill.BorderSizePixel = 0
	fill.Parent = sliderBg

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 4)
	fillCorner.Parent = fill

	local dragging = false

	local function setValue(value)
		value = math.clamp(value, min, max)
		local rel = (value - min) / (max - min)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		label.Text = text .. ": " .. tostring(value)
		inputBox.Text = tostring(value)
		if callback then callback(value) end
	end

	local function update(inputPos)
		local rel = math.clamp((inputPos - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
		local value = math.floor(min + rel * (max - min) + 0.5)
		setValue(value)
	end

	sliderBg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			update(input.Position.X)
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	sliderBg.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement) then
			update(input.Position.X)
		end
	end)

	inputBox.FocusLost:Connect(function(enterPressed)
		local value = tonumber(inputBox.Text)
		if value then
			setValue(value)
		else
			inputBox.Text = tostring(default)
		end
	end)

	return container
end

local function createInput(parent, labelText, defaultId, buttonText, callback)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 60)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 18)
	lbl.BackgroundTransparency = 1
	lbl.Text = labelText
	lbl.TextColor3 = THEME.TextDim
	lbl.Font = Enum.Font.Code
	lbl.TextSize = 13
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = container

	local inputBox = Instance.new("TextBox")
	inputBox.Size = UDim2.new(0.6, 0, 0, 30)
	inputBox.Position = UDim2.new(0, 0, 0, 22)
	inputBox.BackgroundColor3 = THEME.ButtonBg
	inputBox.BorderSizePixel = 0
	inputBox.Text = tostring(defaultId)
	inputBox.TextColor3 = THEME.Text
	inputBox.Font = Enum.Font.Code
	inputBox.TextSize = 14
	inputBox.PlaceholderText = "Enter ID..."
	inputBox.PlaceholderColor3 = THEME.TextDim
	inputBox.ClearTextOnFocus = false
	inputBox.Parent = container

	local inputCorner = Instance.new("UICorner")
	inputCorner.CornerRadius = UDim.new(0, 6)
	inputCorner.Parent = inputBox

	local inputStroke = Instance.new("UIStroke")
	inputStroke.Color = THEME.Accent
	inputStroke.Thickness = 1
	inputStroke.Transparency = 0.5
	inputStroke.Parent = inputBox

	local applyBtn = Instance.new("TextButton")
	applyBtn.Size = UDim2.new(0.35, 0, 0, 30)
	applyBtn.Position = UDim2.new(0.63, 0, 0, 22)
	applyBtn.BackgroundColor3 = THEME.ButtonBg
	applyBtn.BorderSizePixel = 0
	applyBtn.Text = buttonText
	applyBtn.TextColor3 = THEME.AccentBright
	applyBtn.Font = Enum.Font.Code
	applyBtn.TextSize = 13
	applyBtn.Parent = container

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = applyBtn

	applyBtn.MouseEnter:Connect(function()
		applyBtn.BackgroundColor3 = THEME.ButtonHover
	end)
	applyBtn.MouseLeave:Connect(function()
		applyBtn.BackgroundColor3 = THEME.ButtonBg
	end)

	applyBtn.MouseButton1Click:Connect(function()
		local id = tonumber(inputBox.Text)
		if id then
			callback(id)
		end
	end)

	inputBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local id = tonumber(inputBox.Text)
			if id then
				callback(id)
			end
		end
	end)

	return container, inputBox
end

local playerTab = createTab("Player")

createLabel(playerTab, "-- Player Options")

createButton(playerTab, "WalkSpeed x2", function(active)
	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = active and 32 or 16
		end
	end
end)

createButton(playerTab, "JumpPower x2", function(active)
	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.UseJumpPower = true
			hum.JumpPower = active and 100 or 50
		end
	end
end)

createButton(playerTab, "Infinite Jump", function(active)
	if active then
		local conn
		conn = UserInputService.JumpRequest:Connect(function()
			local char = player.Character
			if char then
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then
					hum:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
			end)
		_G.C00lkiddInfJump = conn
	else
		if _G.C00lkiddInfJump then
			_G.C00lkiddInfJump:Disconnect()
			_G.C00lkiddInfJump = nil
		end
	end
end)

createButton(playerTab, "Noclip", function(active)
	local function setupNoclip()
		local char = player.Character
		if char then
			for _, part in pairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = not active
				end
			end
		end
	end
	setupNoclip()
	if active then
		_G.C00lkiddNoclip = RunService.Stepped:Connect(setupNoclip)
	else
		if _G.C00lkiddNoclip then
			_G.C00lkiddNoclip:Disconnect()
			_G.C00lkiddNoclip = nil
		end
		setupNoclip()
	end
end)

createSliderWithInput(playerTab, "WalkSpeed", 16, 200, 16, function(value)
	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = value
		end
	end
end)

createSliderWithInput(playerTab, "JumpPower", 50, 300, 50, function(value)
	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.UseJumpPower = true
			hum.JumpPower = value
		end
	end
end)

local visualsTab = createTab("Visuals")

createLabel(visualsTab, "-- Sky Changer")

createInput(visualsTab, "Sky Texture ID:", 178993745, "Apply", function(id)
	local lighting = game:GetService("Lighting")
	local sky = lighting:FindFirstChildOfClass("Sky")
	if not sky then
		sky = Instance.new("Sky")
		sky.Parent = lighting
	end
	sky.SkyboxBk = "rbxassetid://" .. id
	sky.SkyboxDn = "rbxassetid://" .. id
	sky.SkyboxFt = "rbxassetid://" .. id
	sky.SkyboxLf = "rbxassetid://" .. id
	sky.SkyboxRt = "rbxassetid://" .. id
	sky.SkyboxUp = "rbxassetid://" .. id
	sky.StarCount = 0
end)

createButton(visualsTab, "Reset Sky", function(active)
	local lighting = game:GetService("Lighting")
	local sky = lighting:FindFirstChildOfClass("Sky")
	if sky then
		sky:Destroy()
	end
end)

createLabel(visualsTab, "-- Image / Decal Changer")

createInput(visualsTab, "Image ID:", 178993745, "Apply", function(id)
	local faces = {
		Enum.NormalId.Front,
		Enum.NormalId.Back,
		Enum.NormalId.Top,
		Enum.NormalId.Bottom,
		Enum.NormalId.Left,
		Enum.NormalId.Right,
	}

	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			for _, child in pairs(v:GetChildren()) do
				if child:IsA("Decal") and child.Name == "C00lkiddDecal" then
					child:Destroy()
				end
			end
			for _, face in ipairs(faces) do
				local decal = Instance.new("Decal")
				decal.Name = "C00lkiddDecal"
				decal.Texture = "rbxassetid://" .. id
				decal.Face = face
				decal.Parent = v
			end
		end
	end
end)

createLabel(visualsTab, "-- Music Player")

local currentSound = nil

createInput(visualsTab, "Sound ID:", 178993745, "Play", function(id)
	if currentSound then
		currentSound:Stop()
		currentSound:Destroy()
	end

	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. id
	sound.Volume = 5
	sound.Looped = true
	sound.Parent = workspace
	sound:Play()
	currentSound = sound
end)

createButton(visualsTab, "Random Music", function(active)
	local musicIds = {
		139063675026894,
		94635984925376,
		115866242800115,
	}
	local randomId = musicIds[math.random(1, #musicIds)]

	if currentSound then
		currentSound:Stop()
		currentSound:Destroy()
	end

	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. randomId
	sound.Volume = 1
	sound.Looped = true
	sound.Parent = workspace
	sound:Play()
	currentSound = sound
end)

createButton(visualsTab, "Stop Music", function(active)
	if currentSound then
		currentSound:Stop()
		currentSound:Destroy()
		currentSound = nil
	end
end)

createSlider(visualsTab, "Volume", 0, 10, 5, function(value)
	if currentSound then
		currentSound.Volume = value / 10
	end
end)

local serverTab = createTab("Server")

createLabel(serverTab, "-- Server Info")

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0, 60)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Loading server info..."
infoLabel.TextColor3 = THEME.TextDim
infoLabel.Font = Enum.Font.Code
infoLabel.TextSize = 13
infoLabel.TextWrapped = true
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.Parent = serverTab

local function updateServerInfo()
	local players = Players:GetPlayers()
	local info = "Players online: " .. #players .. "\n"
	info = info .. "JobId: " .. game.JobId .. "\n"
	info = info .. "PlaceId: " .. game.PlaceId
	infoLabel.Text = info
end
updateServerInfo()

createLabel(serverTab, "-- Server Actions")

createButton(serverTab, "FPS Boost", function(active)
	if active then
		local lighting = game:GetService("Lighting")
		lighting.GlobalShadows = false
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Material = Enum.Material.Plastic
				v.Reflectance = 0
			end
		end
	else
		game:GetService("Lighting").GlobalShadows = true
	end
end)

createButton(serverTab, "Explode All Players", function(active)
	for _, p in pairs(Players:GetPlayers()) do
		local char = p.Character
		if char then
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then
				local explosion = Instance.new("Explosion")
				explosion.Position = hrp.Position
				explosion.BlastRadius = 10
				explosion.BlastPressure = 500000
				explosion.Parent = workspace
			end
		end
	end
end)

createButton(serverTab, "Laugh", function(active)
	local laughIds = {
		134465374070275,
		140669499902711,
		118512462005633,
		94262129366372,
		104859502529902,
	}
	local randomId = laughIds[math.random(1, #laughIds)]
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. randomId
	sound.Volume = 1
	sound.Parent = workspace
	sound:Play()
	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end)

createButton(serverTab, "Anti-AFK", function(active)
	if active then
		local vu = game:GetService("VirtualUser")
		_G.C00lkiddAntiAFK = game:GetService("RunService").RenderStepped:Connect(function()
		end)
		_G.C00lkiddAntiAFK2 = task.spawn(function()
			while true do
				task.wait(120)
				local char = player.Character
				if char and char:FindFirstChild("Humanoid") then
					local hum = char:FindFirstChild("Humanoid")
					hum:ChangeState(Enum.HumanoidStateType.Seated)
					task.wait(0.1)
					hum:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
			end
		end)
	else
		if _G.C00lkiddAntiAFK then
			_G.C00lkiddAntiAFK:Disconnect()
			_G.C00lkiddAntiAFK = nil
		end
		if _G.C00lkiddAntiAFK2 then
			task.cancel(_G.C00lkiddAntiAFK2)
			_G.C00lkiddAntiAFK2 = nil
		end
	end
end)

tabs["Player"].button.TextColor3 = THEME.AccentBright
tabs["Player"].button.BackgroundColor3 = THEME.ButtonActive
tabs["Player"].content.Visible = true
activeTab = "Player"

panel.Size = UDim2.new(0, 420, 0, 0)
panel.ClipsDescendants = true
TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 420, 0, 320)
}):Play()
task.wait(0.3)
panel.ClipsDescendants = false
