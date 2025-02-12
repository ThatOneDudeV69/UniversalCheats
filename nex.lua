while true do
  local args = {
    [1] = "rep"
}

game:GetService("Players").LocalPlayer:WaitForChild("muscleEvent"):FireServer(unpack(args))
  wait()
end  
