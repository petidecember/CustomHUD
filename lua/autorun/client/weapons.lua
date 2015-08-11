weaps = { }

function weaps:GetCurrentMaxAmmo()
	maxAmmo = 0
	currentWep = LocalPlayer():GetActiveWeapon()
	if (currentWep == "")
		
	end
	return maxAmmo
end

return weaps