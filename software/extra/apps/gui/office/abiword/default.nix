{
  id = "abiword";
  desc = "the word processor AbiWord";
  default = {config, parent, ...}:
    parent.enable
    # If the computer is expected to stay connected to the Internet, I can use
    # Google Docs.
    && !config.c74d-params.usually-on-Internet
    # If I have KDE, I should have Calligra.
    && !config.c74d-params.KDE.enable;
  sw = p: with p; [
    abiword
  ];
}
