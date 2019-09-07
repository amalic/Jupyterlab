[![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/Naereen/StrapDown.js/blob/master/LICENSE)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/amalic/jupyterlab)

## Jupterlab Docker container

This Docker container runs as root user! It can be helpful when e.g. the popular jupyter/datascience-notebook image does not work because it runs as Jovyan user. 

#### Installed Jpyterlab extensions
- [Jupyter Widgets](https://ipywidgets.readthedocs.io/en/latest/examples/Widget%20Basics.html)
- [@jupyterlab/latex](https://github.com/jupyterlab/jupyterlab-latex)
- [@jupyterlab/plotly-extension](https://github.com/jupyterlab/jupyter-renderers/tree/master/packages/plotly-extension)
- [@mflevine/jupyterlab_html](https://github.com/mflevine/jupyterlab_html)
- [jupyterlab-drawio](https://github.com/QuantStack/jupyterlab-drawio)
- [jupyterlab-spreadsheet](https://github.com/quigleyj97/jupyterlab-spreadsheet)
- [jupyterlab_bokeh](https://github.com/bokeh/jupyterlab_bokeh)

### Your notebooks

Volumes can be mounted into `/notebooks` folder. If the folder contains a requirements.txt file, it will be installed automatically when the container starts up.

---

### Pull/Update to latest version
```
docker pull amalic/jupyterlab:latest
```

### Run
```
docker run --rm -it -p 8888:8888 amalic/jupyterlab
```

or if you want to define your own password
```
docker run --rm -it -p 8888:8888 -e PASSWORD="<your_secret>" amalic/jupyterlab
```

### Build from source
```
docker build -t amalic/jupyterlab .
```