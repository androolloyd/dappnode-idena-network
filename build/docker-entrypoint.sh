#!/bin/bash

set -ex
IDENA_HOME=/root/.chaindata

CONFIG_FILE=$IDENA_HOME/config.json

cat > "$CONFIG_FILE" << EOF
{
  "DataDir": "${IDENA_HOME}",
  "P2P": {
    "MaxInboundPeers": ${MAX_PEERS_IN:-12},
    "MaxOutboundPeers": ${MAX_PEERS_OUT:-6}
  },
  "RPC": {
    "HTTPHost": "0.0.0.0",
    "HTTPPort": 9009,
    "HTTPVirtualHosts": ["idena-network.public.dappnode"]
  },
  "IpfsConf": {
    "Profile": "${IPFS_PROFILE:-lowpower}",
    "IpfsPort": 40405,
    "BlockPinThreshold": 0.3,
    "FlipPinThreshold": 0.5
  },
  "Sync": {
    "FastSync": true
  },
  "verbosity": ${LOG_LEVEL:-3},
  "apikey": "${RPC_API_KEY}"
}
EOF

bash -c "idena --config=${CONFIG_FILE} ${EXTRA_OPTS}"
