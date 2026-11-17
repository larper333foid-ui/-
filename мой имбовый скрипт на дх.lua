local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
if not player then
	warn("[lhh3n.legit] Код должен находиться внутри LocalScript!")
	return
end

local playerGui = player:WaitForChild("PlayerGui")

-- Очистка старых UI
if playerGui:FindFirstChild("lhh3n_legit_UI") then
	playerGui.lhh3n_legit_UI:Destroy()
end
if playerGui:FindFirstChild("lhh3n_tracers_gui") then
	playerGui.lhh3n_tracers_gui:Destroy()
end
if playerGui:FindFirstChild("lhh3n_silent_fov_gui") then
	playerGui.lhh3n_silent_fov_gui:Destroy()
end

local THEME = {
	BgMain = Color3.fromRGB(10, 10, 10),
	BgSecondary = Color3.fromRGB(18, 18, 18),
	BgElement = Color3.fromRGB(28, 28, 28),
	BgElementHover = Color3.fromRGB(38, 38, 38),
	StrokeDim = Color3.fromRGB(55, 55, 55),
	White = Color3.fromRGB(255, 255, 255),
	GrayText = Color3.fromRGB(165, 165, 165),
	Black = Color3.fromRGB(10, 10, 10),
}

local TWEEN_FAST = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_SMOOTH = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local TWEEN_BOUNCE = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local function addCorner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = parent
	return c
end

local function addStroke(parent, color, thickness, transparency)
	local s = Instance.new("UIStroke")
	s.Color = color or THEME.StrokeDim
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = parent
	return s
end

-- 1. Главное окно
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "lhh3n_legit_UI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local uiSound = Instance.new("Sound")
uiSound.Name = "UISoundEffect"
uiSound.SoundId = "rbxassetid://9061072972"
uiSound.Volume = 0.5
uiSound.Parent = screenGui

local function playClickSound(pitch, volume)
	uiSound.PlaybackSpeed = pitch or 1.1
	uiSound.Volume = volume or 0.4
	uiSound.TimePosition = 0
	uiSound:Play()
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 520)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -260)
mainFrame.BackgroundColor3 = THEME.BgMain
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

addCorner(mainFrame, 14)
local mainStroke = addStroke(mainFrame, THEME.White, 1.2, 0)

local rainbowColors = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 90)),
	ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 140, 0)),
	ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 130)),
	ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 190, 255)),
	ColorSequenceKeypoint.new(0.80, Color3.fromRGB(165, 40, 255)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 90)),
})

local strokeGradient = Instance.new("UIGradient")
strokeGradient.Color = rainbowColors
strokeGradient.Parent = mainStroke

local leftEdge = Instance.new("Frame")
leftEdge.Size = UDim2.new(0, 1.5, 1, 0)
leftEdge.BackgroundColor3 = THEME.White
leftEdge.BorderSizePixel = 0
leftEdge.ZIndex = 6
leftEdge.Parent = mainFrame
local leftEdgeGrad = Instance.new("UIGradient")
leftEdgeGrad.Color = rainbowColors
leftEdgeGrad.Rotation = 90
leftEdgeGrad.Parent = leftEdge

local rightEdge = Instance.new("Frame")
rightEdge.Size = UDim2.new(0, 1.5, 1, 0)
rightEdge.Position = UDim2.new(1, -1.5, 0, 0)
rightEdge.BackgroundColor3 = THEME.White
rightEdge.BorderSizePixel = 0
rightEdge.ZIndex = 6
rightEdge.Parent = mainFrame
local rightEdgeGrad = Instance.new("UIGradient")
rightEdgeGrad.Color = rainbowColors
rightEdgeGrad.Rotation = -90
rightEdgeGrad.Parent = rightEdge

-- 2. Верхняя панель (Header)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.BackgroundColor3 = THEME.BgSecondary
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, 0, 0, 1)
headerLine.Position = UDim2.new(0, 0, 1, -1)
headerLine.BackgroundColor3 = THEME.StrokeDim
headerLine.BorderSizePixel = 0
headerLine.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 1, 0)
titleLabel.Position = UDim2.new(0, 18, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "lhh3n.legit"
titleLabel.TextColor3 = THEME.White
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 17
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local badge = Instance.new("TextLabel")
badge.Size = UDim2.new(0, 72, 0, 22)
badge.Position = UDim2.new(0, 118, 0.5, -11)
badge.BackgroundColor3 = THEME.White
badge.Text = "OWNER"
badge.TextColor3 = THEME.Black
badge.Font = Enum.Font.GothamBold
badge.TextSize = 10
badge.Parent = topBar
addCorner(badge, 5)

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -42, 0.5, -15)
minimizeBtn.BackgroundColor3 = THEME.BgElement
minimizeBtn.Text = "—"
minimizeBtn.TextColor3 = THEME.White
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 13
minimizeBtn.Parent = topBar
addCorner(minimizeBtn, 6)
addStroke(minimizeBtn, THEME.StrokeDim, 1)

-- 3. Сайдбар со вкладками
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 160, 1, -62)
sidebar.Position = UDim2.new(0, 12, 0, 56)
sidebar.BackgroundColor3 = THEME.BgSecondary
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame
addCorner(sidebar, 10)
addStroke(sidebar, THEME.StrokeDim, 1, 0.3)

