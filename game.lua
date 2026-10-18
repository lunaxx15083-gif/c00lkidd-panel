local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local foundRemotes = {}
local function scanRemotes()
	table.clear(foundRemotes)
	for _, obj in game:GetDescendants() do
		if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
			table.insert(foundRemotes, obj)
			print("[C00lkidd Scan] remote:", obj.ClassName, obj:GetFullName())
		end
	end
	print("[C00lkidd Scan] remotes: " .. #foundRemotes)
end
task.spawn(function()
	scanRemotes()
end)
game.DescendantAdded:Connect(function(obj)
	if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
		table.insert(foundRemotes, obj)
		print("[C00lkidd Scan] remote:", obj.ClassName, obj:GetFullName())
	end
end)
local function fireAllRemotes(...)
	if #foundRemotes == 0 then return false end
	local args = {...}
	for _, remote in pairs(foundRemotes) do
		pcall(function()
			if remote:IsA("RemoteEvent") then
				remote:FireServer(table.unpack(args))
			elseif remote:IsA("RemoteFunction") then
				remote:InvokeServer(table.unpack(args))
			end
		end)
	end
	return true
end
local featureData = {}
local function startFeature(name, func)
	if featureData[name] then return end
	local data = {connections = {}}
	featureData[name] = data
	data.thread = task.spawn(func, data.connections)
end
local function stopFeature(name)
	local data = featureData[name]
	if not data then return end
	if data.thread then
		task.cancel(data.thread)
	end
	if data.connections then
		for _, conn in pairs(data.connections) do
			conn:Disconnect()
		end
	end
	featureData[name] = nil
end
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
local oldBanner = playerGui:FindFirstChild("C00lkiddBanner")
if oldBanner then oldBanner:Destroy() end
local oldTopText = playerGui:FindFirstChild("C00lkiddTopText")
if oldTopText then oldTopText:Destroy() end
local old = playerGui:FindFirstChild("C00lkiddPanel")
if old then old:Destroy() end
local bannerGui = Instance.new("ScreenGui")
bannerGui.Name = "C00lkiddBanner"
bannerGui.ResetOnSpawn = false
bannerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
bannerGui.IgnoreGuiInset = true
bannerGui.Parent = playerGui
local banner = Instance.new("TextLabel")
banner.Name = "BannerText"
banner.Size = UDim2.new(1, 0, 0, 35)
banner.Position = UDim2.new(0, 0, 0, 0)
banner.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
banner.Text = "C00LKID HACKING IS PLACE!"
banner.TextColor3 = Color3.fromRGB(255, 255, 255)
banner.Font = Enum.Font.Code
banner.TextSize = 20
banner.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
banner.TextStrokeTransparency = 0.3
banner.Parent = bannerGui
local removeBannerBtn = Instance.new("TextButton")
removeBannerBtn.Size = UDim2.new(0, 80, 0, 22)
removeBannerBtn.Position = UDim2.new(1, -85, 0.5, -11)
removeBannerBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
removeBannerBtn.BorderSizePixel = 0
removeBannerBtn.Text = "REMOVE"
removeBannerBtn.TextColor3 = THEME.AccentBright
removeBannerBtn.Font = Enum.Font.Code
removeBannerBtn.TextSize = 12
removeBannerBtn.Parent = banner
local rbCorner = Instance.new("UICorner")
rbCorner.CornerRadius = UDim.new(0, 4)
rbCorner.Parent = removeBannerBtn
removeBannerBtn.MouseButton1Click:Connect(function()
	bannerGui:Destroy()
end)
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
title.Size = UDim2.new(1, -130, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "C00LKID HACKING IS PLACE!"
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
local biggerBtn = Instance.new("TextButton")
biggerBtn.Name = "Fullscreen"
biggerBtn.Size = UDim2.new(0, 24, 0, 24)
biggerBtn.Position = UDim2.new(1, -60, 0.5, -12)
biggerBtn.BackgroundColor3 = THEME.ButtonBg
biggerBtn.BorderSizePixel = 0
biggerBtn.Text = "□"
biggerBtn.TextColor3 = THEME.AccentBright
biggerBtn.Font = Enum.Font.Code
biggerBtn.TextSize = 16
biggerBtn.Parent = topBar
local fsCorner = Instance.new("UICorner")
fsCorner.CornerRadius = UDim.new(0, 5)
fsCorner.Parent = biggerBtn
local isFullscreen = false
local previousSize, previousPosition
biggerBtn.MouseButton1Click:Connect(function()
	if not isFullscreen then
		previousSize = panel.Size
		previousPosition = panel.Position
		local camera = workspace.CurrentCamera
		local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)
		panel.Position = UDim2.fromOffset(0, 0)
		panel.Size = UDim2.fromOffset(viewport.X, viewport.Y)
		biggerBtn.Text = "↙"
		isFullscreen = true
	else
		panel.Size = previousSize or UDim2.fromOffset(420, 320)
		panel.Position = previousPosition or UDim2.new(0.5, -210, 0.5, -160)
		biggerBtn.Text = "□"
		isFullscreen = false
	end
end)
local tabContainer = Instance.new("ScrollingFrame")
tabContainer.Name = "Tabs"
tabContainer.Size = UDim2.new(0, 110, 1, -38)
tabContainer.Position = UDim2.new(0, 0, 0, 38)
tabContainer.BackgroundColor3 = THEME.SectionBg
tabContainer.BorderSizePixel = 0
tabContainer.ScrollBarThickness = 4
tabContainer.ScrollBarImageColor3 = THEME.Accent
tabContainer.ScrollingDirection = Enum.ScrollingDirection.Y
tabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
tabContainer.ClipsDescendants = true
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
local MIN_WIDTH, MIN_HEIGHT = 320, 250
local EDGE = 14
local resizing = false
local resizeStart = nil
local resizeSize = nil
local resizePosition = nil
local resizeDirection = nil
local function makeResizeHandle(name, position, size, direction)
	local handle = Instance.new("TextButton")
	handle.Name = name
	handle.Position = position
	handle.Size = size
	handle.BackgroundTransparency = 1
	handle.BorderSizePixel = 0
	handle.Text = ""
	handle.AutoButtonColor = false
	handle.Active = true
	handle.ZIndex = 1000
	handle.Parent = panel
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = true
			resizeStart = input.Position
			resizeSize = panel.Size
			resizePosition = panel.Position
			resizeDirection = direction
		end
	end)
	return handle
