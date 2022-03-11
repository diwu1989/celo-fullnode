#!/bin/bash
docker stop celo-fullnode
docker rm celo-fullnode

export CELO_IMAGE=us.gcr.io/celo-org/geth:mainnet
export SYNC_MODE=fast
export MAX_PEERS=64
export CACHE=128
export TX_LOOKUP_LIMIT=1000
export GETH_PORT=30312
docker run --name celo-fullnode -d \
        --restart unless-stopped \
        --stop-timeout 30 \
        --memory 3G \
        -p 8545:8545 -p 8546:8546 -p $GETH_PORT:$GETH_PORT -p $GETH_PORT:$GETH_PORT/udp \
        -v $PWD:/root/.celo $CELO_IMAGE --port $GETH_PORT \
        --syncmode $SYNC_MODE --http --http.addr 0.0.0.0 --maxpeers $MAX_PEERS --txpool.lifetime 60s \
        --txlookuplimit $TX_LOOKUP_LIMIT --snapshot=true \
        --datadir /root/.celo --nousb --cache $CACHE \
        --ws --ws.addr 0.0.0.0 --http.corsdomain '*' --http.vhosts '*' --ws.origins '*' \
        --ws.api eth,net,web3,txpool --http.api eth,net,web3