local activeIndicator = Instance.new("Frame")
activeIndicator.Size = UDim2.new(0, 3, 0, 20)
activeIndicator.Position = UDim2.new(0, 4, 0, 20)
activeIndicator.BackgroundColor3 = THEME.White
activeIndicator.BorderSizePixel = 0
activeIndicator.Parent = sidebar
addCorner(activeIndicator, 2)

local combatTabBtn = Instance.new("TextButton")
combatTabBtn.Size = UDim2.new(0.9, 0, 0, 36)
combatTabBtn.Position = UDim2.new(0.05, 0, 0, 12)
combatTabBtn.BackgroundColor3 = THEME.BgElement
combatTabBtn.Text = ""
combatTabBtn.AutoButtonColor = false
combatTabBtn.Parent = sidebar
addCorner(combatTabBtn, 7)

local combatTabLabel = Instance.new("TextLabel")
combatTabLabel.Size = UDim2.new(1, -16, 1, 0)
combatTabLabel.Position = UDim2.new(0, 14, 0, 0)
combatTabLabel.BackgroundTransparency = 1
combatTabLabel.Text = "⚔  Combat"
combatTabLabel.TextColor3 = THEME.White
combatTabLabel.Font = Enum.Font.GothamSemibold
combatTabLabel.TextSize = 13.5
combatTabLabel.TextXAlignment = Enum.TextXAlignment.Left
combatTabLabel.Parent = combatTabBtn

local espTabBtn = Instance.new("TextButton")
espTabBtn.Size = UDim2.new(0.9, 0, 0, 36)
espTabBtn.Position = UDim2.new(0.05, 0, 0, 56)
espTabBtn.BackgroundColor3 = THEME.BgSecondary
espTabBtn.Text = ""
espTabBtn.AutoButtonColor = false
espTabBtn.Parent = sidebar
addCorner(espTabBtn, 7)

local espTabLabel = Instance.new("TextLabel")
espTabLabel.Size = UDim2.new(1, -16, 1, 0)
espTabLabel.Position = UDim2.new(0, 14, 0, 0)
espTabLabel.BackgroundTransparency = 1
espTabLabel.Text = "👁  ESP"
espTabLabel.TextColor3 = THEME.GrayText
espTabLabel.Font = Enum.Font.GothamSemibold
espTabLabel.TextSize = 13.5
espTabLabel.TextXAlignment = Enum.TextXAlignment.Left
espTabLabel.Parent = espTabBtn

local combatContainer = Instance.new("ScrollingFrame")
local espContainer = Instance.new("ScrollingFrame")

local function switchTab(isCombat)
	playClickSound(1.1, 0.4)

	TweenService:Create(activeIndicator, TWEEN_BOUNCE, {
		Position = UDim2.new(0, 4, 0, isCombat and 20 or 64)
	}):Play()

	TweenService:Create(combatTabBtn, TWEEN_FAST, { BackgroundColor3 = isCombat and THEME.BgElement or THEME.BgSecondary }):Play()
	TweenService:Create(espTabBtn, TWEEN_FAST, { BackgroundColor3 = isCombat and THEME.BgSecondary or THEME.BgElement }):Play()
	
	TweenService:Create(combatTabLabel, TWEEN_FAST, { TextColor3 = isCombat and THEME.White or THEME.GrayText }):Play()
	TweenService:Create(espTabLabel, TWEEN_FAST, { TextColor3 = isCombat and THEME.GrayText or THEME.White }):Play()

	local incoming = isCombat and combatContainer or espContainer
	local outgoing = isCombat and espContainer or combatContainer

	outgoing.Visible = false
	incoming.Visible = true
	incoming.Size = UDim2.new(1, -190, 1, -70)
	incoming.Position = UDim2.new(0, 180, 0, 62)
	
	TweenService:Create(incoming, TWEEN_SMOOTH, {
		Size = UDim2.new(1, -190, 1, -62),
		Position = UDim2.new(0, 180, 0, 56)
	}):Play()
end

combatTabBtn.MouseButton1Click:Connect(function() switchTab(true) end)
espTabBtn.MouseButton1Click:Connect(function() switchTab(false) end)

-- Настройка Combat Container
combatContainer.Name = "CombatContainer"
combatContainer.Size = UDim2.new(1, -190, 1, -62)
combatContainer.Position = UDim2.new(0, 180, 0, 56)
combatContainer.BackgroundColor3 = THEME.BgSecondary
combatContainer.BorderSizePixel = 0
combatContainer.ScrollBarThickness = 3
combatContainer.ScrollBarImageColor3 = THEME.White
combatContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
combatContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
combatContainer.Parent = mainFrame
addCorner(combatContainer, 10)
addStroke(combatContainer, THEME.StrokeDim, 1, 0.3)

local combatLayout = Instance.new("UIListLayout")
combatLayout.Padding = UDim.new(0, 12)
combatLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
combatLayout.Parent = combatContainer

local combatPadding = Instance.new("UIPadding")
combatPadding.PaddingTop = UDim.new(0, 14)
combatPadding.PaddingBottom = UDim.new(0, 14)
combatPadding.Parent = combatContainer

