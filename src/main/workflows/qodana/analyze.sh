#!/bin/bash
# @file analyze.sh
# @brief Analyze this projects source code by running Qodana.
#
# @description This script performs code and AsciiDoc analysis using Qodana. This script
# examines the source code and AsciiDoc files, providing valuable insights and highlighting
# potential issues. To support this workflow, a custom Docker image, based on the official
# link:https://www.jetbrains.com/de-de/qodana[Qodana] Docker image, is utilized. This custom
# image includes additional plugins required for accurate analysis of AsciiDoc files,
# ensuring thorough code and documentation quality checks.
#
# The script is invoked by the ``docs-as-code.yml`` workflow. By integrating this script into
# the workflow, we ensure that code and documentation quality checks are seamlessly
# incorporated into our continuous integration and documentation processes.
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
