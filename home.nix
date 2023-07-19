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

    # Services
    services.picom = import ./picom.nix;
    

    services.polybar.enable = true;
    services.polybar.config = ./polybar/config.ini;
  }
  
  

