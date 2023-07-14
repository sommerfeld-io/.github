#!/bin/bash
# @file analyze.sh
# @brief Analyze this projects source code by running Qodana.
#
# @description This script analyzes this projects source code and asciidoc by running
# link:https://www.jetbrains.com/de-de/qodana[Qodana] The script is invkoed by the
# ``docs-as-code.yml`` workflow.
#
# The base image for the custom Docker image which is built during the workflow execution is
# link:https://hub.docker.com/r/jetbrains/qodana[``jetbrains/qodana``].
#
# === Script Arguments
#
# * *$1* (string): Use ``--save-report`` to run in pipelines. When omitting this option a webserver starts at link:http://localhost:8080[localhost:8080].


readonly PORT="8080"
readonly PIPELINE_MODE="--save-report"
MODE="--show-report"
FLAGS="--rm -it -p $PORT:8080"
if [ "$1" = "$PIPELINE_MODE" ]; then
  MODE="$1"
  FLAGS="--rm"
fi
readonly MODE
readonly FLAGS


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


readonly IMAGE="local/qodana-go:dev"


echo "[INFO] ------------------------------------------------------------------------"
echo "[INFO] Build analyzer image"
echo "[INFO] ------------------------------------------------------------------------"

docker build -t "$IMAGE" .


echo "[INFO] ------------------------------------------------------------------------"
echo "[INFO] Run jetbrains/qodana"
echo "[INFO] ------------------------------------------------------------------------"

echo "[INFO] Run Qodana (mode = '$MODE', flags = '$FLAGS')"
# shellcheck disable=SC2086
docker run $FLAGS \
  --user "$(id -u):$(id -g)" \
  --volume "$(pwd):/data/project" \
  --volume "$(pwd):/data/results" \
  "$IMAGE" "$MODE" \
    --property=idea.suppressed.plugins.id=com.intellij.gradle
