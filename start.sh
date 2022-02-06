#!/bin/bash
docker stop celo-fullnode
docker rm celo-fullnode

export CELO_IMAGE=registry.cloud.okteto.net/diwu1989/celo-geth:latest
export SYNC_MODE=fast
export MAX_PEERS=512
export CACHE=1024
export TX_LOOKUP_LIMIT=1000
export GETH_PORT=30314
docker run --name celo-fullnode -d \
        --restart unless-stopped \
        --stop-timeout 30 \
        --memory 6G \
        --env USE_JEMALLOC=1 \
        -p 127.0.0.1:8545:8545 -p 127.0.0.1:8546:8546 -p $GETH_PORT:$GETH_PORT -p $GETH_PORT:$GETH_PORT/udp \
        -v $PWD:/root/.celo $CELO_IMAGE --port $GETH_PORT \
        --syncmode $SYNC_MODE --http --http.addr 0.0.0.0 --maxpeers $MAX_PEERS --txpool.lifetime 60s \
        --txlookuplimit $TX_LOOKUP_LIMIT \
        --datadir /root/.celo --nousb --cache $CACHE \
        --ws --ws.addr 0.0.0.0 --http.vhosts '*' --ws.origins '*' \
        --ws.api eth,net,web3,txpool,debug --http.api eth,net,web3,txpool,debug
