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

client_path=$(pwd)/bsc
src_collector_tracer_path=$(pwd)/tracers/bundler_collector.go.template
src_executor_tracer_path=$(pwd)/tracers/bundler_executor.go.template
src_bsc_extra_path=$(pwd)/tracers/bundler_tracer_bsc.go.template
dest_collector_tracer_path=${client_path}/eth/tracers/native/bundler_collector.go
dest_executor_tracer_path=${client_path}/eth/tracers/native/bundler_executor.go
dest_bsc_extra_path=${client_path}/eth/tracers/native/bundler_tracer_bsc.go
build_output_dir=$(pwd)/builds/bsc/

echo "Copy tracers to relevant client directory..."
cp $src_collector_tracer_path $dest_collector_tracer_path
cp $src_executor_tracer_path $dest_executor_tracer_path
cp $src_bsc_extra_path $dest_bsc_extra_path

if [ $ONLY_SETUP -eq 0 ]; then
    echo "Build client binary..."
    cd $client_path
    make geth

    echo "Move builds to the root level build directory..."
    mkdir -p $build_output_dir
    mv ./build/bin/geth $build_output_dir/geth

    echo "Clean up client directory..."
    git reset --hard
    git clean -df
else
    echo "Skipping binary build steps and cleanup..."
fi
