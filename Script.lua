local Players = game:GetService("Players")
local player = Players.LocalPlayer

if _G.BrookhavenModLoaded then
    return
end
_G.BrookhavenModLoaded = true

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrookhavenModMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 380)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Brookhaven Hub (Rohann6767)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local function createSlider(name, yPos, minVal, maxVal, defaultVal, callback)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.9, 0, 0, 20)
    Label.Position = UDim2.new(0.05, 0, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. defaultVal
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 12
    Label.Font = Enum.Font.Gotham
    Label.Parent = MainFrame

    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(0.9, 0, 0, 30)
    Box.Position = UDim2.new(0.05, 0, 0, yPos + 20)
    Box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.Text = tostring(defaultVal)
    Box.TextSize = 14
    Box.Font = Enum.Font.Gotham
    Box.Parent = MainFrame

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 6)
    BoxCorner.Parent = Box

    Box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local num = tonumber(Box.Text)
            if num then
                if num < minVal then num = minVal end
                if num > maxVal then num = maxVal end
                Box.Text = tostring(num)
                Label.Text = name .. ": " .. num
                callback(num)
            else
                Box.Text = tostring(defaultVal)
            end
        end
    end)
end

createSlider("ความเร็ว (Speed)", 50, 16, 500, 16, function(val)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = val
    end
end)

createSlider("พลังกระโดด (Jump)", 110, 50, 500, 50, function(val)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.UseJumpPower = true
        player.Character.Humanoid.JumpPower = val
    end
end)

createSlider("ความสูงตัว (Height)", 170, 0.1, 10, 1, function(val)
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        pcall(function()
            char.Humanoid:FindFirstChild("BodyHeightScale").Value = val
        end)
    end
end)

createSlider("ความกว้าง/อ้วน (Width)", 230, 0.1, 5, 1, function(val)
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        pcall(function()
            char.Humanoid:FindFirstChild("BodyWidthScale").Value = val
        end)
    end
end)

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.05, 0, 0, 310)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Text = "ปิด/ซ่อนเมนู"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleBtn

local visible = true
ToggleBtn.MouseButton1Click:Connect(function()
    visible = not visible
    for _, child in ipairs(MainFrame:GetChildren()) do
        if child ~= Title and child ~= ToggleBtn and child ~= UICorner then
            child.Visible = visible
        end
    end
    if visible then
        MainFrame.Size = UDim2.new(0, 300, 0, 380)
        ToggleBtn.Text = "ปิด/ซ่อนเมนู"
    else
        MainFrame.Size = UDim2.new(0, 300, 0, 90)
        ToggleBtn.Text = "เปิดเมนู"
    end
end)
