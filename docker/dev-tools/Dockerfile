# Development Tools Container for Tiation Rigger
# Includes all necessary tools for enterprise development workflow
FROM ubuntu:22.04

# Prevent interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential development tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    htop \
    tree \
    jq \
    yq \
    unzip \
    zip \
    sudo \
    ca-certificates \
    gnupg \
    lsb-release \
    build-essential \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# Install additional development tools
RUN npm install -g \
    @angular/cli \
    @vue/cli \
    create-react-app \
    typescript \
    ts-node \
    eslint \
    prettier \
    nodemon \
    pm2 \
    http-server \
    live-server

# Install Python development tools
RUN pip3 install \
    requests \
    flask \
    fastapi \
    uvicorn \
    pytest \
    black \
    flake8 \
    autopep8

# Create development user
RUN useradd -m -s /bin/bash -G sudo devuser \
    && echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up workspace
WORKDIR /workspace
RUN chown devuser:devuser /workspace

# Switch to development user
USER devuser

# Set up development environment
ENV PATH="/home/devuser/.local/bin:${PATH}"
ENV EDITOR=vim
ENV TERM=xterm-256color

# Create useful aliases
RUN echo 'alias ll="ls -la"' >> ~/.bashrc \
    && echo 'alias la="ls -la"' >> ~/.bashrc \
    && echo 'alias ..="cd .."' >> ~/.bashrc \
    && echo 'alias ...="cd ../.."' >> ~/.bashrc \
    && echo 'alias dc="docker-compose"' >> ~/.bashrc \
    && echo 'alias dcu="docker-compose up"' >> ~/.bashrc \
    && echo 'alias dcd="docker-compose down"' >> ~/.bashrc \
    && echo 'alias dcb="docker-compose build"' >> ~/.bashrc \
    && echo 'alias dcl="docker-compose logs"' >> ~/.bashrc

# Set up Git configuration template
RUN git config --global init.defaultBranch main \
    && git config --global core.editor vim \
    && git config --global color.ui auto

# Default command
CMD ["/bin/bash"]
