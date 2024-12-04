Semi-usable flamegraph generation for troubleshooting just _why_ your Nix code is so damn slow.

# Usage

Help page:

```
nix run github:crabdancing/nix-flamegraph -- --help
```

Process a flake (e.g.):


```
nix run github:crabdancing/nix-flamegraph -- -t /etc/nixos
```

You just point it at a target, and it _hopefully_ prints out the path to an SVG. Internals are very jank. Results may vary.

# Credits

Mostly based on posts from [here](https://discourse.nixos.org/t/nix-flamegraph-or-profiling-tool/33333/11) cobbled together.
Yoinked `stack-collapse.py` from [here](https://raw.githubusercontent.com/NixOS/nix/master/contrib/stack-collapse.py), and made slight alterations (to pin Python version against flake deps).