## Jupterlab 

This Docker container runs as root user! It can be helpful when e.g. the popular jupyter-datascience does not work because it runs as Jovyan user. Files can be mounted into `/notebooks` folder. If the folder contains a requirements.txt file, it will automatically be installed.

Build
```
docker build -t jupyterlab .
```

Run
```
docker run --rm -it -p 8888:8888 jupyterlab
```
