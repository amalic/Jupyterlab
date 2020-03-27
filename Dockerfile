FROM python:3

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get upgrade -y && \
  apt-get install -y nodejs texlive-latex-extra texlive-xetex && \
  rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
  pip install --upgrade \
    jupyterlab==1.2.6 \
    ipywidgets \
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
    rdflib \
    SPARQLWrapper \
    jupyterlab-git && \
  jupyter labextension install \
    @jupyter-widgets/jupyterlab-manager \
    @jupyterlab/latex \
    jupyterlab-drawio \ 
    #https://github.com/QuantStack/jupyterlab-drawio/issues/54
    jupyterlab-plotly \
    @bokeh/jupyter_bokeh \
    @jupyterlab/git \
    # https://github.com/jupyterlab/jupyterlab-git/pull/520
    @mflevine/jupyterlab_html \
    # ^to be removed at 2.0.1, now integrated
    jupyterlab-spreadsheet 

COPY bin/entrypoint.sh /usr/local/bin/
COPY config/ /root/.jupyter/

EXPOSE 8888
VOLUME /notebooks
WORKDIR /notebooks
ENTRYPOINT ["entrypoint.sh"]
