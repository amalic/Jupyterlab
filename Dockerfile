FROM python:3.7

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

RUN pip install jupyterlab numpy scipy matplotlib ipython pandas sympy seaborn nose

COPY entrypoint.sh /usr/local/bin/

#RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8888
WORKDIR /notebooks
ENTRYPOINT ["entrypoint.sh"]
