GM.Name 		= "SDK Mode"
GM.Author 		= "SkepticDosh"
GM.Email 		= "--"
GM.Website 		= "--"
GM.TeamBased 	= false

function GM:PlayerSpawn(player)

	player:SetModel("models/player/group02/male_02.mdl")

	player:EmitSound("sdk/UI/spawn.wav",75,100)

	player:Give("weapon_physcannon")
	player:Give("weapon_crowbar")
	player:Give("weapon_pistol")
	player:GiveAmmo(150,"pistol")

end

function GM:DoPlayerDeath(player)

	player:CreateRagdoll()

	local weapon_class = player:GetActiveWeapon():GetClass()

	local weapon = ents.Create(weapon_class)

	weapon:SetPos(player:EyePos() + player:GetAng():Forward() * 25)
	weapon:SetAng(player:GetAng())
	weapon:Spawn()

end

function GM:KeyPress(player,IN_KEY)
	if SERVER and IN_KEY == IN_USE then
		player:EmitSound("common/wpn_denyselect.wav",75,100)
	end
end

function GM:GetGameDescription()
	return self.Name
end

function GM:Tick()
end

function GM:OnEntityCreated(entity)

	local ID,Class = entity:EntIndex(),entity:GetClass()

	if Class != "prop_physics" then
		chat.AddText(Color(255,255,255,255),"Entity ["..ID.."]["..Class.."] spawned")
	end

end

function GM:EntityRemoved(entity)

	local ID,Class = entity:EntIndex(),entity:GetClass()

	if Class != "prop_physics" then
		chat.AddText(Color(255,255,255,255),"Entity ["..ID.."]["..Class.."] removed")
	end

end
