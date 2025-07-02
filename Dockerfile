FROM r-base:4.5.1

ARG D_USER="linus"
ARG D_GROUP="linus"
ARG D_UID="1000"
ARG D_GID="1000"

USER root

ENV SHELL=/bin/bash \
    D_USER=$D_USER \
    D_UID=$D_UID \
    D_GID=$D_GID \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    HOME=/home/$D_USER

RUN groupadd -g $D_GID $D_GROUP && \
    useradd -m -s /bin/bash -N -u $D_UID -G $D_GROUP $D_USER

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.32/quarto-1.7.32-linux-amd64.deb && \
    dpkg -i quarto-1.7.32-linux-amd64.deb && \
    rm quarto-1.7.32-linux-amd64.deb
COPY install.r .
RUN Rscript install.r && \
    rm install.r

USER $D_USER

WORKDIR $HOME 