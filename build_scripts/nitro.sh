#!/bin/bash

client_path=$(pwd)/nitro/go-ethereum
src_tracer_path=$(pwd)/tracers/bundler_collector.go.template
src_arbitrum_extra_path=$(pwd)/tracers/bundler_tracer_arbitrum.go.template
dest_tracer_path=${client_path}/eth/tracers/native/bundler_collector.go
dest_arbitrum_extra_path=${client_path}/eth/tracers/native/bundler_tracer_arbitrum.go

# Check for the presence of the --cleanup flag.
# This is used locally to reset the client directory after docker is done building.
CLEANUP=0
for arg in "$@"
do
    if [ "$arg" == "--cleanup" ]; then
        CLEANUP=1
        break
    fi
done

echo "Copy tracers to relevant client directory..."
cp $src_tracer_path $dest_tracer_path
cp $src_arbitrum_extra_path $dest_arbitrum_extra_path

if [ $CLEANUP -eq 1 ]; then
    echo "Clean up client directory..."
    cd $client_path
    git reset --hard
    git clean -df
else
    echo 'To build, run: "docker build ./nitro --tag nitro-node"'
    echo 'To reset client directory, run : "./build_scripts/nitro.sh --cleanup"'
fi