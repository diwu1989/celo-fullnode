#!/bin/bash
docker stop celo-fullnode
docker rm celo-fullnode

export CELO_ACCOUNT_ADDRESS=0x5Ca621B88f8f3919eb4B9324CC780a3DF34f95fD
export CELO_IMAGE=cloud.canister.io:5000/diwu1989/celo-geth:latest
export SYNC_MODE=fast
export MAX_PEERS=100
export CACHE=512
export TX_LOOKUP_LIMIT=4320
docker run --name celo-fullnode -d \
        --restart unless-stopped \
        --stop-timeout 30 \
        -p 30303:30303 -p 30303:30303/udp \
        -v $PWD:/root/.celo $CELO_IMAGE \
        --syncmode $SYNC_MODE --http --http.addr 0.0.0.0 --maxpeers $MAX_PEERS \
        --etherbase $CELO_ACCOUNT_ADDRESS --txlookuplimit $TX_LOOKUP_LIMIT \
        --datadir /root/.celo --nousb --cache $CACHE --snapshot=false \
        --ws --ws.addr 0.0.0.0 --http.vhosts '*' --ws.origins '*' \
        --ws.api eth,net,web3,txpool --http.api eth,net,web3,txpool
