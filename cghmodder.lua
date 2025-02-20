local teleportSpeed = 300 -- Tốc độ mặc định
local selectedIsland = nil
local seaIslands = {
    [1] = { "Starter Island", "Jungle", "Pirate Village", "Desert", "Middle Town", "Frozen Village", "Marine Fortress", "Skylands", "Prison", "Colosseum", "Magma Village", "Underwater City", "Fountain City" },
    [2] = { "Kingdom of Rose", "Cafe", "Usoap's Island", "Green Zone", "Graveyard", "Dark Arena", "Snow Mountain", "Hot and Cold", "Cursed Ship", "Ice Castle", "Forgotten Island" },
    [3] = { "Port Town", "Hydra Island", "Great Tree", "Floating Turtle", "Castle on the Sea", "Haunted Castle", "Sea of Treats" }
}

-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Dropdown = Instance.new("TextButton")
local TeleportButton = Instance.new("TextButton")
local SpeedSlider = Instance.new("TextBox")
local OpenButton = Instance.new("ImageButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
UICorner.Parent = MainFrame
Title.Parent = MainFrame
Dropdown.Parent = MainFrame
TeleportButton.Parent = MainFrame
SpeedSlider.Parent = MainFrame
OpenButton.Parent = ScreenGui

-- Cài đặt GUI
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false

Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Teleport Menu"
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

Dropdown.Size = UDim2.new(1, -20, 0, 30)
Dropdown.Position = UDim2.new(0, 10, 0, 40)
Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Dropdown.Text = "Chọn đảo"
Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)

TeleportButton.Size = UDim2.new(1, -20, 0, 30)
TeleportButton.Position = UDim2.new(0, 10, 0, 80)
TeleportButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TeleportButton.Text = "Teleport"
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)

SpeedSlider.Size = UDim2.new(1, -20, 0, 30)
SpeedSlider.Position = UDim2.new(0, 10, 0, 120)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedSlider.Text = tostring(teleportSpeed)
SpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)

OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 10, 0.5, -25)
OpenButton.Image = "rbxassetid://YOUR_IMAGE_ID"

-- Chọn đảo
Dropdown.MouseButton1Click:Connect(function()
    local currentSea = game:GetService("Players").LocalPlayer.Data.Level.Value < 700 and 1 or (game:GetService("Players").LocalPlayer.Data.Level.Value < 1500 and 2 or 3)
    local list = ""
    for _, island in ipairs(seaIslands[currentSea]) do
        list = list .. island .. "\n"
    end
    selectedIsland = seaIslands[currentSea][math.random(#seaIslands[currentSea])]
    Dropdown.Text = selectedIsland
end)

-- Chỉnh tốc độ
SpeedSlider.FocusLost:Connect(function()
    local speed = tonumber(SpeedSlider.Text)
    if speed and speed > 0 then
        teleportSpeed = speed
    else
        SpeedSlider.Text = tostring(teleportSpeed)
    end
end)

-- Teleport
TeleportButton.MouseButton1Click:Connect(function()
    if selectedIsland then
        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        local function teleportToIsland(island)
            hrp.CFrame = CFrame.new(Vector3.new(math.random(-5000, 5000), 100, math.random(-5000, 5000)))
            wait(1)
            hrp.CFrame = CFrame.new(Vector3.new(math.random(-5000, 5000), 100, math.random(-5000, 5000)))
        end
        teleportToIsland(selectedIsland)
    end
end)

-- Mở menu
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
