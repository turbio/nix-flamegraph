{
  writeShellApplication,
  writeTextFile,
  inferno,
  python3,
  ...
}: let
  stackCollapse = writeTextFile {
    name = "stack-collapse.py";
    destination = "/bin/stack-collapse.py";
    text = builtins.readFile ./stack-collapse.py;
    executable = true;
  };
in
  writeShellApplication {
    name = "nixFunctionCalls";
    runtimeInputs = [stackCollapse inferno python3];
    text = builtins.readFile ./nix-function-calls.sh;
    checkPhase = "";
  }
