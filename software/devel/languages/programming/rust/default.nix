{
  id = "rust";
  desc = "software for working with the programming language Rust";
  modules = [
    ./global
  ];
  sw = p: with p; ([
    (rustChannelOf {
      channel = "1.34.2";
    }).rust

    ((rustChannelOf {
      channel = "1.34.2";
    }).rust.override {
      extensions = [
        "clippy-preview"
      ];
    })

    rustfmt
  ]);
}
