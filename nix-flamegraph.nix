{
  writeShellApplication,
  writeTextFile,
  inferno,
  python3,
  pog,
  ...
}: let
  stackCollapse = writeTextFile {
    name = "stack-collapse.py";
    destination = "/bin/stack-collapse.py";
    text = builtins.readFile ./stack-collapse.py;
    executable = true;
  };
in
  pog.pog {
    name = "nix-flamegraph";
    description = "Generates a flamegraph of a Nix evaluation process";
    runtimeInputs = [stackCollapse inferno python3];
    script = builtins.readFile ./nix-flamegraph.sh;
    strict = true;
    flags = [
      {
        name = "target";
        short = "t";
        description = "Nix eval target";
        argument = "TARGET";
        envVar = "NIX_FLAMEGRAPH_TARGET";
        required = true;
      }
      {
        name = "output";
        short = "o";
        description = "Copy SVG to output path";
        argument = "OUTPUT";
        envVar = "NIX_FLAMEGRAPH_OUTPUT";
        required = false;
        default = "";
      }
      {
        name = "freq";
        short = "F";
        description = "Downsample to frequency (in Hz)";
        argument = "FREQ";
        envVar = "NIX_FLAMEGRAPH_FREQ";
        required = false;
        default = "";
      }
    ];
  }
