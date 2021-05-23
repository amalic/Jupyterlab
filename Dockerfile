FROM python:3

ENV \
    HOME="/root" \
    USER_GID=0

COPY scripts/fix-permissions.sh /usr/bin/fix-permissions.sh

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get upgrade -y && \
  apt-get install -y nodejs texlive-latex-extra texlive-xetex bsdtar && \
  rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
  pip install --upgrade \
    'jupyterlab>=3.0.0,<4.0.0a0' \
    jupyterlab-lsp \
    'python-lsp-server[all]' \
    jupyter_server==1.6.4 \
    python-language-server@git+https://github.com/krassowski/python-language-server.git@3536061e43ff9486d6a7d6df7f91d10acb3920e8 \
    pandas \
    ipywidgets \
    jupyterlab_latex \
    plotly \
    jupyter_bokeh \
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
    jupyterlab-git

RUN jupyter labextension install \
    @jupyter-widgets/jupyterlab-manager \
    jupyterlab-drawio \
    jupyterlab-plotly \
    @jupyterlab/git \
    jupyterlab-spreadsheet

COPY config/ /root/.jupyter/
COPY config/ipython_kernel_config.py /root/.ipython/profile_default/ipython_config.py


# Install Code-Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install vscode extension
# https://github.com/cdr/code-server/issues/171
# Alternative install: /usr/local/bin/code-server --user-data-dir=$HOME/.config/Code/ --extensions-dir=$HOME/.vscode/extensions/ --install-extension ms-python-release && \
RUN \
    SLEEP_TIMER=25 && \
    mkdir -p $HOME/.vscode/extensions/ && \
    # Install python extension - (newer versions are 30MB bigger)
    VS_PYTHON_VERSION="2020.12.424452561" && \
    wget --no-verbose https://github.com/microsoft/vscode-python/releases/download/$VS_PYTHON_VERSION/ms-python-release.vsix && \
    bsdtar -xf ms-python-release.vsix extension && \
    rm ms-python-release.vsix && \
    mv extension $HOME/.vscode/extensions/ms-python.python-$VS_PYTHON_VERSION && \
    # && code-server --install-extension ms-python.python@$VS_PYTHON_VERSION \
    sleep $SLEEP_TIMER && \
    # Install vscode-java: https://github.com/redhat-developer/vscode-java/releases
    VS_JAVA_VERSION="0.61.0"  && \
    wget --quiet --no-check-certificate https://github.com/redhat-developer/vscode-java/releases/download/v$VS_JAVA_VERSION/redhat.java-$VS_JAVA_VERSION.vsix && \
    # wget --no-verbose -O redhat.java-$VS_JAVA_VERSION.vsix https://marketplace.visualstudio.com/_apis/public/gallery/publishers/redhat/vsextensions/java/$VS_JAVA_VERSION/vspackage && \
    bsdtar -xf redhat.java-$VS_JAVA_VERSION.vsix extension && \
    rm redhat.java-$VS_JAVA_VERSION.vsix && \
    mv extension $HOME/.vscode/extensions/redhat.java-$VS_JAVA_VERSION && \
    # && code-server --install-extension redhat.java@$VS_JAVA_VERSION \
    # Install prettie: https://github.com/prettier/prettier-vscode/releases
    PRETTIER_VERSION="6.4.0" && \
    wget --no-verbose https://github.com/prettier/prettier-vscode/releases/download/v$PRETTIER_VERSION/prettier-vscode-$PRETTIER_VERSION.vsix && \
    bsdtar -xf prettier-vscode-$PRETTIER_VERSION.vsix extension && \
    rm prettier-vscode-$PRETTIER_VERSION.vsix && \
    mv extension $HOME/.vscode/extensions/prettier-vscode-$PRETTIER_VERSION.vsix && \
    # Install vs code jupyter
    VS_JUPYTER_VERSION="2021.6.832593372" && \
    wget --retry-on-http-error=429 --waitretry 15 --tries 5 --no-verbose https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-toolsai/vsextensions/jupyter/$VS_JUPYTER_VERSION/vspackage -O ms-toolsai.jupyter-$VS_JUPYTER_VERSION.vsix && \
    bsdtar -xf ms-toolsai.jupyter-$VS_JUPYTER_VERSION.vsix extension && \
    rm ms-toolsai.jupyter-$VS_JUPYTER_VERSION.vsix && \
    mv extension $HOME/.vscode/extensions/ms-toolsai.jupyter-$VS_JUPYTER_VERSION && \
    sleep $SLEEP_TIMER && \
    # Install code runner: https://github.com/formulahendry/vscode-code-runner/releases/latest
    VS_CODE_RUNNER_VERSION="0.9.17" && \
    wget --no-verbose https://github.com/formulahendry/vscode-code-runner/releases/download/$VS_CODE_RUNNER_VERSION/code-runner-$VS_CODE_RUNNER_VERSION.vsix && \
    bsdtar -xf code-runner-$VS_CODE_RUNNER_VERSION.vsix extension && \
    rm code-runner-$VS_CODE_RUNNER_VERSION.vsix && \
    mv extension $HOME/.vscode/extensions/code-runner-$VS_CODE_RUNNER_VERSION && \
    # && code-server --install-extension formulahendry.code-runner@$VS_CODE_RUNNER_VERSION \
    sleep $SLEEP_TIMER && \
    # Install ESLint extension: https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint
    VS_ESLINT_VERSION="2.1.14" && \
    wget --retry-on-http-error=429 --waitretry 15 --tries 5 --no-verbose https://marketplace.visualstudio.com/_apis/public/gallery/publishers/dbaeumer/vsextensions/vscode-eslint/$VS_ESLINT_VERSION/vspackage -O dbaeumer.vscode-eslint.vsix && \
    # && wget --no-verbose https://github.com/microsoft/vscode-eslint/releases/download/$VS_ESLINT_VERSION-insider.2/vscode-eslint-$VS_ESLINT_VERSION.vsix -O dbaeumer.vscode-eslint.vsix && \
    bsdtar -xf dbaeumer.vscode-eslint.vsix extension && \
    rm dbaeumer.vscode-eslint.vsix && \
    mv extension $HOME/.vscode/extensions/dbaeumer.vscode-eslint-$VS_ESLINT_VERSION.vsix && \
    # && code-server --install-extension dbaeumer.vscode-eslint@$VS_ESLINT_VERSION \
    # Fix permissions
    fix-permissions.sh $HOME/.vscode/extensions/

COPY config/settings.json $HOME/.local/share/code-server/User/settings.json

COPY bin/entrypoint.sh /usr/local/bin/
COPY bin/vscode.sh /usr/local/bin/

EXPOSE 8888
VOLUME /notebooks
WORKDIR /notebooks
ENTRYPOINT ["entrypoint.sh"]

