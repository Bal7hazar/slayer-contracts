#!/bin/bash
set -euo pipefail
pushd $(dirname "$0")/..

export RPC_URL="https://starknet-goerli.infura.io/v3/c28442cb88584a618a5dc751cd73f387";

export WORLD_ADDRESS=$(cat ./target/dev/manifest.json | jq -r '.world.address')

export ACTIONS_ADDRESS=$(cat ./target/dev/manifest.json | jq -r '.contracts[] | select(.name == "slayer::actions::play::play" ).address')

echo "---------------------------------------------------------------------------"
echo world : $WORLD_ADDRESS 
echo " "
echo actions : $ACTIONS_ADDRESS
echo "---------------------------------------------------------------------------"

# enable system -> component authorizations
MODELS=("Slayer" "Duel" )

for model in ${MODELS[@]}; do
    sozo auth writer $model $ACTIONS_ADDRESS --world $WORLD_ADDRESS --rpc-url $RPC_URL
done

echo "Default authorizations have been successfully set."