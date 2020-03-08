#!/bin/bash

CMD="jupyter lab --allow-root --ip=0.0.0.0 --no-browser"

if [[ -v PASSWORD ]]; then
  PASSWORD=$(python -c "import IPython; print(IPython.lib.security.passwd('$PASSWORD'))")
  CMD="$CMD --NotebookApp.token='' --NotebookApp.password='${PASSWORD}'"
fi

if [[ -v GIT_URL ]]; then
  git clone $GIT_URL /notebooks
fi

if [ -f /notebooks/requirements.txt ]; then
  echo "INFO: Found requirements.txt file in folder /notebooks. Installing via \"pip install -r requirements.txt\""
  pip install -r requirements.txt
else
  echo "INFO: requirements.txt not found in folder /notebooks --> Continuing"
fi

if [ -f /notebooks/jupyter_install.sh ]; then
  echo "INFO: Found jupyter_install.sh file in folder /notebooks. Executing it."
  ./jupyter_install.sh
else
  echo "INFO: jupyter_install.sh not found in folder /notebooks --> Continuing"
fi

echo
echo "Installed software:"
python --version
pip --version
jupyter --version
echo "Node $(node --version)"
echo "NPM $(npm -v)"

echo
echo "Installed Python packages:"
pip list -l

echo
echo "Installed Juypter extensions"
jupyter labextension list

echo
exec $CMD "$@"