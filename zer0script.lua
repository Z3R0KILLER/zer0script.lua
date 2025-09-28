local Z3R0 = {}

-- Конфигурация
local theme = {
    background = Color3.new(0, 0, 0),  -- Чёрный
    text = Color3.new(1, 1, 1),        -- Белый
    button = Color3.new(0.2, 0.2, 0.2) -- Тёмно-серый
}

-- Состояния
local flightPlayers = {}
local godModePlayers = {}
local nukeEnabled = false

-- Создание GUI для телефона
function Z3R0.CreateMenu()
    -- Основной экран
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Z3R0Menu"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Основной фрейм (больше для телефона)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 350, 0, 500)
    mainFrame.Position = UDim2.new(0, 10, 0, 10)
    mainFrame.BackgroundColor3 = theme.background
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = theme.text
    mainFrame.Parent = screenGui
    
    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = theme.button
    title.TextColor3 = theme.text
    title.Text = "Z3R0 HACK MENU"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Parent = mainFrame
    
    -- Кнопка чёрных текстур (ServerScript)
    local nukeButton = Instance.new("TextButton")
    nukeButton.Name = "NukeButton"
    nukeButton.Size = UDim2.new(0.9, 0, 0, 60)
    nukeButton.Position = UDim2.new(0.05, 0, 0, 60)
    nukeButton.BackgroundColor3 = theme.button
    nukeButton.TextColor3 = theme.text
    nukeButton.Text = "ЧЁРНЫЕ ТЕКСТУРЫ [OFF]"
    nukeButton.Font = Enum.Font.Gotham
    nukeButton.TextSize = 16
    nukeButton.Parent = mainFrame
    
    -- Кнопка полёта (ServerScript)
    local flightButton = Instance.new("TextButton")
    flightButton.Name = "FlightButton"
    flightButton.Size = UDim2.new(0.9, 0, 0, 60)
    flightButton.Position = UDim2.new(0.05, 0, 0, 130)
    flightButton.BackgroundColor3 = theme.button
    flightButton.TextColor3 = theme.text
    flightButton.Text = "ПОЛЁТ [OFF]"
    flightButton.Font = Enum.Font.Gotham
    flightButton.TextSize = 16
    flightButton.Parent = mainFrame
    
    -- Кнопка бессмертия (ServerScript)
    local godButton = Instance.new("TextButton")
    godButton.Name = "GodButton"
    godButton.Size = UDim2.new(0.9, 0, 0, 60)
    godButton.Position = UDim2.new(0.05, 0, 0, 200)
    godButton.BackgroundColor3 = theme.button
    godButton.TextColor3 = theme.text
    godButton.Text = "БЕССМЕРТИЕ [OFF]"
    godButton.Font = Enum.Font.Gotham
    godButton.TextSize = 16
    godButton.Parent = mainFrame
    
    -- Кнопка для всех игроков (ServerScript)
    local allButton = Instance.new("TextButton")
    allButton.Name = "AllButton"
    allButton.Size = UDim2.new(0.9, 0, 0, 60)
    allButton.Position = UDim2.new(0.05, 0, 0, 270)
    allButton.BackgroundColor3 = theme.button
    allButton.TextColor3 = theme.text
    allButton.Text = "ВСЕМ ПОЛЁТ [OFF]"
    allButton.Font = Enum.Font.Gotham
    allButton.TextSize = 16
    allButton.Parent = mainFrame
    
    -- Кнопка закрытия
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.9, 0, 0, 40)
    closeButton.Position = UDim2.new(0.05, 0, 0, 450)
    closeButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
    closeButton.TextColor3 = theme.text
    closeButton.Text = "ЗАКРЫТЬ"
    closeButton.Font = Enum.Font.Gotham
    closeButton.TextSize = 16
    closeButton.Parent = mainFrame
    
    -- Обработчики кнопок для телефона
    nukeButton.MouseButton1Click:Connect(function()
        Z3R0.ToggleNukeTextures(nukeButton)
    end)
    
    flightButton.MouseButton1Click:Connect(function()
        Z3R0.ToggleFlight(flightButton)
    end)
    
    godButton.MouseButton1Click:Connect(function()
        Z3R0.ToggleGodMode(godButton)
    end)
    
    allButton.MouseButton1Click:Connect(function()
        Z3R0.ToggleAllFlight(allButton)
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Touch события для телефона
    local function makeButtonTouchable(button)
        button.TouchTap:Connect(function()
            button.MouseButton1Click:Fire()
        end)
    end
    
    makeButtonTouchable(nukeButton)
    makeButtonTouchable(flightButton)
    makeButtonTouchable(godButton)
    makeButtonTouchable(allButton)
    makeButtonTouchable(closeButton)
end

-- ServerScript функции (будут выполняться на сервере)

-- Чёрные текстуры для всех (ServerScript)
function Z3R0.NukeTextures()
    -- Меняем все текстуры в workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("Decal") then
                obj.Texture = "rbxasset://textures/black.png"
            elseif obj:IsA("Texture") then
                obj.Texture = "rbxasset://textures/black.png"
            elseif obj:IsA("Part") then
                obj.BrickColor = BrickColor.new("Really black")
                obj.Material = Enum.Material.Slate
                if obj:FindFirstChildOfClass("SpecialMesh") then
                    obj:FindFirstChildOfClass("SpecialMesh").TextureId = "rbxasset://textures/black.png"
                end
            elseif obj:IsA("SpecialMesh") then
                obj.TextureId = "rbxasset://textures/black.png"
            end
        end)
    end

    -- Меняем освещение
    local lighting = game:GetService("Lighting")
    lighting.Ambient = Color3.new(0, 0, 0)
    lighting.Brightness = 0
    lighting.OutdoorAmbient = Color3.new(0, 0, 0)
    lighting.FogColor = Color3.new(0, 0, 0)
    lighting.FogEnd = 100000

    -- Меняем небо
    lighting.Sky.SkyboxBk = "rbxasset://textures/black.png"
    lighting.Sky.SkyboxDn = "rbxasset://textures/black.png"
    lighting.Sky.SkyboxFt = "rbxasset://textures/black.png"
    lighting.Sky.SkyboxLf = "rbxasset://textures/black.png"
    lighting.Sky.SkyboxRt = "rbxasset://textures/black.png"
    lighting.Sky.SkyboxUp = "rbxasset://textures/black.png"
