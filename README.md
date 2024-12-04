Semi-usable flamegraph generation for troubleshooting just _why_ your Nix code is so damn slow. This mostly just shows a useful visualization of the call stack, so that you can get an impression of which function is being called recursively five thousand times. :P

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

Note that it prints status info via STDERR, and the actual path via STDOUT. Therefore, it should be easy to extract the path for machine usage if desired.

# Credits

Internal script is mostly based on posts from [here](https://discourse.nixos.org/t/nix-flamegraph-or-profiling-tool/33333/11) cobbled together.
Yoinked `stack-collapse.py` from [here](https://raw.githubusercontent.com/NixOS/nix/master/contrib/stack-collapse.py), and made slight alterations (to pin Python version against flake deps).

# License

This is basically just a bunch of templates & scripts cobbled together. The parts I contributed are too trivial to really be worthy of anything other than public domain. So, um, do whatever you want.