end
makeResizeHandle("ResizeBottom", UDim2.new(0, EDGE, 1, -EDGE), UDim2.new(1, -EDGE * 2, 0, EDGE), "B")
makeResizeHandle("ResizeBottomRight", UDim2.new(1, -EDGE, 1, -EDGE), UDim2.fromOffset(EDGE, EDGE), "BR")
makeResizeHandle("ResizeBottomLeft", UDim2.new(0, 0, 1, -EDGE), UDim2.fromOffset(EDGE, EDGE), "BL")
UserInputService.InputChanged:Connect(function(input)
	if not resizing or not resizeStart or not resizeSize or not resizePosition then return end
	if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
	local delta = input.Position - resizeStart
	local width = resizeSize.X.Offset
	local height = math.max(MIN_HEIGHT, resizeSize.Y.Offset + delta.Y)
	local posX = resizePosition.X
	if resizeDirection == "BR" then
		width = math.max(MIN_WIDTH, resizeSize.X.Offset + delta.X)
	elseif resizeDirection == "BL" then
		width = math.max(MIN_WIDTH, resizeSize.X.Offset - delta.X)
		posX = UDim.new(resizePosition.X.Scale, resizePosition.X.Offset + resizeSize.X.Offset - width)
	end
	panel.Size = UDim2.fromOffset(width, height)
	panel.Position = UDim2.new(posX.Scale, posX.Offset, resizePosition.Y.Scale, resizePosition.Y.Offset)
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = false
		resizeStart, resizeSize, resizePosition, resizeDirection = nil, nil, nil, nil
	end
end)
local reopenGui = Instance.new("ScreenGui")
reopenGui.Name = "C00lkiddReopen"
reopenGui.ResetOnSpawn = false
reopenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
reopenGui.IgnoreGuiInset = true
reopenGui.Parent = playerGui
local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(0, 120, 0, 120)
reopenBtn.Position = UDim2.new(0, 10, 0, 40)
reopenBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
reopenBtn.BorderSizePixel = 0
reopenBtn.Text = ""
reopenBtn.Visible = false
reopenBtn.Parent = reopenGui
local roCorner = Instance.new("UICorner")
roCorner.CornerRadius = UDim.new(0, 8)
roCorner.Parent = reopenBtn
local roStroke = Instance.new("UIStroke")
roStroke.Color = THEME.Accent
roStroke.Thickness = 2
roStroke.Parent = reopenBtn
local reopenAvatar = Instance.new("ImageLabel")
reopenAvatar.Size = UDim2.fromScale(1, 1)
reopenAvatar.Position = UDim2.fromScale(0, 0)
reopenAvatar.BackgroundTransparency = 1
reopenAvatar.BorderSizePixel = 0
reopenAvatar.Image = "rbxassetid://178993745"
reopenAvatar.ScaleType = Enum.ScaleType.Stretch
reopenAvatar.Parent = reopenBtn
local reopenLabel = Instance.new("TextLabel")
reopenLabel.Size = UDim2.new(1, 0, 0, 20)
reopenLabel.Position = UDim2.new(0, 0, 1, -22)
reopenLabel.BackgroundTransparency = 1
reopenLabel.Text = "OPEN PANEL"
reopenLabel.TextColor3 = THEME.AccentBright
reopenLabel.Font = Enum.Font.Code
reopenLabel.TextSize = 13
reopenLabel.Parent = reopenBtn
local reopenDragging = false
local reopenDragStart = nil
local reopenStartPos = nil
reopenBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		reopenDragging = true
		reopenDragStart = input.Position
		reopenStartPos = reopenBtn.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				reopenDragging = false
			end
		end)
	end
