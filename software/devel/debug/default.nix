{
  id = "debug";
  desc = "debugging software";
  sw = p: with p; [
    gdb
    llvmPackages.lldb
  ];
}
