{
  id = "rust";
  desc = "software for working with the programming language Rust";
  # And so I debase myself for convenience's sake
  # What sacrifice of poor purity we wretches make
  global = true;
  sw = p: with p; ([
    (rustChannelOf {
      channel = "1.19.0";
    }).rust
    rustfmt
    rustracer
  ]);
}
