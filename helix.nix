{	
  enable = true;

  settings = {
    theme = "monokai";

    editor = {
      line-number = "relative";
      mouse = false;
      auto-format = true;

      file-picker = {
        git-ignore = false;
        hidden = true;
        max-depth = 20;
      };

      soft-wrap.enable = true;
    };

    keys.normal = {
      "X" = "extend_line_above";
      "L" = "extend_to_line_end";
      "H" = "extend_to_line_start";
      "A-v" = "extend_search_next";
      "A-k" = "extend_search_prev";
      "A-o" = ["open_below" "normal_mode"];
      "A-O" = ["open_above" "normal_mode"];
    };

  };
}