local ReplicatedStorage = game:GetService("ReplicatedStorage")

local event = ReplicatedStorage:FindFirstChild("MovementEvent")

if not event then
	event = Instance.new("RemoteEvent")
	event.Name = "MovementEvent"
	event.Parent = ReplicatedStorage
end

local DEFAULT_SPEED = 16
local DEFAULT_JUMP = 50

local MAX_SPEED = 500
local MAX_JUMP = 300

event.OnServerEvent:Connect(function(player, action, value)

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	if action == "Speed" then

		value = tonumber(value)
		if not value then return end

		value = math.clamp(value, DEFAULT_SPEED, MAX_SPEED)
		humanoid.WalkSpeed = value

	elseif action == "Jump" then

		value = tonumber(value)
		if not value then return end

		value = math.clamp(value, DEFAULT_JUMP, MAX_JUMP)

		humanoid.UseJumpPower = true
		humanoid.JumpPower = value

	elseif action == "Reset" then

		humanoid.WalkSpeed = DEFAULT_SPEED
		humanoid.UseJumpPower = true
		humanoid.JumpPower = DEFAULT_JUMP
	end
end)

game.Players.PlayerAdded:Connect(function(player)

	player.CharacterAdded:Connect(function(character)

		local humanoid = character:WaitForChild("Humanoid")

		humanoid.WalkSpeed = DEFAULT_SPEED
		humanoid.UseJumpPower = true
		humanoid.JumpPower = DEFAULT_JUMP
	end)
end)