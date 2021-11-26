#!/bin/bash
docker stop celo-fullnode
docker rm celo-fullnode

export CELO_ACCOUNT_ADDRESS=0x5Ca621B88f8f3919eb4B9324CC780a3DF34f95fD
export CELO_IMAGE=us.gcr.io/celo-org/geth:mainnet
export SYNC_MODE=ultralight
export MAX_PEERS=32
docker run --name celo-fullnode -d \
        --restart unless-stopped \
        --stop-timeout 30 \
        -p 8545:8545 -p 8546:8546 -p 30303:30303 -p 30303:30303/udp \
        -v $PWD:/root/.celo $CELO_IMAGE \
        --syncmode $SYNC_MODE --rpc --rpcaddr 0.0.0.0 --maxpeers $MAX_PEERS \
        --etherbase $CELO_ACCOUNT_ADDRESS \
        --datadir /root/.celo --nousb --cache 64 --snapshot=false \
        --ws --wsaddr 0.0.0.0 --rpcvhosts '*' --wsorigins '*' \
        --wsapi eth,net,web3,txpool --rpcapi eth,net,web3,txpool
