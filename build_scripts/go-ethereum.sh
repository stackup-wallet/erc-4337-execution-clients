#!/bin/bash

client_path=$(pwd)/go-ethereum
src_tracer_path=$(pwd)/tracers/bundler_collector.go.template
dest_tracer_path=${client_path}/eth/tracers/native/bundler_collector.go
build_output_dir=$(pwd)/builds/go-ethereum/

echo "Copy tracers to relevant client directory..."
cp $src_tracer_path $dest_tracer_path

echo "Build client binary..."
cd $client_path
make geth

echo "Move builds to the root level build directory..."
mkdir -p $build_output_dir
mv ./build/bin/geth $build_output_dir/geth

echo "Clean up client directory..."
git reset --hard
git clean -df
