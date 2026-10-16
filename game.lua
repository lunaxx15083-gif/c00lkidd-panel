local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local featureData = {}

local function startFeature(name, func)
	if featureData[name] then return end
	local s = Instance.new("LocalScript")
	s.Name = name
	s.Parent = playerGui
	local data = {script = s, connections = {}}
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
	if data.script then
		data.script:Destroy()
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
title.Size = UDim2.new(1, -50, 1, 0)
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

local reopenGui = Instance.new("ScreenGui")
reopenGui.Name = "C00lkiddReopen"
reopenGui.ResetOnSpawn = false
reopenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
reopenGui.IgnoreGuiInset = true
reopenGui.Parent = playerGui

local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(0, 120, 0, 30)
reopenBtn.Position = UDim2.new(0, 10, 0, 40)
reopenBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
reopenBtn.BorderSizePixel = 0
reopenBtn.Text = "OPEN PANEL"
reopenBtn.TextColor3 = THEME.AccentBright
reopenBtn.Font = Enum.Font.Code
reopenBtn.TextSize = 13
reopenBtn.Visible = false
reopenBtn.Parent = reopenGui

local roCorner = Instance.new("UICorner")
roCorner.CornerRadius = UDim.new(0, 6)
roCorner.Parent = reopenBtn

local roStroke = Instance.new("UIStroke")
roStroke.Color = THEME.Accent
roStroke.Thickness = 1
roStroke.Parent = reopenBtn

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

-- ESP system
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

-- ESP tab
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

-- Color picker popup
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

-- Color picker toggle button
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

-- AimBot tab
local aimbotTab = createTab("AimBot")

createLabel(aimbotTab, "AimBot Settings")

local aimbotEnabled = false
local aimbotTarget = nil
local aimbotBodyPart = "Torso"

createLabel(aimbotTab, "Target Body Part")

local partButtons = {}

local function getTargetPart(character)
	if aimbotBodyPart == "Head" then
		return character:FindFirstChild("Head")
	elseif aimbotBodyPart == "Torso" then
		return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
	elseif aimbotBodyPart == "Legs" then
		return character:FindFirstChild("Left Leg") or character:FindFirstChild("Right Leg") or character:FindFirstChild("LeftLeg") or character:FindFirstChild("RightLeg")
	end
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
		for name, b in pairs(partButtons) do
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

createLabel(aimbotTab, "AimBot Controls")

createButton(aimbotTab, "Enable AimBot", function(active)
	aimbotEnabled = active
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
				local closestPlayer = nil
					local closestDist = math.huge
					for _, p in pairs(Players:GetPlayers()) do
						if p ~= player and p.Character then
							local hum = p.Character:FindFirstChildOfClass("Humanoid")
							if hum and hum.Health > 0 then
								local targetPart = getTargetPart(p.Character)
								if targetPart then
									local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
									if onScreen then
										local dist = (Vector2.new(screenPos.X, screenPos.Y) - UserInputService:GetMouseLocation()).Magnitude
										if dist < closestDist then
											closestDist = dist
											closestPlayer = p
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
							local newLook = (targetPos - camera.CFrame.Position).Unit
							camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + newLook)
							aimbotTarget = closestPlayer
						end
					else
						aimbotTarget = nil
					end
				end
			end
		end)
	else
		stopFeature("AimBot")
		aimbotTarget = nil
	end
end)

