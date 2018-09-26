{
  id = "rust";
  desc = "software for working with the programming language Rust";
  modules = [
    ./global
  ];
  sw = p: with p; ([
    (rustChannelOf {
      channel = "1.29.1";
    }).rust

    ((rustChannelOf {
      channel = "1.29.1";
    }).rust.override {
      extensions = [
        "clippy-preview"
      ];
    })

    rustfmt
  ]);
}
