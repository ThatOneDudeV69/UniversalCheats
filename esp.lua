local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function highlightPlayer(character, player)
    if character and player ~= LocalPlayer then -- Exclude yourself
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
            billboard.Size = UDim2.new(10, 0, 2, 0)  -- Increased the size
            billboard.StudsOffset = Vector3.new(0, 2, 0) -- Position above head
            billboard.AlwaysOnTop = true
            billboard.Parent = head

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
            nameLabel.TextStrokeTransparency = 0 -- Black outline for visibility
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.Font = Enum.Font.SourceSansBold
            nameLabel.TextScaled = true
            nameLabel.Parent = billboard
        end
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        highlightPlayer(character, player)
    end)
end

-- Apply highlight & name tag to existing players
for _, player in pairs(Players:GetPlayers()) do
    if player.Character then
        highlightPlayer(player.Character, player)
    end
    onPlayerAdded(player)
end

-- Listen for new players joining
Players.PlayerAdded:Connect(onPlayerAdded)