createButton(aimbotTab, "Show Target ESP", function(active)
	if active then
		startFeature("AimbotESP", function(conns)
			while true do
				task.wait(0.1)
				if aimbotTarget and aimbotTarget.Character then
					local existing = aimbotTarget.Character:FindFirstChild("AimbotTargetHL")
					if not existing then
						local hl = Instance.new("Highlight")
						hl.Name = "AimbotTargetHL"
						hl.FillColor = Color3.fromRGB(0, 255, 0)
						hl.OutlineColor = Color3.fromRGB(0, 0, 0)
						hl.FillTransparency = 0.3
						hl.Parent = aimbotTarget.Character
						task.delay(0.2, function()
							hl:Destroy()
						end)
					end
				end
			end
		end)
	else
		stopFeature("AimbotESP")
	end
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

createButton(serverTab, "Fling All", function(active)
	if active then
		startFeature("FlingAll", function(conns)
			local myChar = player.Character
			if not myChar then return end
			local myHrp = myChar:FindFirstChild("HumanoidRootPart")
			if not myHrp then return end

			-- Create spinning force on our character (very fast rotation)
			local spin = Instance.new("BodyAngularVelocity")
			spin.Name = "FlingSpin"
			spin.AngularVelocity = Vector3.new(0, 99999, 0)
			spin.MaxTorque = Vector3.new(0, math.huge, 0)
			spin.P = 10000
			spin.Parent = myHrp

			-- Continuously teleport into each player to fling them
			local function getValidTargets()
				local targets = {}
				for _, p in pairs(Players:GetPlayers()) do
					if p ~= player and p.Character then
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

					-- Record target's position before flinging
					local startPos = targetHrp.Position
					local flingStart = tick()

					-- Aggressively teleport into the target in a tight loop
					-- This keeps us inside the target so spin transfers to them
					while tick() - flingStart < 5 do
						-- Check if target still exists
						if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
							break
						end

						local nowPos = targetHrp.Position
						local distFromStart = (nowPos - startPos).Magnitude

						-- Check if target TP'd away (moved more than 50 studs)
						if distFromStart > 50 then
							break
						end

						-- Check if target has been flung (moving fast)
						local velocity = targetHrp.AssemblyLinearVelocity
						if velocity.Magnitude > 50 then
							break
						end

						-- Keep teleporting directly into the target every frame
						myHrp.CFrame = targetHrp.CFrame + Vector3.new(math.random(-1, 1), 0, math.random(-1, 1))
						task.wait(0.03)
					end

					-- Small delay before moving to next player
					task.wait(0.1)
				end
				task.wait(0.1)
			end
		end)
	else
		stopFeature("FlingAll")
		-- Remove spinning force
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

createButton(serverTab, "Anti-AFK", function(active)
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

createLabel(serverTab, "Top Text Display")

local topTextGui = Instance.new("ScreenGui")
topTextGui.Name = "C00lkiddTopText"
topTextGui.ResetOnSpawn = false
topTextGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
topTextGui.IgnoreGuiInset = true
topTextGui.Parent = playerGui

local topTextLabel = Instance.new("TextLabel")
topTextLabel.Size = UDim2.new(1, 0, 0, 40)
topTextLabel.Position = UDim2.new(0, 0, 0, 35)
topTextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
topTextLabel.BackgroundTransparency = 0.3
topTextLabel.Text = ""
topTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
topTextLabel.Font = Enum.Font.Code
topTextLabel.TextSize = 24
topTextLabel.TextWrapped = true
topTextLabel.Visible = false
topTextLabel.Parent = topTextGui

local textInputBox = Instance.new("TextBox")
textInputBox.Size = UDim2.new(1, 0, 0, 80)
textInputBox.BackgroundColor3 = THEME.ButtonBg
textInputBox.BorderSizePixel = 0
textInputBox.Text = ""
textInputBox.TextColor3 = THEME.Text
textInputBox.Font = Enum.Font.Code
textInputBox.TextSize = 13
textInputBox.MultiLine = true
textInputBox.PlaceholderText = "Type text to show at top..."
textInputBox.PlaceholderColor3 = THEME.TextDim
textInputBox.ClearTextOnFocus = false
textInputBox.TextWrapped = true
textInputBox.Parent = serverTab

local textCorner = Instance.new("UICorner")
textCorner.CornerRadius = UDim.new(0, 6)
textCorner.Parent = textInputBox

local showTextBtn = Instance.new("TextButton")
showTextBtn.Size = UDim2.new(1, 0, 0, 34)
showTextBtn.BackgroundColor3 = THEME.ButtonBg
showTextBtn.BorderSizePixel = 0
showTextBtn.Text = "Show Text"
showTextBtn.TextColor3 = THEME.AccentBright
showTextBtn.Font = Enum.Font.Code
showTextBtn.TextSize = 14
showTextBtn.Parent = serverTab

local showCorner = Instance.new("UICorner")
showCorner.CornerRadius = UDim.new(0, 6)
showCorner.Parent = showTextBtn

showTextBtn.MouseEnter:Connect(function()
	showTextBtn.BackgroundColor3 = THEME.ButtonHover
end)
showTextBtn.MouseLeave:Connect(function()
	showTextBtn.BackgroundColor3 = THEME.ButtonBg
end)

showTextBtn.MouseButton1Click:Connect(function()
	local txt = textInputBox.Text
	if txt and #txt > 0 then
		topTextLabel.Text = txt
		topTextLabel.Visible = true
	else
		topTextLabel.Visible = false
	end
end)

textInputBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local txt = textInputBox.Text
		if txt and #txt > 0 then
			topTextLabel.Text = txt
			topTextLabel.Visible = true
		else
			topTextLabel.Visible = false
		end
	end
end)

local hideTextBtn = Instance.new("TextButton")
hideTextBtn.Size = UDim2.new(1, 0, 0, 34)
hideTextBtn.BackgroundColor3 = THEME.ButtonBg
hideTextBtn.BorderSizePixel = 0
hideTextBtn.Text = "Hide Text"
hideTextBtn.TextColor3 = THEME.AccentBright
hideTextBtn.Font = Enum.Font.Code
hideTextBtn.TextSize = 14
hideTextBtn.Parent = serverTab

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 6)
hideCorner.Parent = hideTextBtn

hideTextBtn.MouseEnter:Connect(function()
	hideTextBtn.BackgroundColor3 = THEME.ButtonHover
end)
hideTextBtn.MouseLeave:Connect(function()
	hideTextBtn.BackgroundColor3 = THEME.ButtonBg
end)

hideTextBtn.MouseButton1Click:Connect(function()
	topTextLabel.Visible = false
end)

-- Settings tab
local settingsTab = createTab("Settings")

createLabel(settingsTab, "UI Settings")

createButton(settingsTab, "Hide Top Banner", function(active)
	if active then
		bannerGui.Enabled = false
	else
		bannerGui.Enabled = true
	end
end)

createButton(settingsTab, "Hide Top Text", function(active)
	if active then
		topTextGui.Enabled = false
	else
		topTextGui.Enabled = true
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
	topTextGui:Destroy()
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
