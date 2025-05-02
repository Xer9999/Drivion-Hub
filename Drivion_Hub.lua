--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local player = Players.LocalPlayer

--// Settings
local floatHeight = 5
local targetPosition = Vector3.new(1969.71948, floatHeight, -12054.5166)
local returnPosition = Vector3.new(1230.07874, floatHeight, -19955.8223)
local moveSpeed = 550
local moveDuration = 3
local isMoving = false
local autoFarmEnabled = false

---------------------------------------------------------------------------------------------------------

--// Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
	Name = "Drivion Hub",
	LoadingTitle = "Ridgewood | Pre-alpha",
	LoadingSubtitle = "by San",
	Theme = "Default",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "DrivionHub",
		FileName = "Drivion Hub"
	},
	KeySystem = true,
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "Get key On discord",
		FileName = "Key",
		SaveKey = true,
		Key = {"DrivionHub-x1f4rth6k8t5" , "foradmintester1234"}
	}
})

---------------------------------------------------------------------------------------------------------

--// UI Tabs and Sections
local Tab = Window:CreateTab("Main", "Home")
Tab:CreateSection("Auto Farm")

-- Auto Farm
Tab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		autoFarmEnabled = Value
	end,
})

-- Set car speed 
Tab:CreateSlider({
	Name = "Set Speed",
	Range = {0, 600},
	Increment = 10,
	Suffix = "Speed",
	CurrentValue = moveSpeed,
	Flag = "Slider1",
	Callback = function(Value)
		moveSpeed = Value
	end,
})

-- Anti AFK
Tab:CreateButton({
	Name = "Anti AFK",
	Callback = function()
		local VirtualUser = game:GetService("VirtualUser")
		Players.LocalPlayer.Idled:Connect(function()
			VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			wait(1)
			VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		end)

		Rayfield:Notify({
			Title = "Anti-AFK Activated",
			Content = "You will no longer go AFK!",
			Duration = 6.5
		})
	end,
})

-- Misc
local Tab = Window:CreateTab("Misc", 4483362458)

--Player Section
local Section = Tab:CreateSection("Player")

--// Player reference
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Walk Speed
local walkSpeedEnabled = false
local walkSpeedValue = 10

Tab:CreateToggle({
	Name = "Walk Speed",
	CurrentValue = false,
	Flag = "WalkSpeedToggle",
	Callback = function(Value)
		walkSpeedEnabled = Value
		if Value then
			humanoid.WalkSpeed = walkSpeedValue
		else
			humanoid.WalkSpeed = 16 -- default
		end
	end,
})

Tab:CreateSlider({
	Name = "Set Walk Speed",
	Range = {0, 200},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 10,
	Flag = "WalkSpeedSlider",
	Callback = function(Value)
		walkSpeedValue = Value
		if walkSpeedEnabled then
			humanoid.WalkSpeed = Value
		end
	end,
})

-- Jump Power
local jumpPowerEnabled = false
local jumpPowerValue = 10

Tab:CreateToggle({
	Name = "Jump Power",
	CurrentValue = false,
	Flag = "JumpPowerToggle",
	Callback = function(Value)
		jumpPowerEnabled = Value
		if Value then
			humanoid.UseJumpPower = true
			humanoid.JumpPower = jumpPowerValue
		else
			humanoid.JumpPower = 50 -- default
			humanoid.UseJumpPower = false
		end
	end,
})

Tab:CreateSlider({
	Name = "Set Jump Power",
	Range = {0, 250},
	Increment = 5,
	Suffix = "Power",
	CurrentValue = 10,
	Flag = "JumpPowerSlider",
	Callback = function(Value)
		jumpPowerValue = Value
		if jumpPowerEnabled then
			humanoid.UseJumpPower = true
			humanoid.JumpPower = Value
		end
	end,
})

-- Noclip
local noclipEnabled = false
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local noclipConnection

