local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Configuration (Adjust these values)
local LockOnDistance = 50 -- How close a player needs to be to lock on
local CameraLockEnabled = true -- Whether camera lock is initially enabled

-- Variables
local LockedTarget = nil

-- Function to find the closest player
local function FindClosestPlayer()
    local closestPlayer = nil
    local closestDistance = LockOnDistance

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetRootPart = player.Character.HumanoidRootPart
            local distance = (HumanoidRootPart.Position - targetRootPart.Position).Magnitude

            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end

    return closestPlayer
end


-- Function to lock the camera on the target
local function LockCamera(target)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        LockedTarget = target
        Camera.CameraType = Enum.CameraType.Scriptable  -- Important for controlling the camera
        
        -- Smooth camera movement (optional, but makes it nicer)
        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(
            0.2, -- Time (seconds)
            Enum.EasingStyle.Quad,  -- Easing style (smoothness)
            Enum.EasingDirection.Out, -- Easing direction
            0, -- Repeat count
            false, -- Reverse direction
            0 -- Delay time
        )

        local cameraCFrame = CFrame.new(
            HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 5, -- Slightly behind the player
            target.Character.HumanoidRootPart.Position -- Look at the target
        )
        local tween = tweenService:Create(Camera, tweenInfo, {CFrame = cameraCFrame})
        tween:Play()


    else
        UnlockCamera() -- Unlock if target is invalid
    end
end

-- Function to unlock the camera
local function UnlockCamera()
    LockedTarget = nil
    Camera.CameraType = Enum.CameraType.Custom -- Or whatever your default camera type is
end



-- Main loop
game:GetService("RunService").Heartbeat:Connect(function()
    if CameraLockEnabled then
        local closestPlayer = FindClosestPlayer()
        if closestPlayer then
            LockCamera(closestPlayer)
        elseif LockedTarget then  --If we HAVE a target but it's no longer close, unlock.
            UnlockCamera()
        end
    end

    if LockedTarget and LockedTarget.Character and LockedTarget.Character:FindFirstChild("HumanoidRootPart") then
                -- Update camera position if target is still valid and locked
            local cameraCFrame = CFrame.new(
            HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 5, -- Slightly behind the player
            LockedTarget.Character.HumanoidRootPart.Position -- Look at the target
            )
            Camera.CFrame = cameraCFrame -- Directly set CFrame for continuous update
    end
end)



-- Toggle camera lock (Example: Press "Q")
local ContextActionService = game:GetService("ContextActionService")
local function ToggleCameraLock(actionName, state, inputObject)
    if actionName == "ToggleLock" and state == Enum.UserInputState.Begin then
        CameraLockEnabled = not CameraLockEnabled
        if not CameraLockEnabled then
            UnlockCamera() -- Unlock when disabling
        end
    end
end

ContextActionService:BindAction("ToggleLock", ToggleCameraLock, false, Enum.KeyCode.Q) -- Change "Q" to your preferred key
ContextActionService:SetTitle("ToggleLock", "Toggle Camera Lock (Q)")


print("Camera Lock Script Initialized.")
