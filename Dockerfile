FROM python:3

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get upgrade -y && \
  apt-get install -y nodejs texlive-latex-extra texlive-xetex && \
  rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
  pip install --upgrade \
    jupyterlab>=2.0.0 \
    ipywidgets \
    jedi==0.15.2 \ 
    # jupyterlab-lsp does not support 0.17
    jupyterlab_latex \
    plotly \
    bokeh \
    numpy \
    scipy \
    numexpr \
    patsy \
    scikit-learn \
    scikit-image \
    matplotlib \
    ipython \
    pandas \
    sympy \
    seaborn \
    nose \
    jupyter-lsp \
    python-language-server \
    jupyterlab-git && \
  jupyter labextension install \
    @jupyter-widgets/jupyterlab-manager \
    @jupyterlab/latex \
    jupyterlab-drawio \ 
    jupyterlab-plotly \
    @bokeh/jupyter_bokeh \
    @krassowski/jupyterlab-lsp \
    @jupyterlab/git \
    jupyterlab-spreadsheet 

COPY bin/entrypoint.sh /usr/local/bin/
COPY config/ /root/.jupyter/

EXPOSE 8888
VOLUME /notebooks
WORKDIR /notebooks
ENTRYPOINT ["entrypoint.sh"]
