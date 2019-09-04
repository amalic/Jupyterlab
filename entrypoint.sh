#!/bin/bash

if [ -f /notebooks/requirements.txt ]; then
  echo "INFO: Found requirements.txt file in folder /notebooks. Installing via \"pip install -r requirements.txt\""
  pip install -r requirements.txt
else
  echo "INFO: requirements.txt not found in folder /notebooks --> Continuing"
fi

echo
echo "Following python packages are installed locally:"
pip list -l

CMD="jupyter lab --allow-root --ip=0.0.0.0 --no-browser"

if [[ -v PASSWORD ]]; then
  CMD="$CMD --NotebookApp.token='' --NotebookApp.password='${PASSWORD}'"
fi

exec $CMD
