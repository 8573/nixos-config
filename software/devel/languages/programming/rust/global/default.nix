{
  id = "global";
  desc = ''
    software for working with the programming language Rust that should be installed globally
  '';
  global = true;
  sw = p: with p; [
    rustracer
  ];
}
