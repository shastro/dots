{

	# dbus = {
	# 	enable = true;
	# 	socketActivated = true;
	# };

	enable = true;	
	enableContribAndExtras = true;
	extraPackages = haskellpackages: [
		haskellpackages.xmonad-dbus
	];
	config = ./xmonad/xmonad.hs;
}
