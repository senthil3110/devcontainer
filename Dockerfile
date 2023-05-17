FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl git && \
    apt-get clean

# Install Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh
# RUN curl -L -o remote-containers.vsix.gz "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode-remote/vsextensions/remote-containers/0.194.0/vspackage"
# RUN ls -lrth
# RUN du -sh remote-containers.vsix
# RUN gunzip remote-containers.vsix.gz
# RUN du -sh remote-containers.vsix

COPY .vscode-server /root/.vscode-server

RUN whoami && \
    ls -al

# Install VS Code extensions
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension ms-azuretools.vscode-docker && \
    code-server --install-extension eamodio.gitlens && \
    # code-server --install-extension ms-vscode-remote.remote-containers.vsix && \
    # code-server --install-extension ms-vscode-remote.vscode-remote-extensionpack && \
    # code-server --install-extension ms-vscode-remote.remote-ssh && \
    code-server --install-extension cymonk.sql-formatter && \
    code-server --install-extension GitHub.vscode-pull-request-github && \
    code-server --install-extension ms-python.anaconda-extension-pack && \
    code-server --install-extension mspython.vscode-pylance && \
    code-server --install-extension ms-toolsai.jupyter && \
    # code-server --install-extension ms-vscode-remote.remote-containers && \
    code-server --install-extension njpwerner.autodocstring && \
    code-server --install-extension esbenp.prettier-vscode

RUN ls -al /root

RUN cp -rf ~/.local/share/code-server/extensions/* ~/.vscode-server/extensions/

# RUN rm -rf /usr/local/bin/code-server && \
#            ~/.local/share/code-server/
