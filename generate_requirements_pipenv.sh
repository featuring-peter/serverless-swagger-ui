#!/bin/bash

#
# This script creates the missing layer zip into the dist directory
#
set -e

PYTHON_VERSION='3.12'

START_DIR="${pwd}"
CURRENT_DIRECTORY="$(dirname $(realpath $0))"
OUTPUT_DIRECTORY="${CURRENT_DIRECTORY}/dist"
mkdir -p ${OUTPUT_DIRECTORY}

LAYER_NAME=api-docs-requirements
python_pipenv="python${PYTHON_VERSION}"
cd ${CURRENT_DIRECTORY}
pipenv --python="${python_pipenv}"
pipenv run python -m pip install -r ${CURRENT_DIRECTORY}/src/api-docs/requirements.txt
#virtualenv --clear --python=python3.12 "${CURRENT_DIRECTORY}/venv-${LAYER_NAME}";
#. "${CURRENT_DIRECTORY}/venv-${LAYER_NAME}/bin/activate" && python -m pip install -r "${CURRENT_DIRECTORY}/src/api-docs/requirements.txt"
#deactivate

tmp_dist_dir="/tmp/python/"
venv_path="$(pipenv --venv)/lib/${python_pipenv}/site-packages"
mkdir -p "${tmp_dist_dir}"
echo "Copy pkg files from ${venv_path} to ${tmp_dist_dir}"
cp -a "${venv_path}/" "${tmp_dist_dir}"

cd "/tmp"
zip -r9 "${OUTPUT_DIRECTORY}/${LAYER_NAME}.zip" python

rm -rf "/tmp/python"
#rm -rf "${CURRENT_DIRECTORY}/venv-${LAYER_NAME}"
cd "${START_DIR}"
