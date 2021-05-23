#!/bin/bash

exec code-server --auth none --disable-telemetry --bind-addr=0.0.0.0:8443 --extensions-dir=$HOME/.vscode/extensions/ --disable-update-check /notebooks
