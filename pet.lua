
local petsFolder = game:GetService("Players").LocalPlayer.petsFolder
for _,v in petsFolder:GetChildren() do
   for _, pet in v:GetChildren() do
      if pet.Name == "Cool Guy Larry" then
        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("equipPetEvent"):FireServer("equipPet", pet)
      end
   end
end