local sectionLbl = Instance.new("TextLabel")
sectionLbl.Size = UDim2.new(0.94, 0, 0, 20)
sectionLbl.BackgroundTransparency = 1
sectionLbl.Text = "COMBAT & AIMBOT"
sectionLbl.TextColor3 = THEME.White
sectionLbl.Font = Enum.Font.GothamBold
sectionLbl.TextSize = 11.5
sectionLbl.TextXAlignment = Enum.TextXAlignment.Left
sectionLbl.Parent = combatContainer

local rapidFireEnabled = false
local climbJumpEnabled = false
local silentAimbotEnabled = false
local silentFovRadius = 120
local silentSmoothness = 0.25
local silentSnapPower = 1.0

-- Мульти-селект целей (таблица выбранных имен игроков)
local selectedTargetPlayers = { ["Все игроки"] = true }

local function createCombatToggleCard(title, subText, callback)
	local tCard = Instance.new("TextButton")
	tCard.Size = UDim2.new(0.94, 0, 0, 56)
	tCard.BackgroundColor3 = THEME.BgElement
	tCard.Text = ""
	tCard.AutoButtonColor = false
	tCard.Parent = combatContainer
	addCorner(tCard, 8)
	local tCardStroke = addStroke(tCard, THEME.StrokeDim, 1, 0.2)

	tCard.MouseEnter:Connect(function()
		TweenService:Create(tCard, TWEEN_FAST, { BackgroundColor3 = THEME.BgElementHover }):Play()
	end)
	tCard.MouseLeave:Connect(function()
		TweenService:Create(tCard, TWEEN_FAST, { BackgroundColor3 = THEME.BgElement }):Play()
	end)

	local tTitle = Instance.new("TextLabel")
	tTitle.Size = UDim2.new(1, -75, 0, 20)
	tTitle.Position = UDim2.new(0, 14, 0, 9)
	tTitle.BackgroundTransparency = 1
	tTitle.Text = title
	tTitle.TextColor3 = THEME.White
	tTitle.Font = Enum.Font.GothamSemibold
	tTitle.TextSize = 14.5
	tTitle.TextXAlignment = Enum.TextXAlignment.Left
	tTitle.Parent = tCard

	local tSub = Instance.new("TextLabel")
	tSub.Size = UDim2.new(1, -75, 0, 15)
	tSub.Position = UDim2.new(0, 14, 0, 31)
	tSub.BackgroundTransparency = 1
	tSub.Text = subText
	tSub.TextColor3 = THEME.GrayText
	tSub.Font = Enum.Font.Gotham
	tSub.TextSize = 11.5
	tSub.TextXAlignment = Enum.TextXAlignment.Left
	tSub.Parent = tCard

	local tSwitchBg = Instance.new("Frame")
	tSwitchBg.Size = UDim2.new(0, 44, 0, 24)
	tSwitchBg.Position = UDim2.new(1, -58, 0.5, -12)
	tSwitchBg.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	tSwitchBg.BorderSizePixel = 0
	tSwitchBg.Parent = tCard
	addCorner(tSwitchBg, 12)

	local tKnob = Instance.new("Frame")
	tKnob.Size = UDim2.new(0, 18, 0, 18)
	tKnob.Position = UDim2.new(0, 3, 0.5, -9)
	tKnob.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
	tKnob.BorderSizePixel = 0
	tKnob.Parent = tSwitchBg
	addCorner(tKnob, 9)

	local state = false
	tCard.MouseButton1Click:Connect(function()
		state = not state
		callback(state)
		playClickSound(state and 1.3 or 0.9, 0.45)

		TweenService:Create(tSwitchBg, TWEEN_BOUNCE, {
			BackgroundColor3 = state and THEME.White or Color3.fromRGB(45, 45, 45)
		}):Play()
		TweenService:Create(tKnob, TWEEN_BOUNCE, {
			Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
			BackgroundColor3 = state and THEME.Black or Color3.fromRGB(160, 160, 160)
		}):Play()
		TweenService:Create(tCardStroke, TWEEN_FAST, {
			Color = state and THEME.White or THEME.StrokeDim
		}):Play()
	end)
end

createCombatToggleCard("Silent + ПКМ Доводка", "ЛКМ = урон в радиусе, ПКМ = доводка камеры", function(val) silentAimbotEnabled = val end)
createCombatToggleCard("Rapid Fire", "Быстрый зажим выстрелов при удержании ЛКМ", function(val) rapidFireEnabled = val end)
createCombatToggleCard("Climb Jump", "Мощный подброс вверх при прыжке во время карабканья", function(val) climbJumpEnabled = val end)

