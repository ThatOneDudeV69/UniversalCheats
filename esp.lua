--// Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// Create Main Window
local Window = Rayfield:CreateWindow({
    Name = "ESP Toggle",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "By borux12700",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, 
       FileName = "ESP_Config"
    }
})

--// Create Main Tab
local Tab = Window:CreateTab("ESP", 4483362458) -- The second argument is an icon ID

--// Toggle Variable
getgenv().ESP_Enabled = false

--// Function to Highlight Players
local function highlightPlayer(character, player)
    if character and player ~= game.Players.LocalPlayer and getgenv().ESP_Enabled then
        -- Create Highlight effect
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Red fill
        highlight.OutlineColor = Color3.fromRGB(255, 255, 0) -- Yellow outline
        highlight.Parent = character

        -- Create BillboardGui for NameTag
        local head = character:FindFirstChild("Head")
        if head then
            local billboard = Instance.new("BillboardGui")
            billboard.Adornee = head
            billboard.Size = UDim2.new(10, 0, 2, 0)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = head

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.Font = Enum.Font.SourceSansBold
            nameLabel.TextScaled = true
            nameLabel.Parent = billboard
        end
    end
end

--// Function to Apply ESP to Players
local function applyESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            highlightPlayer(player.Character, player)
        end
    end
end

--// Event to Highlight New Players
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if getgenv().ESP_Enabled then
            highlightPlayer(character, player)
        end
    end)
end)

--// Toggle ESP Button
local Toggle = Tab:CreateToggle({
   Name = "Toggle ESP",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
       getgenv().ESP_Enabled = Value
       if Value then
           applyESP()
           print("ESP Enabled")
       else
           print("ESP Disabled")
       end
   end
})

--// Notification Example
Rayfield:Notify({
   Title = "ESP Script Loaded",
   Content = "Use the toggle to enable/disable ESP.",
   Duration = 5,
   Image = 4483362458,
   Actions = {
       Ignore = {
           Name = "Okay!",
           Callback = function()
               print("User clicked Okay!")
           end
       }
   }
})
