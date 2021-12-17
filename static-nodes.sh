#!/bin/bash
curl -s 'https://www.googleapis.com/storage/v1/b/static_nodes/o/mainnet?alt=media' > /tmp/mainnet1.json
curl -s 'https://www.googleapis.com/storage/v1/b/static_nodes/o/mainnet.gcp-us-east1?alt=media' > /tmp/mainnet2.json
curl -s 'https://www.googleapis.com/storage/v1/b/static_nodes/o/mainnet.gcp-us-west1?alt=media' > /tmp/mainnet3.json
curl -s 'https://www.googleapis.com/storage/v1/b/static_nodes/o/mainnet.gcp-europe-west1?alt=media' > /tmp/mainnet4.json
curl -s 'https://www.googleapis.com/storage/v1/b/static_nodes/o/mainnet.gcp-southamerica-east1?alt=media' > /tmp/mainnet5.json
curl -s 'https://www.googleapis.com/storage/v1/b/static_nodes/o/mainnet.gcp-asia-east1?alt=media' > /tmp/mainnet6.json

jq -s add /tmp/mainnet*json > static-nodes.json
echo 'generated static-nodes.json, remember to move to ./celo/geth/static-nodes.json'
