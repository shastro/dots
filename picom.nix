{
  enable = true;

  settings = {
    corner-radius = 15.0;
    round-borders = 0.0;
    use-damage = true;
    detect-rounded-corners = true;
    blur = {
      method = "gaussian";
      size = 10;
      deviation = 5.0;
    };
  };

  activeOpacity = 0.8;
  inactiveOpacity = 0.8;

  backend = "glx";
}