local Toggle = Tab:CreateToggle({
   Name = "NoClip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
      noclipEnabled = Value

      if Value then
         -- Enable NoClip
         noclipConnection = RunService.Stepped:Connect(function()
            local character = player.Character
            if character then
               for _, part in ipairs(character:GetDescendants()) do
                  if part:IsA("BasePart") and part.CanCollide then
                     part.CanCollide = false
                  end
               end
            end
         end)
      else
         -- Disable NoClip and reconnect collision
         if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
         end
         local character = player.Character
         if character then
            for _, part in ipairs(character:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.CanCollide = true
               end
            end
         end
      end
   end,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local flyEnabled = false
local flySpeed = 50
local flyingConnection
local inputDirection = Vector3.zero

-- Handle input
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.W then inputDirection = inputDirection + Vector3.new(0, 0, -1) end
	if input.KeyCode == Enum.KeyCode.S then inputDirection = inputDirection + Vector3.new(0, 0, 1) end
	if input.KeyCode == Enum.KeyCode.A then inputDirection = inputDirection + Vector3.new(-1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.D then inputDirection = inputDirection + Vector3.new(1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.Space then inputDirection = inputDirection + Vector3.new(0, 1, 0) end
	if input.KeyCode == Enum.KeyCode.LeftShift then inputDirection = inputDirection + Vector3.new(0, -1, 0) end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W then inputDirection = inputDirection - Vector3.new(0, 0, -1) end
	if input.KeyCode == Enum.KeyCode.S then inputDirection = inputDirection - Vector3.new(0, 0, 1) end
	if input.KeyCode == Enum.KeyCode.A then inputDirection = inputDirection - Vector3.new(-1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.D then inputDirection = inputDirection - Vector3.new(1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.Space then inputDirection = inputDirection - Vector3.new(0, 1, 0) end
	if input.KeyCode == Enum.KeyCode.LeftShift then inputDirection = inputDirection - Vector3.new(0, -1, 0) end
end)

-- Fly
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 50
local flyVelocity = nil
local flyConnection = nil

local direction = Vector3.zero

-- Handle movement input
local function updateDirection()
	direction = Vector3.zero
	if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction += Vector3.new(0, 0, -1) end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction += Vector3.new(0, 0, 1) end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction += Vector3.new(-1, 0, 0) end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction += Vector3.new(1, 0, 0) end
	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.new(0, 1, 0) end
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction += Vector3.new(0, -1, 0) end
end

-- Update on input
UserInputService.InputBegan:Connect(updateDirection)
UserInputService.InputEnded:Connect(updateDirection)

-- Toggle UI
Tab:CreateToggle({
	Name = "Fly",
	CurrentValue = false,
	Flag = "FlyToggle",
	Callback = function(Value)
		flying = Value

		if flying then
			character = player.Character or player.CharacterAdded:Wait()
			humanoidRootPart = character:WaitForChild("HumanoidRootPart")

			flyVelocity = Instance.new("BodyVelocity")
			flyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
			flyVelocity.Velocity = Vector3.zero
			flyVelocity.Name = "FlyVelocity"
			flyVelocity.Parent = humanoidRootPart

			flyConnection = RunService.RenderStepped:Connect(function()
				updateDirection()
				local camCF = workspace.CurrentCamera.CFrame
				local moveDirection = camCF:VectorToWorldSpace(direction)
				if moveDirection.Magnitude > 0 then
					flyVelocity.Velocity = moveDirection.Unit * flySpeed
				else
					flyVelocity.Velocity = Vector3.zero
				end
			end)
		else
			if flyVelocity then
				flyVelocity:Destroy()
				flyVelocity = nil
			end
			if flyConnection then
				flyConnection:Disconnect()
				flyConnection = nil
			end
		end
	end,
})

-- Speed slider
Tab:CreateSlider({
	Name = "Fly Speed",
	Range = {0, 500},
	Increment = 5,
	Suffix = "Speed",
	CurrentValue = flySpeed,
	Flag = "FlySpeedSlider",
	Callback = function(Value)
		flySpeed = Value
	end,
})

-- Reduce Lag Section
Tab:CreateSection("Reduce lag")
Tab:CreateButton({
	Name = "Reduce lag",
	Callback = function()
		local Lighting = game:GetService("Lighting")
		local Workspace = game:GetService("Workspace")
		local Terrain = Workspace:FindFirstChildOfClass("Terrain")

		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		Lighting.GlobalShadows = false
		Lighting.Brightness = 0
		Lighting.FogEnd = 1000000
		Lighting.ClockTime = 14
		Lighting.EnvironmentDiffuseScale = 0
		Lighting.EnvironmentSpecularScale = 0

		for _, child in ipairs(Lighting:GetChildren()) do
			if child:IsA("PostEffect") then
				child:Destroy()
			end
		end

		if Terrain then
			Terrain.WaterTransparency = 1
			Terrain.WaterReflectance = 0
			Terrain.WaterWaveSize = 0
			Terrain.WaterWaveSpeed = 0
		end

		local KeywordsToRemove = {
			"tree", "leaf", "leaves", "bush", "grass", "plant", "shrub", "foliage", "flower"
		}

		local ClassesToRemove = {
			"Decal", "Texture", "SurfaceAppearance",
			"ParticleEmitter", "Trail", "Beam",
			"Fire", "Smoke", "Sparkles",
			"SurfaceGui", "BillboardGui", "Explosion",
			"ForceField"
		}

		local function optimize(obj)
			for _, className in ipairs(ClassesToRemove) do
				if obj:IsA(className) then
					obj:Destroy()
					return
				end
			end

			local name = obj.Name:lower()
			for _, keyword in ipairs(KeywordsToRemove) do
				if name:find(keyword) then
					if obj:IsA("Model") then
						obj:Destroy()
					elseif obj:IsA("BasePart") then
						obj.Transparency = 1
						obj.CanCollide = false
						obj.CastShadow = false
					end
					return
				end
			end

			if obj:IsA("BasePart") then
				obj.Material = Enum.Material.SmoothPlastic
				obj.CastShadow = false
			end
		end

		for _, obj in ipairs(Workspace:GetDescendants()) do
			optimize(obj)
		end

		Workspace.DescendantAdded:Connect(function(obj)
			task.defer(function()
				optimize(obj)
			end)
		end)

		Rayfield:Notify({
			Title = "Lag Reduction Activated",
			Content = "Environment optimized for low performance!",
			Duration = 6.5
		})
	end,
})

---------------------------------------------------------------------------------------------------------

--// Vehicle Functions
local function getVehicleModel()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	for _, seat in ipairs(workspace:GetDescendants()) do
		if seat:IsA("VehicleSeat") and seat.Occupant == humanoid then
			local model = seat:FindFirstAncestorOfClass("Model")
			if model then
				if not model.PrimaryPart then
					model.PrimaryPart = seat
				end
				return model
			end
		end
	end
	warn("cant find Vehicle")
	return nil
end

local function moveModel(model, destination, duration, faceForward)
	local startPos = model.PrimaryPart.Position
	local targetPos = Vector3.new(destination.X, floatHeight, destination.Z)

	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e5, 0, 1e5)
	bv.Velocity = Vector3.zero
	bv.Parent = model.PrimaryPart
	Debris:AddItem(bv, duration + 1)

	local bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
	bg.P = 3000
	bg.D = 300
	bg.CFrame = faceForward and CFrame.new(startPos, targetPos) or model:GetPrimaryPartCFrame()
	bg.Parent = model.PrimaryPart
	Debris:AddItem(bg, duration + 1)

	local startTime = tick()
	local conn
	conn = RunService.Heartbeat:Connect(function()
		local pos = model.PrimaryPart.Position
		local direction = (targetPos - pos).Unit
		bv.Velocity = direction * moveSpeed

		local newPos = Vector3.new(pos.X, floatHeight, pos.Z)
		model:SetPrimaryPartCFrame(CFrame.new(newPos) * bg.CFrame.Rotation)

		if tick() - startTime >= duration then
			if conn then conn:Disconnect() end
			model.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
		end
	end)
end

local warnedOnce = false

local function floatToTargetAndBack()
	if isMoving or not autoFarmEnabled then return end
	isMoving = true

	local vehicle = getVehicleModel()
	if not vehicle then
		isMoving = false

		if not warnedOnce then
			Rayfield:Notify({
				Title = "Auto Farm Error",
				Content = "Please sit in the vehicle before starting Auto Farm.",
				Duration = 6.5,
				Image = "Car"
			})
			warnedOnce = true
		end

		return
	end

	warnedOnce = false

	moveModel(vehicle, targetPosition, moveDuration, true)
	task.wait(moveDuration + 0.1)
	vehicle:SetPrimaryPartCFrame(CFrame.new(returnPosition))

	isMoving = false
end

--// Run Auto Farm
RunService.Heartbeat:Connect(function()
	if autoFarmEnabled then
		floatToTargetAndBack()
	end
end)
--//end