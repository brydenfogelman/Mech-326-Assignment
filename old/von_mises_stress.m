function von_mises_stress = function(sigma_x, sigma_y, sigma_z, tau_xy, tau_xz, tau_yz)
	von_mises_stress = sqrt( (sigma_x - sigma_y)^2 + (sigma_y - sigma_z)^2 + (sigma_z - sigma_x)^2 + 3*(tau_xy^2 + tau_xz^2 + tau_yz^2));
end