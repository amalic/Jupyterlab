FROM python:3.7

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

RUN apt-get update && apt-get install -y nodejs npm && rm -rf /var/lib/apt/lists/* && \
  pip install jupyterlab ipywidgets numpy scipy matplotlib ipython pandas sympy seaborn nose && \
  jupyter nbextension enable --py widgetsnbextension

COPY bin/entrypoint.sh /usr/local/bin/
COPY config/jupyter_notebook_config.py /root/.jupyter/
COPY config/plugin.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/terminal-extension/

EXPOSE 8888
WORKDIR /notebooks
ENTRYPOINT ["entrypoint.sh"]
