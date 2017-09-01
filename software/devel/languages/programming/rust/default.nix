{
  id = "rust";
  desc = "software for working with the programming language Rust";
  modules = [
    ./global
  ];
  sw = p: with p; ([
    (rustChannelOf {
      channel = "1.20.0";
    }).rust
    rustfmt
    rustracer
  ]);
}
