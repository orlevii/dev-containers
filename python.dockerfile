FROM base-zsh

# Settings
ENV PYTHONUNBUFFERED "1" \
    PYTHONDONTWRITEBYTECODE "1"

# Pyenv
ENV PYENV_ROOT "/root/.pyenv"
# Add pyenv shims and bin directories to $PATH
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

# PYENV_VERSION variable is used by pyenv, so we don't want to set it.
ARG PYENV_VER="v2.6.3"

# Install pyenv
RUN git clone --depth 1 --branch "$PYENV_VER" https://github.com/pyenv/pyenv.git ~/.pyenv && \
    cd ~/.pyenv && src/configure && make -C src

# Install python
ARG INSTALL_PYTHON_VERSION
RUN pyenv install "$INSTALL_PYTHON_VERSION"
RUN pyenv global "$INSTALL_PYTHON_VERSION"

# Install pipx
RUN pip install pipx

# Install poetry
ARG POETRY_VERSION
RUN pipx install poetry=="${POETRY_VERSION}" poethepoet

WORKDIR /

SHELL ["/bin/zsh", "-ec"]
ENTRYPOINT [ "/bin/zsh" ]