end)
reopenBtn.InputChanged:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and reopenDragging and reopenDragStart and reopenStartPos then
		local delta = input.Position - reopenDragStart
		reopenBtn.Position = UDim2.new(
			reopenStartPos.X.Scale, reopenStartPos.X.Offset + delta.X,
			reopenStartPos.Y.Scale, reopenStartPos.Y.Offset + delta.Y
		)
	end
end)
reopenBtn.MouseButton1Click:Connect(function()
	screenGui.Enabled = true
	reopenBtn.Visible = false
end)
closeBtn.MouseButton1Click:Connect(function()
	screenGui.Enabled = false
	reopenBtn.Visible = true
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
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
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
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
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
createLabel(playerTab, "Player Options")
createButton(playerTab, "WalkSpeed x2", function(active)
	if active then
		startFeature("WalkSpeedx2", function()
			while true do
				local char = player.Character
				if char then
					local hum = char:FindFirstChildOfClass("Humanoid")
					if hum then
						hum.WalkSpeed = 32
					end
				end
				task.wait(0.5)
			end
		end)
	else
		stopFeature("WalkSpeedx2")
		local char = player.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.WalkSpeed = 16
			end
		end
	end
end)
createButton(playerTab, "JumpPower x2", function(active)
	if active then
		startFeature("JumpPowerx2", function()
			while true do
				local char = player.Character
				if char then
					local hum = char:FindFirstChildOfClass("Humanoid")
					if hum then
						hum.UseJumpPower = true
						hum.JumpPower = 100
					end
				end
				task.wait(0.5)
			end
		end)
	else
		stopFeature("JumpPowerx2")
		local char = player.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.JumpPower = 50
			end
		end
	end
end)
createButton(playerTab, "Infinite Jump", function(active)
	if active then
		startFeature("InfJump", function(conns)
			local conn = UserInputService.JumpRequest:Connect(function()
				local char = player.Character
				if char then
					local hum = char:FindFirstChildOfClass("Humanoid")
					if hum then
						hum:ChangeState(Enum.HumanoidStateType.Jumping)
					end
				end
			end)
			table.insert(conns, conn)
			while true do
				task.wait(1)
			end
		end)
	else
		stopFeature("InfJump")
	end
end)
createButton(playerTab, "Noclip", function(active)
	if fireAllRemotes(active) then return end
	if active then
		startFeature("Noclip", function(conns)
			local conn = RunService.Stepped:Connect(function()
				local char = player.Character
				if char then
					for _, part in pairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)
			table.insert(conns, conn)
			while true do
				task.wait(1)
			end
		end)
	else
		stopFeature("Noclip")
		local char = player.Character
		if char then
			for _, part in pairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
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
createLabel(visualsTab, "Sky Changer")
createInput(visualsTab, "Sky Texture ID:", 178993745, "Apply", function(id)
	if fireAllRemotes(id) then return end
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
createLabel(visualsTab, "Image / Decal Changer")
createInput(visualsTab, "Image ID:", 178993745, "Apply", function(id)
	if fireAllRemotes(id) then return end
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
createLabel(visualsTab, "Music Player")
local currentSound = nil
createInput(visualsTab, "Sound ID:", 94635984925376, "Play", function(id)
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
local espObjects = {}
local espNameObjects = {}
local espEnabled = false
local espColor = Color3.fromRGB(255, 50, 50)
local espShowNames = false
local function addESP(character)
	if character == player.Character then return end
	local existing = character:FindFirstChild("C00lkiddESP")
	if existing then return end
	local hl = Instance.new("Highlight")
	hl.Name = "C00lkiddESP"
	hl.FillColor = espColor
	hl.OutlineColor = Color3.fromRGB(255, 255, 255)
	hl.FillTransparency = 0.5
	hl.OutlineTransparency = 0
	hl.Parent = character
	espObjects[character] = hl
end
local function removeESP(character)
	local hl = espObjects[character]
	if hl then
		hl:Destroy()
		espObjects[character] = nil
	end
	local nl = espNameObjects[character]
	if nl then
		nl:Destroy()
		espNameObjects[character] = nil
	end
end
local function clearAllESP()
	for char, hl in pairs(espObjects) do
		hl:Destroy()
	end
	espObjects = {}
	for char, nl in pairs(espNameObjects) do
		nl:Destroy()
	end
	espNameObjects = {}
end
local function addESPName(character, p)
	if character == player.Character then return end
	local existing = espNameObjects[character]
	if existing then existing:Destroy() end
	local bg = Instance.new("BillboardGui")
	bg.Name = "C00lkiddName"
	bg.Size = UDim2.new(0, 200, 0, 30)
	bg.StudsOffset = Vector3.new(0, 3, 0)
	bg.AlwaysOnTop = true
	bg.Parent = character
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 1, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = p.Name
	lbl.TextColor3 = espColor
	lbl.Font = Enum.Font.Code
	lbl.TextSize = 18
	lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	lbl.TextStrokeTransparency = 0.3
	lbl.Parent = bg
	espNameObjects[character] = bg
end
local function refreshESP()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			addESP(p.Character)
			if espShowNames then
				addESPName(p.Character, p)
			end
		end
	end
end
local espTab = createTab("ESP")
createLabel(espTab, "ESP Settings")
createButton(espTab, "Show Players (ESP)", function(active)
	espEnabled = active
	if active then
		startFeature("ESP", function(conns)
			refreshESP()
			local conn1 = Players.PlayerAdded:Connect(function(p)
				p.CharacterAdded:Connect(function(char)
					task.wait(0.5)
					if espEnabled then
						addESP(char)
						if espShowNames then addESPName(char, p) end
					end
				end)
			end)
			local conn2 = Players.PlayerRemoving:Connect(function(p)
				if p.Character then removeESP(p.Character) end
			end)
			table.insert(conns, conn1)
			table.insert(conns, conn2)
			while true do
				task.wait(1)
				refreshESP()
			end
		end)
	else
		stopFeature("ESP")
		clearAllESP()
	end
end)
createButton(espTab, "Show Names", function(active)
	espShowNames = active
	if active then
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				addESPName(p.Character, p)
			end
		end
	else
		for char, nl in pairs(espNameObjects) do
			nl:Destroy()
		end
		espNameObjects = {}
	end
end)
local colorPickerFrame = Instance.new("Frame")
colorPickerFrame.Size = UDim2.new(1, 0, 0, 80)
colorPickerFrame.BackgroundColor3 = THEME.ButtonBg
colorPickerFrame.BorderSizePixel = 0
colorPickerFrame.Visible = false
colorPickerFrame.Parent = espTab
local cpCorner = Instance.new("UICorner")
cpCorner.CornerRadius = UDim.new(0, 6)
cpCorner.Parent = colorPickerFrame
local cpList = Instance.new("UIListLayout")
cpList.FillDirection = Enum.FillDirection.Horizontal
cpList.Padding = UDim.new(0, 4)
cpList.HorizontalAlignment = Enum.HorizontalAlignment.Center
cpList.VerticalAlignment = Enum.VerticalAlignment.Center
cpList.Parent = colorPickerFrame
local espColors = {
	{ name = "Red",    color = Color3.fromRGB(255, 50, 50) },
	{ name = "Green",  color = Color3.fromRGB(50, 255, 50) },
	{ name = "Blue",   color = Color3.fromRGB(50, 100, 255) },
	{ name = "Yellow", color = Color3.fromRGB(255, 255, 50) },
	{ name = "Purple", color = Color3.fromRGB(200, 50, 255) },
	{ name = "Cyan",   color = Color3.fromRGB(50, 255, 255) },
	{ name = "Orange", color = Color3.fromRGB(255, 165, 0) },
	{ name = "White",  color = Color3.fromRGB(255, 255, 255) },
}
for _, c in ipairs(espColors) do
	local cBtn = Instance.new("TextButton")
	cBtn.Size = UDim2.new(0, 36, 0, 36)
	cBtn.BackgroundColor3 = c.color
	cBtn.BorderSizePixel = 0
	cBtn.Text = ""
	cBtn.Parent = colorPickerFrame
	local cCorner = Instance.new("UICorner")
	cCorner.CornerRadius = UDim.new(0, 6)
	cCorner.Parent = cBtn
	cBtn.MouseButton1Click:Connect(function()
		espColor = c.color
		for _, hl in pairs(espObjects) do
			hl.FillColor = espColor
		end
		for _, nl in pairs(espNameObjects) do
			local lbl = nl:FindFirstChildOfClass("TextLabel")
			if lbl then
				lbl.TextColor3 = espColor
			end
		end
	end)
end
local colorPickerBtn = Instance.new("TextButton")
colorPickerBtn.Size = UDim2.new(1, 0, 0, 34)
colorPickerBtn.BackgroundColor3 = THEME.ButtonBg
colorPickerBtn.BorderSizePixel = 0
colorPickerBtn.Text = "Change ESP Color"
colorPickerBtn.TextColor3 = THEME.Text
colorPickerBtn.Font = Enum.Font.Code
colorPickerBtn.TextSize = 14
colorPickerBtn.Parent = espTab
local cpBtnCorner = Instance.new("UICorner")
cpBtnCorner.CornerRadius = UDim.new(0, 6)
cpBtnCorner.Parent = colorPickerBtn
colorPickerBtn.MouseEnter:Connect(function()
	colorPickerBtn.BackgroundColor3 = THEME.ButtonHover
end)
colorPickerBtn.MouseLeave:Connect(function()
	colorPickerBtn.BackgroundColor3 = THEME.ButtonBg
end)
local cpVisible = false
colorPickerBtn.MouseButton1Click:Connect(function()
	cpVisible = not cpVisible
	colorPickerFrame.Visible = cpVisible
end)
local aimbotTab = createTab("AimBot")
createLabel(aimbotTab, "AimBot Settings")
local aimbotEnabled = false
local aimbotMode = "Auto"
local aimbotTarget = nil
local aimbotBodyPart = "Torso"
local aimbotRange = 100
local aimbotFov = 150
local aimbotSmoothness = 0.3
local fovGui = Instance.new("ScreenGui")
fovGui.Name = "AimbotFOV"
fovGui.ResetOnSpawn = false
fovGui.IgnoreGuiInset = true
fovGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
fovGui.Parent = playerGui
local fovCircle = Instance.new("Frame")
fovCircle.Size = UDim2.fromOffset(aimbotFov * 2, aimbotFov * 2)
fovCircle.Position = UDim2.new(0.5, -aimbotFov, 0.5, -aimbotFov)
fovCircle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
fovCircle.BackgroundTransparency = 1
fovCircle.BorderSizePixel = 0
fovCircle.Visible = false
fovCircle.Parent = fovGui
local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovCircle
local fovStroke = Instance.new("UIStroke")
fovStroke.Color = Color3.fromRGB(255, 50, 50)
fovStroke.Thickness = 2
fovStroke.Transparency = 0.3
fovStroke.Parent = fovCircle
local playerFilterEnabled = false
local selectedPlayers = {}
local function isPlayerSelected(p)
	if not playerFilterEnabled then return true end
	return selectedPlayers[p] == true
end
createLabel(aimbotTab, "Aim Mode")
local modeButtons = {}
local function createModeButton(text, mode)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = (mode == aimbotMode) and THEME.ButtonActive or THEME.ButtonBg
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = (mode == aimbotMode) and THEME.AccentBright or THEME.Text
	btn.Font = Enum.Font.Code
	btn.TextSize = 14
	btn.Parent = aimbotTab
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn
	modeButtons[mode] = btn
	btn.MouseButton1Click:Connect(function()
		aimbotMode = mode
		for _, b in pairs(modeButtons) do
			b.BackgroundColor3 = THEME.ButtonBg
			b.TextColor3 = THEME.Text
		end
		btn.BackgroundColor3 = THEME.ButtonActive
		btn.TextColor3 = THEME.AccentBright
	end)
	btn.MouseEnter:Connect(function()
		if aimbotMode ~= mode then
			btn.BackgroundColor3 = THEME.ButtonHover
		end
	end)
	btn.MouseLeave:Connect(function()
		if aimbotMode ~= mode then
			btn.BackgroundColor3 = THEME.ButtonBg
		end
	end)
end
createModeButton("Auto (Locks nearest player)", "Auto")
createModeButton("Assist (Helps when aiming near)", "Assist")
createLabel(aimbotTab, "Target Body Part")
local partButtons = {}
local function getTargetPart(character)
	if not character then return nil end
	if aimbotBodyPart == "Head" then
		return character:FindFirstChild("Head")
	elseif aimbotBodyPart == "Torso" then
		return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
	elseif aimbotBodyPart == "Legs" then
		return character:FindFirstChild("Left Leg") or character:FindFirstChild("Right Leg") or character:FindFirstChild("LeftLeg") or character:FindFirstChild("RightLeg")
	end
	return character:FindFirstChild("HumanoidRootPart")
end
local function createPartButton(text, partName)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = (partName == aimbotBodyPart) and THEME.ButtonActive or THEME.ButtonBg
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = (partName == aimbotBodyPart) and THEME.AccentBright or THEME.Text
	btn.Font = Enum.Font.Code
	btn.TextSize = 14
	btn.Parent = aimbotTab
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn
	partButtons[partName] = btn
	btn.MouseButton1Click:Connect(function()
		aimbotBodyPart = partName
		for _, b in pairs(partButtons) do
			b.BackgroundColor3 = THEME.ButtonBg
			b.TextColor3 = THEME.Text
		end
		btn.BackgroundColor3 = THEME.ButtonActive
		btn.TextColor3 = THEME.AccentBright
	end)
	btn.MouseEnter:Connect(function()
		if aimbotBodyPart ~= partName then
			btn.BackgroundColor3 = THEME.ButtonHover
		end
	end)
	btn.MouseLeave:Connect(function()
		if aimbotBodyPart ~= partName then
			btn.BackgroundColor3 = THEME.ButtonBg
		end
	end)
end
createPartButton("Head", "Head")
createPartButton("Torso", "Torso")
createPartButton("Legs", "Legs")
createSliderWithInput(aimbotTab, "Aimbot Range", 10, 1000, 100, function(value)
	aimbotRange = value
end)
createSliderWithInput(aimbotTab, "FOV Radius (Assist)", 20, 500, 150, function(value)
	aimbotFov = value
	fovCircle.Size = UDim2.fromOffset(aimbotFov * 2, aimbotFov * 2)
	fovCircle.Position = UDim2.new(0.5, -aimbotFov, 0.5, -aimbotFov)
end)
createSliderWithInput(aimbotTab, "Smoothness", 0, 100, 30, function(value)
	aimbotSmoothness = value / 100
end)
createLabel(aimbotTab, "AimBot Controls")
createButton(aimbotTab, "Enable AimBot", function(active)
	aimbotEnabled = active
	fovCircle.Visible = active
	if active then
		startFeature("AimBot", function(conns)
			local camera = workspace.CurrentCamera
			local renderConn
			renderConn = RunService.RenderStepped:Connect(function()
				if not aimbotEnabled then return end
				local myChar = player.Character
				if not myChar then return end
				local myHrp = myChar:FindFirstChild("HumanoidRootPart")
				if not myHrp then return end
				local mousePos = UserInputService:GetMouseLocation()
				local closestPlayer = nil
				local closestScore = math.huge
				for _, p in pairs(Players:GetPlayers()) do
					if p ~= player and p.Character and isPlayerSelected(p) then
						local hum = p.Character:FindFirstChildOfClass("Humanoid")
						if hum and hum.Health > 0 then
							local targetPart = getTargetPart(p.Character)
							if targetPart then
								local dist3D = (targetPart.Position - myHrp.Position).Magnitude
								if dist3D <= aimbotRange then
									if aimbotMode == "Auto" then
										if dist3D < closestScore then
											closestScore = dist3D
											closestPlayer = p
										end
									else
										local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
										if onScreen then
											local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
											if screenDist <= aimbotFov and screenDist < closestScore then
												closestScore = screenDist
												closestPlayer = p
											end
										end
									end
								end
							end
						end
					end
				end
				if closestPlayer and closestPlayer.Character then
					local targetPart = getTargetPart(closestPlayer.Character)
					if targetPart then
						local targetPos = targetPart.Position
						local camPos = camera.CFrame.Position
						local targetLook = CFrame.new(camPos, targetPos)
						if aimbotSmoothness <= 0 then
							camera.CFrame = targetLook
						else
							camera.CFrame = camera.CFrame:Lerp(targetLook, 1 - aimbotSmoothness)
						end
						aimbotTarget = closestPlayer
					end
				else
					aimbotTarget = nil
				end
			end)
			table.insert(conns, renderConn)
		end)
	else
		stopFeature("AimBot")
		aimbotTarget = nil
	end
end)
createButton(aimbotTab, "Show Target ESP", function(active)
	if active then
		startFeature("AimbotESP", function(conns)
			local currentHL = nil
			local conn
			conn = RunService.RenderStepped:Connect(function()
				if currentHL and (not aimbotTarget or not aimbotTarget.Character or currentHL.Parent ~= aimbotTarget.Character) then
					currentHL:Destroy()
					currentHL = nil
				end
				if aimbotTarget and aimbotTarget.Character then
					if not currentHL then
						currentHL = Instance.new("Highlight")
						currentHL.Name = "AimbotTargetHL"
						currentHL.FillColor = Color3.fromRGB(0, 255, 0)
						currentHL.OutlineColor = Color3.fromRGB(0, 0, 0)
						currentHL.FillTransparency = 0.3
						currentHL.Parent = aimbotTarget.Character
					end
				end
			end)
			table.insert(conns, conn)
		end)
	else
		stopFeature("AimbotESP")
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("Highlight") and v.Name == "AimbotTargetHL" then
				v:Destroy()
			end
		end
	end
end)
local playersListTab = createTab("Players")
local playerToggleBtn = createButton(playersListTab, "Enable Player Filter", function(active)
	playerFilterEnabled = active
end)
createLabel(playersListTab, "Player List (check to target only selected)")
local playersListContainer = Instance.new("Frame")
playersListContainer.Size = UDim2.new(1, 0, 0, 0)
playersListContainer.BackgroundTransparency = 1
playersListContainer.AutomaticSize = Enum.AutomaticSize.Y
playersListContainer.Parent = playersListTab
local playersListLayout = Instance.new("UIListLayout")
playersListLayout.Padding = UDim.new(0, 4)
playersListLayout.Parent = playersListContainer
local playerListEntries = {} -- [player] = {frame=Frame, checkbox=TextButton}
local function createPlayerListEntry(p)
	if playerListEntries[p] then return end
	local entry = Instance.new("Frame")
	entry.Size = UDim2.new(1, 0, 0, 30)
	entry.BackgroundColor3 = THEME.ButtonBg
	entry.BorderSizePixel = 0
	entry.Parent = playersListContainer
	local entryCorner = Instance.new("UICorner")
	entryCorner.CornerRadius = UDim.new(0, 4)
	entryCorner.Parent = entry
	local checkbox = Instance.new("TextButton")
	checkbox.Size = UDim2.new(0, 24, 0, 24)
	checkbox.Position = UDim2.new(0, 4, 0.5, -12)
	checkbox.BackgroundColor3 = THEME.ButtonBg
	checkbox.BorderSizePixel = 0
	checkbox.Text = ""
	checkbox.Font = Enum.Font.Code
	checkbox.TextSize = 16
	checkbox.TextColor3 = THEME.AccentBright
	checkbox.Parent = entry
	local cbCorner = Instance.new("UICorner")
	cbCorner.CornerRadius = UDim.new(0, 4)
	cbCorner.Parent = checkbox
	local cbStroke = Instance.new("UIStroke")
	cbStroke.Color = THEME.Accent
	cbStroke.Thickness = 1
	cbStroke.Parent = checkbox
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, -36, 1, 0)
	nameLabel.Position = UDim2.new(0, 34, 0, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = p.Name
	nameLabel.TextColor3 = THEME.Text
	nameLabel.Font = Enum.Font.Code
	nameLabel.TextSize = 13
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = entry
	local checked = false
	local function updateVisual()
		if checked then
			checkbox.Text = "X"
			checkbox.BackgroundColor3 = THEME.ButtonActive
			selectedPlayers[p] = true
			entry.BackgroundColor3 = THEME.ButtonHover
		else
			checkbox.Text = ""
			checkbox.BackgroundColor3 = THEME.ButtonBg
			selectedPlayers[p] = nil
			entry.BackgroundColor3 = THEME.ButtonBg
		end
	end
	checkbox.MouseButton1Click:Connect(function()
		checked = not checked
		updateVisual()
	end)
	playerListEntries[p] = {frame = entry, checkbox = checkbox, nameLabel = nameLabel, updateVisual = updateVisual}
end
local function removePlayerListEntry(p)
	if playerListEntries[p] then
		playerListEntries[p].frame:Destroy()
		playerListEntries[p] = nil
		selectedPlayers[p] = nil
	end
end
for _, p in pairs(Players:GetPlayers()) do
	if p ~= player then
		createPlayerListEntry(p)
	end
end
Players.PlayerAdded:Connect(function(p)
	createPlayerListEntry(p)
end)
Players.PlayerRemoving:Connect(function(p)
	removePlayerListEntry(p)
end)
local serverTab = createTab("Server")
createLabel(serverTab, "Server Info")
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
createLabel(serverTab, "Server Actions")
createButton(serverTab, "FPS Boost", function(active)
	if active then
		startFeature("FPSBoost", function()
			local lighting = game:GetService("Lighting")
			lighting.GlobalShadows = false
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Material = Enum.Material.Plastic
					v.Reflectance = 0
				end
			end
			while true do
				task.wait(1)
			end
		end)
	else
		stopFeature("FPSBoost")
		game:GetService("Lighting").GlobalShadows = true
	end
end)
createButton(playersListTab, "Explode All Players", function(active)
	if not fireAllRemotes("explode") then
		if not fireAllRemotes("all") then
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
		end
	end
end)
createButton(playersListTab, "Fling All", function(active)
	if active then
		startFeature("FlingAll", function(conns)
			local myChar = player.Character
			if not myChar then return end
			local myHrp = myChar:FindFirstChild("HumanoidRootPart")
			if not myHrp then return end
			local spin = Instance.new("BodyAngularVelocity")
			spin.Name = "FlingSpin"
			spin.AngularVelocity = Vector3.new(0, 99999, 0)
			spin.MaxTorque = Vector3.new(0, math.huge, 0)
			spin.P = 10000
			spin.Parent = myHrp
			local function getValidTargets()
				local targets = {}
				for _, p in pairs(Players:GetPlayers()) do
					if p ~= player and p.Character and isPlayerSelected(p) then
						local targetHrp = p.Character:FindFirstChild("HumanoidRootPart")
						if targetHrp then
							table.insert(targets, {player = p, hrp = targetHrp})
						end
					end
				end
				return targets
			end
			while true do
				local targets = getValidTargets()
				for _, target in pairs(targets) do
					local targetHrp = target.hrp
					local targetPlayer = target.player
					local startPos = targetHrp.Position
					local flingStart = tick()
					while tick() - flingStart < 5 do
						if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
							break
						end
						local nowPos = targetHrp.Position
						local distFromStart = (nowPos - startPos).Magnitude
						if distFromStart > 50 then
							break
						end
						local velocity = targetHrp.AssemblyLinearVelocity
						if velocity.Magnitude > 50 then
							break
						end
						myHrp.CFrame = targetHrp.CFrame + Vector3.new(math.random(-1, 1), 0, math.random(-1, 1))
						task.wait(0.03)
					end
					task.wait(0.1)
				end
				task.wait(0.1)
			end
		end)
	else
		stopFeature("FlingAll")
		local myChar = player.Character
		if myChar then
			local myHrp = myChar:FindFirstChild("HumanoidRootPart")
			if myHrp then
				local spin = myHrp:FindFirstChild("FlingSpin")
				if spin then spin:Destroy() end
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
createButton(playerTab, "Anti-AFK", function(active)
	if active then
		startFeature("AntiAFK", function()
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
		stopFeature("AntiAFK")
	end
end)
local settingsTab = createTab("Settings")
createLabel(settingsTab, "Made by kaban15083 and Lunaxxux1507 !")
createButton(settingsTab, "Hide Top Banner", function(active)
	if active then
		bannerGui.Enabled = false
	else
		bannerGui.Enabled = true
	end
end)
createButton(settingsTab, "Unload Script", function(active)
	for name, _ in pairs(featureData) do
		stopFeature(name)
	end
	clearAllESP()
	screenGui:Destroy()
	bannerGui:Destroy()
	reopenGui:Destroy()
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