-- Универсальная функция создания ползунков
local function createSlider(title, minVal, maxVal, defaultVal, suffix, callback)
	local sliderCard = Instance.new("Frame")
	sliderCard.Size = UDim2.new(0.94, 0, 0, 64)
	sliderCard.BackgroundColor3 = THEME.BgElement
	sliderCard.Parent = combatContainer
	addCorner(sliderCard, 8)
	addStroke(sliderCard, THEME.StrokeDim, 1, 0.2)

	local sliderTitle = Instance.new("TextLabel")
	sliderTitle.Size = UDim2.new(1, -20, 0, 20)
	sliderTitle.Position = UDim2.new(0, 14, 0, 8)
	sliderTitle.BackgroundTransparency = 1
	sliderTitle.Text = title
	sliderTitle.TextColor3 = THEME.White
	sliderTitle.Font = Enum.Font.GothamSemibold
	sliderTitle.TextSize = 13
	sliderTitle.TextXAlignment = Enum.TextXAlignment.Left
	sliderTitle.Parent = sliderCard

	local sliderValueLbl = Instance.new("TextLabel")
	sliderValueLbl.Size = UDim2.new(0, 80, 0, 20)
	sliderValueLbl.Position = UDim2.new(1, -94, 0, 8)
	sliderValueLbl.BackgroundTransparency = 1
	sliderValueLbl.Text = tostring(defaultVal) .. " " .. suffix
	sliderValueLbl.TextColor3 = THEME.GrayText
	sliderValueLbl.Font = Enum.Font.Gotham
	sliderValueLbl.TextSize = 12
	sliderValueLbl.TextXAlignment = Enum.TextXAlignment.Right
	sliderValueLbl.Parent = sliderCard

	local sliderTrack = Instance.new("TextButton")
	sliderTrack.Size = UDim2.new(1, -28, 0, 6)
	sliderTrack.Position = UDim2.new(0, 14, 0, 42)
	sliderTrack.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	sliderTrack.Text = ""
	sliderTrack.AutoButtonColor = false
	sliderTrack.Parent = sliderCard
	addCorner(sliderTrack, 3)

	local initialPercent = math.clamp((defaultVal - minVal) / (maxVal - minVal), 0, 1)
	local sliderFill = Instance.new("Frame")
	sliderFill.Size = UDim2.new(initialPercent, 0, 1, 0)
	sliderFill.BackgroundColor3 = THEME.White
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderTrack
	addCorner(sliderFill, 3)

	local sliderKnob = Instance.new("Frame")
	sliderKnob.Size = UDim2.new(0, 12, 0, 12)
	sliderKnob.Position = UDim2.new(1, -6, 0.5, -6)
	sliderKnob.BackgroundColor3 = THEME.White
	sliderKnob.BorderSizePixel = 0
	sliderKnob.Parent = sliderFill
	addCorner(sliderKnob, 6)

	local sliderDragging = false
	sliderTrack.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = true
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local mousePos = input.Position.X
			local trackAbsPos = sliderTrack.AbsolutePosition.X
			local trackAbsSize = sliderTrack.AbsoluteSize.X
			local relX = math.clamp((mousePos - trackAbsPos) / trackAbsSize, 0, 1)
			
			local calculatedVal = minVal + relX * (maxVal - minVal)
			if maxVal - minVal > 10 then
				calculatedVal = math.floor(calculatedVal)
			else
				calculatedVal = math.floor(calculatedVal * 100 + 0.5) / 100
			end

			sliderFill.Size = UDim2.new(relX, 0, 1, 0)
			sliderValueLbl.Text = tostring(calculatedVal) .. " " .. suffix
			callback(calculatedVal)
		end
	end)
end

-- Создаем ползунки: Радиус, Плавность, Резкость
createSlider("Радиус захвата (FOV)", 30, 400, 120, "px", function(val) silentFovRadius = val end)
createSlider("Плавность доводки", 0.05, 1.0, 0.25, "", function(val) silentSmoothness = val end)
createSlider("Резкость рабочих (Snap)", 0.1, 3.0, 1.0, "x", function(val) silentSnapPower = val end)

-- Мультивыпадающий список выбора игроков
local targetCard = Instance.new("Frame")
targetCard.Size = UDim2.new(0.94, 0, 0, 64)
targetCard.BackgroundColor3 = THEME.BgElement
targetCard.Parent = combatContainer
addCorner(targetCard, 8)
addStroke(targetCard, THEME.StrokeDim, 1, 0.2)

local targetTitle = Instance.new("TextLabel")
targetTitle.Size = UDim2.new(1, -20, 0, 20)
targetTitle.Position = UDim2.new(0, 14, 0, 8)
targetTitle.BackgroundTransparency = 1
targetTitle.Text = "Target Players (Multi-Select)"
targetTitle.TextColor3 = THEME.White
targetTitle.Font = Enum.Font.GothamSemibold
targetTitle.TextSize = 13
targetTitle.TextXAlignment = Enum.TextXAlignment.Left
targetTitle.Parent = targetCard

local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(1, -28, 0, 26)
dropdownBtn.Position = UDim2.new(0, 14, 0, 30)
dropdownBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
dropdownBtn.Text = "  [Все игроки] ▾"
dropdownBtn.TextColor3 = THEME.White
dropdownBtn.Font = Enum.Font.Gotham
dropdownBtn.TextSize = 12
dropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
dropdownBtn.Parent = targetCard
addCorner(dropdownBtn, 6)
addStroke(dropdownBtn, THEME.StrokeDim, 1)

local dropdownList = Instance.new("ScrollingFrame")
dropdownList.Size = UDim2.new(1, 0, 0, 130)
dropdownList.Position = UDim2.new(0, 0, 1, 4)
dropdownList.BackgroundColor3 = THEME.BgMain
dropdownList.BorderSizePixel = 0
dropdownList.Visible = false
dropdownList.ZIndex = 15
dropdownList.ScrollBarThickness = 3
dropdownList.Parent = dropdownBtn
addCorner(dropdownList, 6)
addStroke(dropdownList, THEME.StrokeDim, 1)

local dropLayout = Instance.new("UIListLayout")
dropLayout.Parent = dropdownList

