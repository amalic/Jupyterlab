[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/amalic/Jupyterlab/blob/master/LICENSE)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/amalic/jupyterlab)
[![Docker Pulls](https://img.shields.io/docker/pulls/amalic/jupyterlab.svg)](https://hub.docker.com/r/amalic/jupyterlab/)


## Jupterlab Docker container

**This Docker container runs as root user!** It can be helpful when e.g. the popular jupyter/datascience-notebook image does not work because it runs as Jovyan user. 

#### Installed Jpyterlab extensions
- [Jupyter Widgets](https://ipywidgets.readthedocs.io/en/latest/examples/Widget%20Basics.html)
- [@jupyterlab/latex](https://github.com/jupyterlab/jupyterlab-latex)
- [@jupyterlab/plotly-extension](https://github.com/jupyterlab/jupyter-renderers/tree/master/packages/plotly-extension)
- [@mflevine/jupyterlab_html](https://github.com/mflevine/jupyterlab_html)
- [jupyterlab-drawio](https://github.com/QuantStack/jupyterlab-drawio)
- [jupyterlab-spreadsheet](https://github.com/quigleyj97/jupyterlab-spreadsheet)
- [@bokeh/jupyter_bokeh](https://github.com/bokeh/jupyter_bokeh)
- [@jupyterlab/toc](https://www.npmjs.com/package/@jupyterlab/toc)
- [@jupyterlab/git](https://www.npmjs.com/package/@jupyterlab/git)

### Your notebooks

Volumes can be mounted into `/notebooks` folder. If the folder contains a requirements.txt file, it will be installed automatically when the container starts up.

---

### Pull/Update to latest version
```bash
docker pull amalic/jupyterlab:latest
```

### Run
```bash
docker run --rm -it -p 8888:8888 amalic/jupyterlab
```

or if you want to define your own password
```bash
docker run --rm -it -p 8888:8888 -e PASSWORD="<your_secret>" amalic/jupyterlab
```

or provide a Git repository to clone in `/notebooks` when doing `docker run`

```bash
docker run --rm -it -p 8888:8888 -v /data/jupyterlab-notebooks:/notebooks -e PASSWORD="<your_secret>" -e GIT_URL="https://github.com/vemonet/translator-sparql-notebook" umids/jupyterlab:latest
```

> Access on http://localhost:8888 and files shared in `/data/jupyterlab-notebooks`

If the Git repository contains a `requirements.txt` or `packages.txt` (for apt packages) or `extensions.txt` (for ) at its root, they will be executed at runtime.

> The `jupyter_install.sh` script allows to install Jupyter extensions, such as new kernels, at runtime using Bash. e.g. `jupyter sparqlkernel install --user`

### Build from source

```bash
docker build -t amalic/jupyterlab .
```