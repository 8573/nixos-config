{
  id = "extra";
  name = "extra user-facing software";
  # TODO: Make `default` be a function of
  # `config.c74d-params.installation-type`.
  default = true;
  modules = [
    ./tools
  ];
}
