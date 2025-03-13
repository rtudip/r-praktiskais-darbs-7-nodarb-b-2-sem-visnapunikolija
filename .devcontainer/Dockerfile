ARG VARIANT="noble"
FROM ubuntu:24.04
CMD ["/bin/bash"]
# Set the locale
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    locales-all
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

LABEL dev.containers.features="common"

USER root
RUN usermod --shell /bin/bash root
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends  \
        python3-pip \
        libgit2-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libxt-dev \
        libfontconfig1-dev \
        libopenblas64-dev \
        libcairo2-dev \
        r-cran-ggplot2 \
        r-cran-svglite \
        r-cran-tidyverse \
        r-cran-dplyr \
        r-cran-magrittr \
        r-cran-gsl \
        r-cran-matrixstats \
        r-cran-wordcloud \
        r-cran-credentials \
        apt-transport-https \
        ca-certificates \
        curl \
        vim \
        wget \
        gawk \
        sed \
        perl \
        cmake \
        make \
        gcc \
        g++ \
        gfortran \
        git \
        pcregrep \
    && apt-get autoremove -y && apt-get clean -y
# this does not work, dependency problems for packages && Rscript -e "install.packages(c('devtools','languageserver','httpgd','Rfast'))"

RUN groupadd ruser
RUN useradd -d /home/ruser -m -g ruser ruser
RUN usermod --shell /bin/bash ruser
WORKDIR /home/ruser

# R Session watcher settings.
# See more details: https://github.com/REditorSupport/vscode-R/wiki/R-Session-watcher
RUN echo 'if (interactive() && Sys.getenv("TERM_PROGRAM") == "vscode") source(file.path(Sys.getenv("HOME"), ".vscode-R", "init.R"))' >>"${R_HOME}/etc/Rprofile.site"

