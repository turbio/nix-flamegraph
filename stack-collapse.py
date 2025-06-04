#!/usr/bin/env python3

# To be used with `--trace-function-calls` and `flamegraph.pl`.
#
# For example:
#
# nix-instantiate --trace-function-calls '<nixpkgs>' -A hello 2> nix-function-calls.trace
# ./contrib/stack-collapse.py nix-function-calls.trace > nix-function-calls.folded
# nix-shell -p flamegraph --run "flamegraph.pl nix-function-calls.folded > nix-function-calls.svg"

import sys
from pprint import pprint
import fileinput
import os

stack = []
timestack = []

if "SAMPLE_FREQ" in os.environ and os.environ["SAMPLE_FREQ"] != "":
    sample_period_ns = 1_000_000_000 / int(os.environ["SAMPLE_FREQ"])
else:
    sample_period_ns = 0

last_sample_ns = 0

for line in fileinput.input():
    components = line.strip().split(" ", 2)
    if components[0] != "function-trace":
        continue

    direction = components[1]
    components = components[2].rsplit(" ", 2)

    loc = components[0]
    _at = components[1]
    time = int(components[2])

    if direction == "entered":
        stack.append(loc)
        timestack.append(time)
    elif direction == "exited":
        if time >= last_sample_ns + sample_period_ns:
            last_sample_ns = time

            dur = time - timestack.pop()
            vst = ";".join(stack)
            print(f"{vst} {dur}")

        stack.pop()
