{
  id = "rust";
  desc = "software for working with the programming language Rust";
  modules = [
    ./global
  ];
  sw = p: with p; ([
    (rustChannelOf {
      channel = "1.22.1";
    }).rust
    (rustChannelOf {
      channel = "1.26.2";
    }).rust

    rustfmt
  ]);
}
