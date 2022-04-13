#!/bin/bash
docker stop celo-fullnode
docker rm celo-fullnode
export CELO_IMAGE=cloud.canister.io:5000/diwu1989/celo-geth:latest
docker run --rm -it --name celo-fullnode-prune \
        --stop-timeout 30 \
        -v $PWD:/root/.celo $CELO_IMAGE \
        --datadir /root/.celo --nousb removedb
