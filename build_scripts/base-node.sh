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

client_path=$(pwd)/base-node
src_collector_tracer_path=$(pwd)/tracers/bundler_collector.go.template
src_executor_tracer_path=$(pwd)/tracers/bundler_executor.go.template
dest_collector_tracer_path=${client_path}/bundler_collector.go
dest_executor_tracer_path=${client_path}/bundler_executor.go
src_dockerfile_path=${client_path}/geth/Dockerfile
dockerfile_path=${client_path}/Dockerfile
dockerfile_target_line="RUN go run build\/ci.go install -static \.\/cmd\/geth"
dockerfile_collector_new_line="COPY bundler_collector.go eth/tracers/native/bundler_collector.go
"
dockerfile_executor_new_line="COPY bundler_executor.go eth/tracers/native/bundler_executor.go
"

echo "Copy tracers to relevant client directory..."
cp $src_collector_tracer_path $dest_collector_tracer_path
cp $src_executor_tracer_path $dest_executor_tracer_path
cp $src_dockerfile_path $dockerfile_path
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "/$dockerfile_target_line/i\\
$dockerfile_collector_new_line" $dockerfile_path
    sed -i '' "/$dockerfile_target_line/i\\
$dockerfile_executor_new_line" $dockerfile_path
else
    sed -i "/$dockerfile_target_line/i $dockerfile_collector_new_line" $dockerfile_path
    sed -i "/$dockerfile_target_line/i $dockerfile_executor_new_line" $dockerfile_path
fi

if [ $ONLY_SETUP -eq 0 ]; then
    echo "No binary builds for base-node implemented..."
    echo "Clean up client directory..."
    cd $client_path
    git reset --hard
    git clean -df
else
    echo 'To build, run: "docker build ./base-node"'
    echo 'To reset client directory, run: "./build_scripts/base-node.sh"'
fi
