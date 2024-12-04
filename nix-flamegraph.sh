#!/usr/bin/env bash

workdir=$(mktemp -d)

nix eval -vvvvvvvvvvvvvvvvvvvv --raw --option trace-function-calls true "$target" 1>/dev/null 2> "$workdir/nix-function-calls.trace"
stack-collapse.py "$workdir/nix-function-calls.trace" > "$workdir/nix-function-calls.folded"
inferno-flamegraph "$workdir/nix-function-calls.folded" > "$workdir/nix-function-calls.svg"
echo "$workdir/nix-function-calls.svg"