#!/usr/bin/env bash
# Starts our local Alpenglow network for the /alpenglow page:
#   solana-test-validator --alpenglow (Agave 4.3.2, the version mainnet runs)
#   + Yellowstone gRPC v16.1.5 on 127.0.0.1:10000, which streams block footers
#     with their real finality certificates.
#
# Usage: scripts/alpenglow-local-node.sh          keep the ledger (same validator keys)
#        scripts/alpenglow-local-node.sh --reset  start a fresh chain
#
# The binaries, plugin, and ledger live in .alpenglow-node/ at the repo root
# (git-ignored); set ALPENGLOW_NODE_DIR to use another directory. Expected layout:
#   agave-4.3.2/bin/solana-test-validator, libyellowstone_grpc_geyser.dylib, ledger/
# To rebuild the binaries:
#   Agave:  https://github.com/anza-xyz/agave/releases/tag/v4.3.2
#           (solana-release-aarch64-apple-darwin.tar.bz2; needs `brew install libusb`)
#   plugin: git clone --branch "v16.1.5+solana.4.3.2" https://github.com/rpcpool/yellowstone-grpc
#           cargo build --release -p yellowstone-grpc-geyser
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NODE_DIR="${ALPENGLOW_NODE_DIR:-$ROOT/.alpenglow-node}"
if [[ ! -x "$NODE_DIR/agave-4.3.2/bin/solana-test-validator" ]]; then
  echo "No Agave binaries in $NODE_DIR. See the comment at the top of this script." >&2
  exit 1
fi
cd "$NODE_DIR"
HERE="$(pwd)"

cat > yellowstone.json <<EOF
{
  "libpath": "$HERE/libyellowstone_grpc_geyser.dylib",
  "log": { "level": "info" },
  "grpc": { "address": "127.0.0.1:10000", "channel_capacity": "100_000", "unary_concurrency_limit": 100, "unary_disabled": false }
}
EOF

exec ./agave-4.3.2/bin/solana-test-validator \
  --alpenglow \
  --geyser-plugin-config "$HERE/yellowstone.json" \
  --ledger "$HERE/ledger" \
  "$@"
