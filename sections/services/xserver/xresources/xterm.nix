{ ... }: {

  services.xserver.xresources = {
    # Set `charClass` for ease of selecting URLs. This value is sourced from
    # <https://lukas.zapletalovi.com/2013/07/hidden-gems-of-xterm.html#triple-click>,
    # albeit slightly changed to include the '#' character.
    "XTerm*charClass" =
      "33:48,35-47:48,58-59:48,61:48,63-64:48,95:48,126:48";

    "XTerm*termName" = "xterm-256color";
  };

}
