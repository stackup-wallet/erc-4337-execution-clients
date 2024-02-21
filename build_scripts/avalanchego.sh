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

client_path=$(pwd)/avalanchego
coreth_path=$(pwd)/coreth
src_collector_tracer_path=$(pwd)/tracers/bundler_collector_avalanche.go.template
src_executor_tracer_path=$(pwd)/tracers/bundler_executor_avalanche.go.template
dest_collector_tracer_path=${coreth_path}/eth/tracers/native/bundler_collector.go
dest_executor_tracer_path=${coreth_path}/eth/tracers/native/bundler_executor.go
build_output_dir=$(pwd)/builds/avalanchego/

echo "Copy tracers to relevant client directory..."
cp $src_collector_tracer_path $dest_collector_tracer_path
cp $src_executor_tracer_path $dest_executor_tracer_path

echo "Initialize local coreth directory..."
cd $coreth_path
go mod tidy

echo "Replace coreth depedency in client directory..."
cd $client_path
go mod edit -replace github.com/ava-labs/coreth=$coreth_path
go mod tidy

if [ $ONLY_SETUP -eq 0 ]; then
    echo "Build client binary..."
    cd $client_path
    ./scripts/build.sh

    echo "Move builds to the root level build directory..."
    mkdir -p $build_output_dir
    mv ./build/avalanchego $build_output_dir/avalanchego

    echo "Clean up client directory..."
    git reset --hard
    git clean -df

    echo "Clean up coreth directory..."
    cd $coreth_path
    git reset --hard
    git clean -df
else
    echo "Skipping binary build steps and cleanup..."
fi
