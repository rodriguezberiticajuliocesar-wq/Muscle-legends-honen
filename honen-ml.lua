-- MUSCLE LEGENDS HONEN EDITION
-- Compatible con Delta, Synapse X, KRNL, Fluxus

local KeySystem = "HONEN"
local UserInput = ""

-- Crear GUI Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HonenML"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Imagen de fondo (NPC/Wojak)
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://TU_IMAGE_ID_AQUI" -- Reemplaza con el ID de tu imagen subida a Roblox
BackgroundImage.ImageTransparency = 0.3
BackgroundImage.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Text = "MUSCLE LEGENDS - HONEN EDITION"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Sistema de Key
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 300, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = MainFrame

local KeyLabel = Instance.new("TextLabel")
KeyLabel.Size = UDim2.new(1, 0, 0, 30)
KeyLabel.Text = "ENTER KEY:"
KeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyLabel.BackgroundTransparency = 1
KeyLabel.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
KeyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderText = "Key here..."
KeyInput.Parent = KeyFrame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.5, 0, 0, 35)
SubmitButton.Position = UDim2.new(0.25, 0, 0.6, 0)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SubmitButton.Text = "UNLOCK"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Parent = KeyFrame

-- Variables de funciones
local AutoFarm = false
local AutoRebirth = false
local AutoBuyPets = false
local OPStrength = false
local FastRepetition = false
local NetherlandsMode = false

-- Función para verificar key
SubmitButton.MouseButton1Click:Connect(function()
    if KeyInput.Text == KeySystem then
        KeyFrame:Destroy()
        loadMainMenu()
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "WRONG KEY!"
        wait(1)
        KeyInput.PlaceholderText = "Key here..."
    end
end)

function loadMainMenu()
    -- Botón Auto Farm
    local FarmBtn = createToggleButton("Auto Farm", 60, function(state)
        AutoFarm = state
        if state then
            spawn(autoFarmFunction)
        end
    end)
    
    -- Botón Auto Rebirth
    local RebirthBtn = createToggleButton("Auto Rebirth", 110, function(state)
        AutoRebirth = state
        if state then
            spawn(autoRebirthFunction)
        end
    end)
    
    -- Botón Auto Buy Pets (Netherlands Mode)
    local PetsBtn = createToggleButton("Auto Buy Pets [NL]", 160, function(state)
        AutoBuyPets = state
        NetherlandsMode = state
        if state then
            spawn(autoBuyPetsFunction)
        end
    end)
    
    -- Botón OP Strength
    local StrengthBtn = createToggleButton("OP Strength", 210, function(state)
        OPStrength = state
        if state then
            spawn(opStrengthFunction)
        end
    end)
    
    -- Botón Fast Repetition
    local FastBtn = createToggleButton("Fast Repetition", 260, function(state)
        FastRepetition = state
    end)
    
    -- Botón Cerrar
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Parent = MainFrame
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end

function createToggleButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = text .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = MainFrame
    
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            btn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            btn.Text = text .. " [ON]"
        else
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            btn.Text = text .. " [OFF]"
        end
        callback(enabled)
    end)
    return btn
end

-- FUNCIONES PRINCIPALES

function autoFarmFunction()
    while AutoFarm do
        local args = {
            [1] = "GainMuscle",
            [2] = OPStrength and 999999 or (FastRepetition and 1000 or 100)
        }
        
        game:GetService("ReplicatedStorage").RemoteEvents.MuscleEvent:FireServer(unpack(args))
        
        -- Auto click en herramientas de peso
        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
        
        wait(FastRepetition and 0.01 or 0.1)
    end
end

function autoRebirthFunction()
    while AutoRebirth do
        local args = {[1] = "Rebirth"}
        game:GetService("ReplicatedStorage").RemoteEvents.RebirthEvent:FireServer(unpack(args))
        wait(1)
    end
end

function autoBuyPetsFunction()
    -- Netherlands Mode - Simula compra desde Netherlands
    while AutoBuyPets do
        if NetherlandsMode then
            -- Headers modificados para simular Netherlands
            local success, err = pcall(function()
                local args = {
                    [1] = "BuyPet",
                    [2] = "Legendary", -- o el tier que prefieras
                    [3] = "Netherlands" -- Parámetro de región
                }
                
                -- Intenta bypass del sistema de eggs
                game:GetService("ReplicatedStorage").RemoteEvents.PetEvent:FireServer(unpack(args))
                
                -- Alternativa: Compra directa sin abrir egg
                local petArgs = {
                    [1] = "DirectPetPurchase",
                    [2] = true
                }
                game:GetService("ReplicatedStorage").RemoteEvents.ShopEvent:FireServer(unpack(petArgs))
            end)
        end
        wait(0.5)
    end
end

function opStrengthFunction()
    while OPStrength do
        -- Modifica valores locales de fuerza
        local player = game.Players.LocalPlayer
        local stats = player:FindFirstChild("Stats")
        if stats then
            local strength = stats:FindFirstChild("Strength")
            if strength then
                strength.Value = 999999999
            end
        end
        wait(1)
    end
end

-- Hacer draggable la interfaz
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Notificación de carga
game.StarterGui:SetCore("SendNotification", {
    Title = "Honen ML Loaded",
    Text = "Script cargado. Ingresa la key: HONEN",
    Duration = 5
})

print("Muscle Legends HONEN Edition - Cargado correctamente")
