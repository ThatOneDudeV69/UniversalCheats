local Players = game:GetService("Players")

local function highlightPlayer(character)
    if character then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Yellow glow
        highlight.OutlineColor = Color3.fromRGB(255, 255, 0) -- Red outline
        highlight.Parent = character
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        highlightPlayer(character)
    end)
end

-- Apply highlight to existing players
for _, player in pairs(Players:GetPlayers()) do
    if player.Character then
        highlightPlayer(player.Character)
    end
    onPlayerAdded(player)
end

-- Listen for new players
Players.PlayerAdded:Connect(onPlayerAdded)
