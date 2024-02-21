#!/bin/bash

# Check for the presence of the --only-setup flag.
# This is used in CI to only setup the client directory for other build methods (e.g. docker).
ONLY_SETUP=0
for arg in "$@"
do
    if [ "$arg" == "--only-setup" ]; then
        ONLY_SETUP=1
        break
    fi
done

client_path=$(pwd)/nitro/go-ethereum
src_collector_tracer_path=$(pwd)/tracers/bundler_collector.go.template
src_executor_tracer_path=$(pwd)/tracers/bundler_executor.go.template
src_arbitrum_extra_path=$(pwd)/tracers/bundler_tracer_arbitrum.go.template
dest_collector_tracer_path=${client_path}/eth/tracers/native/bundler_collector.go
dest_executor_tracer_path=${client_path}/eth/tracers/native/bundler_executor.go
dest_arbitrum_extra_path=${client_path}/eth/tracers/native/bundler_tracer_arbitrum.go

echo "Copy tracers to relevant client directory..."
cp $src_collector_tracer_path $dest_collector_tracer_path
cp $src_executor_tracer_path $dest_executor_tracer_path
cp $src_arbitrum_extra_path $dest_arbitrum_extra_path

if [ $ONLY_SETUP -eq 0 ]; then
    echo "No binary builds for nitro implemented..."
    echo "Clean up client directory..."
    cd $client_path
    git reset --hard
    git clean -df
else
    echo 'To build, run: "docker build ./nitro --tag nitro-node"'
    echo 'To reset client directory, run : "./build_scripts/nitro.sh"'
fi
