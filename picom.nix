{
  enable = true;

  settings = {
    corner-radius = 15.0;
    round-borders = 0.0;
    use-damage = true;
    detect-rounded-corners = true;
    mark-ovredir-focused = false;
    mark-wmwin-focused = false;
    blur = {
      method = "gaussian";
      size = 30;
      deviation = 15.0;
    };
    blur-background-exclude = [
      "class_g = 'Peek'"
    ];
  };

  activeOpacity = 0.8;
  inactiveOpacity = 0.8;

  backend = "glx";
}