end

-- Полёт для игрока (ServerScript)
function Z3R0.EnableFlight(player)
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    -- Убираем старые части
    local oldBV = rootPart:FindFirstChild("FlightBV")
    local oldBG = rootPart:FindFirstChild("FlightBG")
    if oldBV then oldBV:Destroy() end
    if oldBG then oldBG:Destroy() end
    
    -- BodyVelocity для движения
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Name = "FlightBV"
    bodyVelocity.Parent = rootPart
    bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    
    -- BodyGyro для стабилизации
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.Name = "FlightBG"
    bodyGyro.Parent = rootPart
    bodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
    bodyGyro.P = 1000
    bodyGyro.D = 50
    
    flightPlayers[player] = {bv = bodyVelocity, bg = bodyGyro}
end

function Z3R0.DisableFlight(player)
    if flightPlayers[player] then
        local character = player.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local bv = rootPart:FindFirstChild("FlightBV")
                local bg = rootPart:FindFirstChild("FlightBG")
                if bv then bv:Destroy() end
                if bg then bg:Destroy() end
            end
        end
        flightPlayers[player] = nil
    end
end

-- Бессмертие (ServerScript)
function Z3R0.EnableGodMode(player)
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        -- Сохраняем оригинальное здоровье
        if not godModePlayers[player] then
            godModePlayers[player] = {
                maxHealth = humanoid.MaxHealth,
                health = humanoid.Health
            }
        end
        
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        
        -- Защита от смерти
        humanoid.BreakJointsOnDeath = false
    end
end

function Z3R0.DisableGodMode(player)
    if godModePlayers[player] then
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.MaxHealth = godModePlayers[player].maxHealth
                humanoid.Health = godModePlayers[player].health
            end
        end
        godModePlayers[player] = nil
    end
end

-- Полёт для всех игроков (ServerScript)
function Z3R0.EnableAllFlight()
    for _, player in pairs(game.Players:GetPlayers()) do
        Z3R0.EnableFlight(player)
    end
end

function Z3R0.DisableAllFlight()
    for _, player in pairs(game.Players:GetPlayers()) do
        Z3R0.DisableFlight(player)
    end
end

-- Обработчики кнопок
function Z3R0.ToggleNukeTextures(button)
    nukeEnabled = not nukeEnabled
    
    if nukeEnabled then
        button.Text = "ЧЁРНЫЕ ТЕКСТУРЫ [ON]"
        button.BackgroundColor3 = Color3.new(0, 0.5, 0)
        Z3R0.NukeTextures()
    else
        button.Text = "ЧЁРНЫЕ ТЕКСТУРЫ [OFF]"
        button.BackgroundColor3 = theme.button
    end
end

function Z3R0.ToggleFlight(button)
    local player = game.Players.LocalPlayer
    
    if flightPlayers[player] then
        Z3R0.DisableFlight(player)
        button.Text = "ПОЛЁТ [OFF]"
        button.BackgroundColor3 = theme.button
    else
        Z3R0.EnableFlight(player)
        button.Text = "ПОЛЁТ [ON]"
        button.BackgroundColor3 = Color3.new(0, 0.5, 0)
    end
end

function Z3R0.ToggleGodMode(button)
    local player = game.Players.LocalPlayer
    
    if godModePlayers[player] then
        Z3R0.DisableGodMode(player)
        button.Text = "БЕССМЕРТИЕ [OFF]"
        button.BackgroundColor3 = theme.button
    else
        Z3R0.EnableGodMode(player)
        button.Text = "БЕССМЕРТИЕ [ON]"
        button.BackgroundColor3 = Color3.new(0, 0.5, 0)
    end
end

function Z3R0.ToggleAllFlight(button)
    if flightPlayers[game.Players.LocalPlayer] then
        Z3R0.DisableAllFlight()
        button.Text = "ВСЕМ ПОЛЁТ [OFF]"
        button.BackgroundColor3 = theme.button
    else
        Z3R0.EnableAllFlight()
        button.Text = "ВСЕМ ПОЛЁТ [ON]"
        button.BackgroundColor3 = Color3.new(0, 0.5, 0)
    end
end

-- Обработка новых игроков
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if flightPlayers[player] then
            wait(1)
            Z3R0.EnableFlight(player)
        end
    end)
end)

-- Автозапуск меню
Z3R0.CreateMenu()

return Z3R0
