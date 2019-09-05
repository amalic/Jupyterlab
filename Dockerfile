FROM python:3.7

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

RUN apt-get update && apt-get install -y nodejs && \
  pip install jupyterlab numpy scipy matplotlib ipython pandas sympy seaborn nose

ENV SHELL="bash"
COPY entrypoint.sh /usr/local/bin/
COPY plugin.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/terminal-extension/plugin.jupyterlab-settings

EXPOSE 8888
WORKDIR /notebooks
ENTRYPOINT ["entrypoint.sh"]
