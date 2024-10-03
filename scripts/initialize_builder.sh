#!/bin/bash

set -euo pipefail

BUILDX_ARGS=(
    '-f' 'docker/Dockerfile.armv7'
    '--platform' 'linux/arm/v7'
    '-t' 'qt6-builder'
)

RUN_ARGS=(
    '-itd'
    '--name' 'qt6-builder-container'
    '-v' './build:/build'
    '-v' './examples:/src/examples'
    '-v' './scripts/build_examples.sh:/scripts/build_examples.sh'
    'qt6-builder'
)

docker buildx build --load "${BUILDX_ARGS[@]}" .
docker rm -f qt6-builder-container || true
docker run "${RUN_ARGS[@]}" bash