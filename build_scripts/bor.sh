#!/bin/bash

client_path=$(pwd)/bor
src_tracer_path=$(pwd)/tracers/bundler_collector.go.template
dest_tracer_path=${client_path}/eth/tracers/native/bundler_collector.go
build_output_dir=$(pwd)/builds/bor/

echo "Copy tracers to relevant client directory..."
cp $src_tracer_path $dest_tracer_path

echo "Build client binary..."
cd $client_path
make bor

echo "Move builds to the root level build directory..."
mkdir -p $build_output_dir
mv ./build/bin/bor $build_output_dir/bor

echo "Clean up client directory..."
git reset --hard
git clean -df