local function updateDropdownText()
	if selectedTargetPlayers["Все игроки"] then
		dropdownBtn.Text = "  [Все игроки] ▾"
	else
		local count = 0
		local lastN = ""
		for name, _ in pairs(selectedTargetPlayers) do
			count = count + 1
			lastN = name
		end
		if count == 0 then
			dropdownBtn.Text = "  Никого не выбрано ▾"
		elseif count == 1 then
			dropdownBtn.Text = "  " .. lastN .. " ▾"
		else
			dropdownBtn.Text = "  Выбрано: " .. count .. " ▾"
		end
	end
end

local function updatePlayerDropdown()
	for _, child in ipairs(dropdownList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	local allOpt = Instance.new("TextButton")
	allOpt.Size = UDim2.new(1, 0, 0, 28)
	allOpt.BackgroundColor3 = selectedTargetPlayers["Все игроки"] and Color3.fromRGB(45, 45, 45) or THEME.BgElement
	allOpt.Text = "  [ ✓ ] Все игроки"
	allOpt.TextColor3 = THEME.White
	allOpt.Font = Enum.Font.Gotham
	allOpt.TextSize = 11.5
	allOpt.TextXAlignment = Enum.TextXAlignment.Left
	allOpt.ZIndex = 16
	allOpt.Parent = dropdownList

	allOpt.MouseButton1Click:Connect(function()
		if selectedTargetPlayers["Все игроки"] then
			selectedTargetPlayers = {}
		else
			selectedTargetPlayers = { ["Все игроки"] = true }
		end
		updatePlayerDropdown()
		updateDropdownText()
		playClickSound(1.0, 0.4)
	end)

	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			local isSel = selectedTargetPlayers[p.Name] == true
			local pOpt = Instance.new("TextButton")
			pOpt.Size = UDim2.new(1, 0, 0, 28)
			pOpt.BackgroundColor3 = isSel and Color3.fromRGB(40, 40, 40) or THEME.BgMain
			pOpt.Text = (isSel and "  [ ✓ ] " or "  [   ] ") .. p.Name .. " (" .. p.DisplayName .. ")"
			pOpt.TextColor3 = THEME.White
			pOpt.Font = Enum.Font.Gotham
			pOpt.TextSize = 11.5
			pOpt.TextXAlignment = Enum.TextXAlignment.Left
			pOpt.ZIndex = 16
			pOpt.Parent = dropdownList

			pOpt.MouseButton1Click:Connect(function()
				selectedTargetPlayers["Все игроки"] = nil
				if selectedTargetPlayers[p.Name] then
					selectedTargetPlayers[p.Name] = nil
				else
					selectedTargetPlayers[p.Name] = true
				end
				updatePlayerDropdown()
				updateDropdownText()
				playClickSound(1.1, 0.4)
			end)
		end
	end
	dropdownList.CanvasSize = UDim2.new(0, 0, 0, (#dropdownList:GetChildren()) * 28)
end

dropdownBtn.MouseButton1Click:Connect(function()
	dropdownList.Visible = not dropdownList.Visible
	playClickSound(1.2, 0.35)
	if dropdownList.Visible then
		updatePlayerDropdown()
	end
end)

-- Функция проверки целевого игрока
local function isTargetValid(p)
	if selectedTargetPlayers["Все игроки"] then return true end
	return selectedTargetPlayers[p.Name] == true
end

-- Настройка ESP Container
espContainer.Name = "EspContainer"
espContainer.Size = UDim2.new(1, -190, 1, -62)
espContainer.Position = UDim2.new(0, 180, 0, 56)
espContainer.BackgroundColor3 = THEME.BgSecondary
espContainer.BorderSizePixel = 0
espContainer.ScrollBarThickness = 3
espContainer.ScrollBarImageColor3 = THEME.White
espContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
espContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
espContainer.Visible = false
espContainer.Parent = mainFrame
addCorner(espContainer, 10)
addStroke(espContainer, THEME.StrokeDim, 1, 0.3)

local espLayout = Instance.new("UIListLayout")
espLayout.Padding = UDim.new(0, 12)
espLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
espLayout.Parent = espContainer

local espPadding = Instance.new("UIPadding")
espPadding.PaddingTop = UDim.new(0, 14)
espPadding.PaddingBottom = UDim.new(0, 14)
espPadding.Parent = espContainer

local espSectionLbl = Instance.new("TextLabel")
espSectionLbl.Size = UDim2.new(0.94, 0, 0, 20)
espSectionLbl.BackgroundTransparency = 1
espSectionLbl.Text = "VISUALS"
espSectionLbl.TextColor3 = THEME.White
espSectionLbl.Font = Enum.Font.GothamBold
espSectionLbl.TextSize = 11.5
espSectionLbl.TextXAlignment = Enum.TextXAlignment.Left
espSectionLbl.Parent = espContainer

local espBoxEnabled = false
local espTracerEnabled = false
local espBarEnabled = false
local espNameEnabled = false
local damageIndicatorEnabled = false

local function createToggleCard(title, subText, callback)
	local tCard = Instance.new("TextButton")
	tCard.Size = UDim2.new(0.94, 0, 0, 56)
	tCard.BackgroundColor3 = THEME.BgElement
	tCard.Text = ""
	tCard.AutoButtonColor = false
	tCard.Parent = espContainer
	addCorner(tCard, 8)
	local tCardStroke = addStroke(tCard, THEME.StrokeDim, 1, 0.2)

	tCard.MouseEnter:Connect(function()
		TweenService:Create(tCard, TWEEN_FAST, { BackgroundColor3 = THEME.BgElementHover }):Play()
	end)
	tCard.MouseLeave:Connect(function()
		TweenService:Create(tCard, TWEEN_FAST, { BackgroundColor3 = THEME.BgElement }):Play()
	end)

	local tTitle = Instance.new("TextLabel")
	tTitle.Size = UDim2.new(1, -75, 0, 20)
	tTitle.Position = UDim2.new(0, 14, 0, 9)
	tTitle.BackgroundTransparency = 1
	tTitle.Text = title
	tTitle.TextColor3 = THEME.White
	tTitle.Font = Enum.Font.GothamSemibold
	tTitle.TextSize = 14.5
	tTitle.TextXAlignment = Enum.TextXAlignment.Left
	tTitle.Parent = tCard

	local tSub = Instance.new("TextLabel")
	tSub.Size = UDim2.new(1, -75, 0, 15)
	tSub.Position = UDim2.new(0, 14, 0, 31)
	tSub.BackgroundTransparency = 1
	tSub.Text = subText
	tSub.TextColor3 = THEME.GrayText
	tSub.Font = Enum.Font.Gotham
	tSub.TextSize = 11.5
	tSub.TextXAlignment = Enum.TextXAlignment.Left
	tSub.Parent = tCard

	local tSwitchBg = Instance.new("Frame")
	tSwitchBg.Size = UDim2.new(0, 44, 0, 24)
	tSwitchBg.Position = UDim2.new(1, -58, 0.5, -12)
	tSwitchBg.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	tSwitchBg.BorderSizePixel = 0
	tSwitchBg.Parent = tCard
	addCorner(tSwitchBg, 12)

	local tKnob = Instance.new("Frame")
	tKnob.Size = UDim2.new(0, 18, 0, 18)
	tKnob.Position = UDim2.new(0, 3, 0.5, -9)
	tKnob.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
	tKnob.BorderSizePixel = 0
	tKnob.Parent = tSwitchBg
	addCorner(tKnob, 9)

	local state = false
	tCard.MouseButton1Click:Connect(function()
		state = not state
		callback(state)
		playClickSound(state and 1.3 or 0.9, 0.45)

		TweenService:Create(tSwitchBg, TWEEN_BOUNCE, {
			BackgroundColor3 = state and THEME.White or Color3.fromRGB(45, 45, 45)
		}):Play()
		TweenService:Create(tKnob, TWEEN_BOUNCE, {
			Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
			BackgroundColor3 = state and THEME.Black or Color3.fromRGB(160, 160, 160)
		}):Play()
		TweenService:Create(tCardStroke, TWEEN_FAST, {
			Color = state and THEME.White or THEME.StrokeDim
		}):Play()
	end)
end

createToggleCard("ESP Box (Chams)", "Подсветка игроков сквозь стены", function(val) espBoxEnabled = val end)
createToggleCard("ESP Tracers", "Линии до игроков", function(val) espTracerEnabled = val end)
createToggleCard("ESP Health Bar", "Полоска здоровья над головой", function(val) espBarEnabled = val end)
createToggleCard("ESP Name", "Отображение ника и дистанции", function(val) espNameEnabled = val end)
createToggleCard("Damage Indicator", "Показ гигантского урона (-ХП)", function(val) damageIndicatorEnabled = val end)

local tracersGui = Instance.new("ScreenGui")
tracersGui.Name = "lhh3n_tracers_gui"
tracersGui.ResetOnSpawn = false
tracersGui.DisplayOrder = 999
tracersGui.Parent = playerGui

local fovGui = Instance.new("ScreenGui")
fovGui.Name = "lhh3n_silent_fov_gui"
fovGui.ResetOnSpawn = false
fovGui.DisplayOrder = 998
fovGui.Parent = playerGui

local fovCircle = Instance.new("Frame")
fovCircle.Name = "FOVCircle"
fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
fovCircle.BackgroundTransparency = 1
fovCircle.Visible = false
fovCircle.Parent = fovGui

local fovStroke = Instance.new("UIStroke")
fovStroke.Color = Color3.fromRGB(255, 255, 255)
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.3
fovStroke.Parent = fovCircle

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovCircle

local activeTracers = {}
local activeBars = {}
local activeNames = {}
local activeHighlights = {}

local function getRainbowColor(speed)
	local t = tick() * (speed or 1)
	return Color3.fromHSV((t % 5) / 5, 1, 1)
end

local function showDamagePopup()
	if not damageIndicatorEnabled then return end

	task.spawn(function()
		local character = player.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end

		local targetPos = hrp.Position + (hrp.CFrame.LookVector * 15)
		
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and isTargetValid(p) and p.Character then
				local enemyHrp = p.Character:FindFirstChild("HumanoidRootPart")
				local enemyHum = p.Character:FindFirstChild("Humanoid")
				if enemyHrp and enemyHum and enemyHum.Health > 0 then
					local dist = (hrp.Position - enemyHrp.Position).Magnitude
					if dist < 45 then
						local head = p.Character:FindFirstChild("Head") or enemyHrp
						targetPos = head.Position
						break
					end
				end
			end
		end

		local randomDamage = math.random(20, 50)
		local offsetPos = Vector3.new(math.random(-2.5, 2.5), math.random(2.5, 4), math.random(-2.5, 2.5))
		
		local popup = Instance.new("TextLabel")
		popup.Size = UDim2.new(0, 300, 0, 80)
		popup.BackgroundTransparency = 1
		popup.Text = "-" .. randomDamage .. " HP"
		popup.TextColor3 = Color3.fromRGB(255, 30, 30)
		popup.Font = Enum.Font.GothamBlack
		popup.TextSize = 48
		popup.TextStrokeTransparency = 0
		popup.ZIndex = 20
		popup.Parent = tracersGui

		local startTime = tick()
		local duration = 1.2

		local connection
		connection = RunService.RenderStepped:Connect(function()
			local elapsed = tick() - startTime
			if elapsed >= duration then
				popup:Destroy()
				connection:Disconnect()
				return
			end

			local progress = elapsed / duration
			local rise = progress * 65
			local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos + offsetPos + Vector3.new(0, rise / 12, 0))
			
			if onScreen then
				popup.Visible = true
				popup.Position = UDim2.new(0, screenPos.X - 150, 0, screenPos.Y - rise)
				
				local fade = progress > 0.6 and (progress - 0.6) / 0.4 or 0
				popup.TextTransparency = fade
				popup.TextStrokeTransparency = fade
			else
				popup.Visible = false
			end
		end)
	end)
end

local function getSilentTarget()
	local mousePos = UserInputService:GetMouseLocation()
	local closestTarget = nil
	local shortestDistance = silentFovRadius

	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and isTargetValid(p) then
			local char = p.Character
			local hum = char and char:FindFirstChild("Humanoid")
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if char and hum and hum.Health > 0 and hrp then
				local targetPart = char:FindFirstChild("Head") or hrp
				local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
				if onScreen then
					local distToMouse = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
					if distToMouse < shortestDistance then
						shortestDistance = distToMouse
						closestTarget = targetPart
					end
				end
			end
		end
	end
	return closestTarget
end

local isHoldingRMB = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		isHoldingRMB = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		isHoldingRMB = false
	end
end)

RunService.RenderStepped:Connect(function(dt)
	if silentAimbotEnabled then
		local mousePos = UserInputService:GetMouseLocation()
		fovCircle.Visible = true
		fovCircle.Size = UDim2.new(0, silentFovRadius * 2, 0, silentFovRadius * 2)
		fovCircle.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y)
		fovStroke.Color = getRainbowColor(0.8)
	else
		fovCircle.Visible = false
	end

	if silentAimbotEnabled and isHoldingRMB then
		local targetPart = getSilentTarget()
		if targetPart then
			local currentCamCFrame = Camera.CFrame
			local targetCFrame = CFrame.new(currentCamCFrame.Position, targetPart.Position)
			local finalAlpha = math.clamp(silentSmoothness * silentSnapPower, 0.01, 1.0)
			Camera.CFrame = currentCamCFrame:Lerp(targetCFrame, finalAlpha)
		end
	end

	for _, line in pairs(activeTracers) do line:Destroy() end
	for _, bar in pairs(activeBars) do bar:Destroy() end
	for _, nameLbl in pairs(activeNames) do nameLbl:Destroy() end
	activeTracers = {}
	activeBars = {}
	activeNames = {}

	local currentRgbColor = getRainbowColor(0.8)

	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local char = p.Character
			local hrp = char:FindFirstChild("HumanoidRootPart")
			local head = char:FindFirstChild("Head")
			local hum = char:FindFirstChild("Humanoid")

			local matchTarget = isTargetValid(p)

			if espBoxEnabled and matchTarget and hum and hum.Health > 0 then
				if not activeHighlights[p] then
					local hl = Instance.new("Highlight")
					hl.Name = "lhh3n_esp_hl"
					hl.Adornee = char
					hl.FillTransparency = 0.75
					hl.OutlineTransparency = 0.1
					hl.Parent = char
					activeHighlights[p] = hl
				end
				activeHighlights[p].FillColor = currentRgbColor
				activeHighlights[p].OutlineColor = currentRgbColor
			else
				if activeHighlights[p] then
					activeHighlights[p]:Destroy()
					activeHighlights[p] = nil
				end
			end

			if espTracerEnabled and matchTarget and hrp and hum and hum.Health > 0 then
				local camSpacePos = Camera.CFrame:PointToObjectSpace(hrp.Position)
				if camSpacePos.Z < 0 then
					local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
					if onScreen then
						local line = Instance.new("Frame")
						line.BackgroundColor3 = currentRgbColor
						line.BorderSizePixel = 0
						line.ZIndex = 5

						local startPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
						local endPos = Vector2.new(vector.X, vector.Y)
						local distance = (endPos - startPos).Magnitude

						line.Size = UDim2.new(0, 1.5, 0, distance)
						line.Position = UDim2.new(0, startPos.X, 0, startPos.Y)
						line.AnchorPoint = Vector2.new(0.5, 0)
						line.Rotation = math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X)) - 90
						line.Parent = tracersGui

						table.insert(activeTracers, line)
					end
				end
			end

			if espNameEnabled and matchTarget and head and hum and hum.Health > 0 then
				local camSpacePos = Camera.CFrame:PointToObjectSpace(head.Position)
				if camSpacePos.Z < 0 then
					local nameScreenPos, onScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.8, 0))
					if onScreen then
						local dist = math.floor((Camera.CFrame.Position - head.Position).Magnitude)
						local nameLabel = Instance.new("TextLabel")
						nameLabel.Size = UDim2.new(0, 200, 0, 22)
						nameLabel.Position = UDim2.new(0, nameScreenPos.X - 100, 0, nameScreenPos.Y - 11)
						nameLabel.BackgroundTransparency = 1
						nameLabel.Text = p.Name .. " [" .. dist .. "m]"
						nameLabel.TextColor3 = currentRgbColor
						nameLabel.Font = Enum.Font.GothamBold
						nameLabel.TextSize = 13.5
						nameLabel.TextStrokeTransparency = 0.3
						nameLabel.ZIndex = 8
						nameLabel.Parent = tracersGui

						table.insert(activeNames, nameLabel)
					end
				end
			end

			if espBarEnabled and matchTarget and head and hum and hum.Health > 0 then
				local camSpacePos = Camera.CFrame:PointToObjectSpace(head.Position)
				if camSpacePos.Z < 0 then
					local headScreenPos, onScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.2, 0))
					if onScreen then
						local distance = (Camera.CFrame.Position - head.Position).Magnitude
						local barWidth = math.clamp(3000 / distance, 30, 55)
						local barHeight = 4.5

						local barBg = Instance.new("Frame")
						barBg.Size = UDim2.new(0, barWidth, 0, barHeight)
						barBg.Position = UDim2.new(0, headScreenPos.X - (barWidth / 2), 0, headScreenPos.Y)
						barBg.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
						barBg.BorderSizePixel = 0
						barBg.ZIndex = 6
						barBg.Parent = tracersGui

						local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
						local barFill = Instance.new("Frame")
						barFill.Size = UDim2.new(healthPercent, 0, 1, 0)
						barFill.Position = UDim2.new(0, 0, 0, 0)
						barFill.BackgroundColor3 = currentRgbColor
						barFill.BorderSizePixel = 0
						barFill.ZIndex = 7
						barFill.Parent = barBg

						table.insert(activeBars, barBg)
					end
				end
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(p)
	if activeHighlights[p] then
		activeHighlights[p]:Destroy()
		activeHighlights[p] = nil
	end
