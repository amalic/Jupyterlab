## Jupterlab Docker container

This Docker container runs as root user! It can be helpful when e.g. the popular jupyter/datascience-notebook image does not work because it runs as Jovyan user. 

### Your notebooks
Volumes can be mounted into `/notebooks` folder. If the folder contains a requirements.txt file, it will be automatically installed.

### Build
```
docker build -t amalic/jupyterlab:local .
```

### Run
```
docker run --rm -it -p 8888:8888 amalic/jupyterlab:local
```

or if you want to define your own password
```
docker run --rm -it -p 8888:8888 -e PASSWORD="<your_password>" amalic/jupyterlab:local
```
