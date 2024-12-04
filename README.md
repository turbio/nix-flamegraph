Semi-usable flamegraph generation for troubleshooting just _why_ your Nix code is so damn slow.

# Credits

Mostly based on posts from [here](https://discourse.nixos.org/t/nix-flamegraph-or-profiling-tool/33333/11) cobbled together.
Yoinked `stack-collapse.py` from [here](https://raw.githubusercontent.com/NixOS/nix/master/contrib/stack-collapse.py), and made slight alterations (to pin Python version against flake deps).