end)

local rotation = 0
local offsetPhase = 0
RunService.RenderStepped:Connect(function(dt)
	rotation = (rotation + dt * 90) % 360
	strokeGradient.Rotation = rotation

	offsetPhase = (offsetPhase + dt * 0.6) % 1
	local wave = math.sin(offsetPhase * math.pi * 2) * 0.35
	leftEdgeGrad.Offset = Vector2.new(0, wave)
	rightEdgeGrad.Offset = Vector2.new(0, -wave)
end)

local dragging, dragInput, dragStart, startPos
topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
	end
end)
topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	minimizeBtn.Text = isMinimized and "+" or "—"
	playClickSound(0.8, 0.4)
	TweenService:Create(mainFrame, TWEEN_SMOOTH, {
		Size = isMinimized and UDim2.new(0, 600, 0, 50) or UDim2.new(0, 600, 0, 520)
	}):Play()
end)

UserInputService.InputBegan:Connect(function(input, gp)
	if not gp and input.KeyCode == Enum.KeyCode.RightShift then
		mainFrame.Visible = not mainFrame.Visible
	end
end)

local isHoldingMouse = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isHoldingMouse = true
		showDamagePopup()
		
		if silentAimbotEnabled then
			local targetPart = getSilentTarget()
			if targetPart then
				local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
				if tool then
					local args = {
						[1] = targetPart.Position,
						[2] = targetPart
					}
					pcall(function()
						tool:Activate()
						local remote = tool:FindFirstChild("RemoteEvent") or tool:FindFirstChild("Fire") or tool:FindFirstChild("Shoot")
						if remote and remote:IsA("RemoteEvent") then
							remote:FireServer(unpack(args))
						end
					end)
				end
			end
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isHoldingMouse = false
	end
end)

task.spawn(function()
	while true do
		RunService.Heartbeat:Wait()
		if rapidFireEnabled and isHoldingMouse then
			local character = player.Character
			local tool = character and character:FindFirstChildOfClass("Tool")
			if tool then
				for _ = 1, 3 do
					tool:Activate()
					tool:Deactivate()
				end
			end
		end
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not climbJumpEnabled then return end
	if input.KeyCode == Enum.KeyCode.Space then
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		
		if humanoid and hrp then
			local shouldJump = false
			if humanoid:GetState() == Enum.HumanoidStateType.Climbing then
				shouldJump = true
			end
			if not shouldJump then
				local rayParams = RaycastParams.new()
				rayParams.FilterDescendantsInstances = {character}
				rayParams.FilterType = Enum.RaycastFilterType.Blacklist
				local rayResult = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 3.5, rayParams)
				if rayResult then
					shouldJump = true
				end
			end
			if shouldJump then
				hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, climbJumpPower, hrp.AssemblyLinearVelocity.Z)
			end
		end
	end
end)