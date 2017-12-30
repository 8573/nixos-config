{
  id = "rust";
  desc = "software for working with the programming language Rust";
  modules = [
    ./global
  ];
  sw = p: with p; ([
    (rustChannelOf {
      # The last version of 2017, as of 2017-12-30.
      channel = "1.22.1";
    }).rust
    rustfmt
    rustracer
  ]);
}
