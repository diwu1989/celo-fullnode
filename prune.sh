#!/bin/bash
docker stop celo-fullnode
docker rm celo-fullnode
export CELO_IMAGE=us.gcr.io/celo-org/geth:mainnet
docker run --rm -it --name celo-fullnode-prune \
        --stop-timeout 30 \
        -v $PWD:/root/.celo $CELO_IMAGE \
        --datadir /root/.celo --nousb removedb
