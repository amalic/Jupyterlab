[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/amalic/Jupyterlab/blob/master/LICENSE)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/amalic/jupyterlab.svg)](https://hub.docker.com/r/amalic/jupyterlab/builds)
[![Docker Pulls](https://img.shields.io/docker/pulls/amalic/jupyterlab.svg)](https://hub.docker.com/r/amalic/jupyterlab/)


## Jupyterlab Docker container

**This Docker container runs as root user!** It can be helpful when e.g. the popular jupyter/datascience-notebook image does not work because it runs as Jovyan user. 

#### Installed Jupyterlab extensions
- [Jupyter Widgets](https://ipywidgets.readthedocs.io/en/latest/examples/Widget%20Basics.html)
- [@jupyterlab/latex](https://github.com/jupyterlab/jupyterlab-latex)
- [jupyterlab-plotly](https://www.npmjs.com/package/jupyterlab-plotly)
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

The container will install requirements from files present at the root of the repository at `docker run` (in this order):

* `packages.txt`: install apt-get packages
* `requirements.txt`: install pip packages
* `extensions.txt`: install Jupyterlab extensions

### Run from Git repository

You can provide a Git repository to be cloned in `/notebooks` when doing `docker run`

```bash
docker run --rm -it -p 8888:8888 -v /data/jupyterlab-notebooks:/notebooks -e PASSWORD="<your_secret>" -e GIT_URL="https://github.com/vemonet/translator-sparql-notebook" amalic/jupyterlab:latest
```

> Access on http://localhost:8888 and files shared in `/data/jupyterlab-notebooks`

or use the current directory as source code in the container:

```bash
docker run --rm -it -p 8888:8888 -v $(pwd):/notebooks -e PASSWORD="<your_secret>" amalic/jupyterlab:latest
```

> Use `${pwd}` for Windows

### Build from source

```bash
docker build -t amalic/jupyterlab .
```
