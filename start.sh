#!/bin/bash
docker stop celo-fullnode
docker rm celo-fullnode

export CELO_ACCOUNT_ADDRESS=0x5Ca621B88f8f3919eb4B9324CC780a3DF34f95fD
export CELO_IMAGE=us.gcr.io/celo-org/geth:mainnet
export SYNC_MODE=fast
export MAX_PEERS=128
export CACHE=512
export TX_LOOKUP_LIMIT=4320
docker run --name celo-fullnode -d \
        --restart unless-stopped \
        --stop-timeout 30 \
        -p 8545:8545 -p 8546:8546 -p 30303:30303 -p 30303:30303/udp \
        -v $PWD:/root/.celo $CELO_IMAGE \
        --rpc.txfeecap 0 \
        --syncmode $SYNC_MODE --http --http.addr 0.0.0.0 --maxpeers $MAX_PEERS --txpool.lifetime 60s \
        --etherbase $CELO_ACCOUNT_ADDRESS --txlookuplimit $TX_LOOKUP_LIMIT \
        --datadir /root/.celo --nousb --cache $CACHE --snapshot=true --cache.snapshot 20 \
        --ws --ws.addr 0.0.0.0 --http.vhosts '*' --ws.origins '*' \
        --ws.api eth,net,web3,txpool --http.api eth,net,web3,txpool
