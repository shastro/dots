  {config, pkgs, ... }: 
  
  {

    imports = [
      
    ];

    programs.home-manager.enable = true;
    home.stateVersion = "23.05";
    home.packages = with pkgs; [
      lf
      exa
      firefox
      polybar
      rofi
      kitty
      helix
      gitui
      flameshot
      rofi
      feh
    ];


    # Variables
    home.sessionVariables = {
      EDITOR = "hx";
    };

    # Xsession
    xsession.enable = true;
    xsession.windowManager.xmonad = import ./xmonad.nix;

    # Programs
    programs.helix = import ./helix.nix;
    programs.fish.enable = true;
    programs.git = {
      enable = true;
      userEmail = "guitarshughes@hotmail.com";
      userName = "shastro";
    };

    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        term = "xterm";
        confirm_os_window_close = 0;
      };
    };

    # Services
    services.picom = import ./picom.nix;
    # Hide the mouse cursor when not in use:
    services.unclutter = {
      enable = true;
      extraOptions = [ "ignore-scrolling" ];
    };


    # services.polybar.enable = true;
    # services.polybar.config = ./polybar/config.ini;

  }
  
  

