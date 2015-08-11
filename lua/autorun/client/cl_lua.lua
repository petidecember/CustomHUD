include("weapons.lua")

roundness = 2
size = 3

hbox = { }

hbox.x = 15
hbox.y = ScrH() - 130
hbox.w = 200
hbox.h = 25

hinbox = { }

hinbox.x = hbox.x + size
hinbox.y = hbox.y + size
hinbox.w = hbox.w - size * 2
hinbox.h = hbox.h - size * 2

abox = { }

abox.x = 15
abox.y = ScrH() - 100
abox.w = 200
abox.h = 25

ainbox = { }

ainbox.x = abox.x + size
ainbox.y = abox.y + size
ainbox.w = abox.w - size * 2
ainbox.h = abox.h - size * 2

wbox = { }
wbox.x = ScrW() - 165
wbox.y = ScrH() - 130
wbox.w = 150
wbox.h = 25

winbox = { }
winbox.x = wbox.x + size
winbox.y = wbox.y + size
winbox.w = wbox.w - size * 2
winbox.h = wbox.h - size * 2

function hud()
	local client = LocalPlayer()
	local clientHP = client:Health() / 100
	local clientArm = client:Armor() / 100
	local colorHP =  Color(255, Lerp(clientHP, 0, 160), 0, 255 )
	local colorArm = Color(0, Lerp(clientArm, 35, 100), Lerp(clientArm, 80, 200), 255 )
	
	if !client:Alive() then return end
	if(client:GetActiveWeapon() == NULL or client:GetActiveWeapon() == "Camera") then return end
	
	draw.RoundedBox(roundness, hbox.x, hbox.y, hbox.w, hbox.h, Color(51, 58, 51, 255))
	draw.RoundedBox(roundness, hinbox.x, hinbox.y, hinbox.w * clientHP, hinbox.h, colorHP)
	if (client:Armor() ~= 0) then
		draw.RoundedBox(roundness, abox.x, abox.y, abox.w, abox.h, Color(51, 58, 51, 255))
		draw.RoundedBox(roundness, ainbox.x, ainbox.y, ainbox.w * clientArm, ainbox.h, colorArm)
	end
	
	local mag_left = client:GetActiveWeapon():Clip1() // How much ammunition you have inside the current magazine
	local mag_extra = client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()) // How much ammunition you have outside the current magazine
	
	draw.RoundedBox(roundness, wbox.x, wbox.y, wbox.w, wbox.h, Color(51, 58, 51, 255))
	draw.RoundedBox(roundness, winbox.x, winbox.y, winbox.w * mag_left / 45, winbox.h, Color(200, 200, 200, 255))
	draw.SimpleText( tostring(mag_left) .. " : " .. tostring(mag_extra), "Default", ScrW() - 110, ScrH() - 124, color_white)
end
hook.Add("HUDPaint", "hud", hud)
 
local tohide = { -- This is a table where the keys are the HUD items to hide
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true
}
local function HUDShouldDraw(name) -- This is a local function because all functions should be local unless another file needs to run it
	if (tohide[name]) then     -- If the HUD name is a key in the table
		return false;      -- Return false.
	end
end
hook.Add("HUDShouldDraw", "How to: HUD Example HUD hider", HUDShouldDraw)

concommand.Add( "hudreload", hud )