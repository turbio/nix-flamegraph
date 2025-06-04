#!/usr/bin/env bash

workdir=$(mktemp -d)

if [[ -z "$output" ]]; then
  output="$workdir/nix-function-calls.svg"
fi

if [[ -e "$output" ]]; then
  die "The output file already exists." 5
fi

echo "Started \`nix eval\` against target..." >&2
nix eval --option trace-function-calls true "$target" 2> \
  >(tee "$workdir/nix-function-calls.trace" | grep -v '^function-trace ' >&2)

echo "Done. Running \`stack-collapse\`..." >&2
stack-collapse.py "$workdir/nix-function-calls.trace" > "$workdir/nix-function-calls.folded"

echo "Done. Running \`inferno-flamegraph\`..." >&2


inferno-flamegraph "$workdir/nix-function-calls.folded" > "$output"

echo "$output"
