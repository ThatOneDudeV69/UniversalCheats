local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local animationToBlock = "rbxassetid://3819191349" -- Animation ID to block

-- Function to block the specific animation when played
local function blockSpecificAnimation()
    -- Wait for the local player's character to load
    LocalPlayer.CharacterAdded:Connect(function(character)
        -- Wait for the humanoid to exist in the character
        local humanoid = character:WaitForChild("Humanoid")
        
        -- Connect to the AnimationPlayed event
        humanoid.AnimationPlayed:Connect(function(animationTrack)
            -- Check if the animation being played matches the one we want to block
            if animationTrack.Animation.AnimationId == animationToBlock then
                -- If it matches, immediately stop the animation
                print("Blocking animation: " .. animationToBlock)
                animationTrack:Stop() -- This stops the animation
            end
        end)
    end)
end

-- Start blocking the specific animation for the local player
blockSpecificAnimation()
