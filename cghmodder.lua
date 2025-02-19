repeat wait() until game:IsLoaded()
local player = game.Players.LocalPlayer
local character = player.Character
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local tweenService = game:GetService("TweenService")

-- Hàm teleport an toàn
local function teleportTo(position)
    local tweenInfo = TweenInfo.new((humanoidRootPart.Position - position).Magnitude / 300, Enum.EasingStyle.Linear)
    local tween = tweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(position)})
    tween:Play()
    tween.Completed:Wait()
end

-- Tìm NPC farm xương
local function findBoneNPC()
    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
    return nil
end

-- Bật Haki
local function enableHaki()
    local hakiKey = "Z"
    game:GetService("VirtualInputManager"):SendKeyEvent(true, hakiKey, false, game)
    wait(0.1)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, hakiKey, false, game)
end

-- Tự động đánh quái
local autoFarm = false
spawn(function()
    while wait() do
        if autoFarm then
            local npc = findBoneNPC()
            if npc then
                local npcPos = npc.HumanoidRootPart.Position
                teleportTo(npcPos + Vector3.new(0, 10, 0)) -- Đứng trên đầu tránh bị đánh
                enableHaki()
                wait(0.5)
                humanoidRootPart.CFrame = CFrame.new(npcPos) -- Dịch chuyển gần NPC
                wait(0.2)
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
            else
                teleportTo(Vector3.new(-9500, 300, 6000)) -- Tọa độ đảo có NPC farm xương
                wait(3)
            end
        end
    end
end)

-- Tạo menu UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.8, 0, 0.2, 0)
button.Text = "Bật Auto Farm Xương"
button.Parent = ScreenGui
button.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    if autoFarm then
        button.Text = "Tắt Auto Farm Xương"
    else
        button.Text = "Bật Auto Farm Xương"
    end
end)