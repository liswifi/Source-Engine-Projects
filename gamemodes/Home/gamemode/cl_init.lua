include("shared.lua")

function GM:CalcView(player,origin,angles,fov,nearz,farz)

	local view	= {}
	view.origin = origin
	view.angles = angles
	view.fov	= fov
	view.nearz	= nearz
	view.farz	= farz

	return view
end

local fontData	= {
	font 		= "HL2Cross",
	size 		= 44,
	weight 		= 430,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= false,
	additive 	= false,
	outline		= false
}

surface.CreateFont("hl2c_crosshair",fontData)

function GM:HUDPaint()

	local player = LocalPlayer()

	local crosshair_x		= surface.ScreenWidth() * 0.5
	local crosshair_y		= surface.ScreenHeight() * 0.5
	local crosshair_color	= Color(255,220,0,220)
	local crosshair_spacing	= 15

	draw.SimpleText("[","hl2c_crosshair",crosshair_x - crosshair_spacing,crosshair_y,crosshair_color,2,1)
	draw.SimpleText("]","hl2c_crosshair",crosshair_x + crosshair_spacing,crosshair_y,crosshair_color,0,1)

	--

	local trace = player:GetEyeTrace()

	if trace.Entity != NULL then
		local pos = trace.Entity:GetPos():ToScreen()
		draw.SimpleText(trace.Entity:GetClass(),"DebugFixed",pos.x,pos.y,Color(255,255,255,255),2,1)
	end

	--

	surface.SetDrawColor(0,0,0,220)
	surface.DrawRect(surface.ScreenScale(720),surface.ScreenScale(8),surface.ScreenScale(125),surface.ScreenScale(50))

	surface.SetFont("DebugFixed")
	surface.SetTextColor(255,255,255,255)

	surface.SetTextPos(surface.ScreenScale(722),surface.ScreenScale(8))
	surface.DrawText("Engine statistics")

	local framerate = engine.FrameRate()

	surface.SetTextPos(surface.ScreenScale(722),surface.ScreenScale(13))
	surface.DrawText("FrameRate: "..math.Round(framerate,1))

	--

	surface.SetTextPos(surface.ScreenScale(722),surface.ScreenScale(20))
	surface.DrawText("LocalPlayer statistics")

	local vel = player:GetVelocity():Length()

	surface.SetTextPos(surface.ScreenScale(722),surface.ScreenScale(25))
	surface.DrawText("Velocity: "..math.Round(vel,1))

	local ping = player:Ping()

	surface.SetTextPos(surface.ScreenScale(722),surface.ScreenScale(30))
	surface.DrawText("Ping: "..math.Round(ping,1))
end

local halo_FakeColor,halo_RealColor = Color(0,0,0,0),Color(0,0,0,0)

function GM:PreDrawHalos()

	local player = LocalPlayer()

	local entity = player:GetEyeTrace().Entity

	if entity != NULL and entity:GetClass() != "worldspawn" then
		local size = 2 + math.sin(CurTime() * 5) * 0.75
		halo.Add({entity},Color(0,255,0,255),size,size,1)
	end

end
