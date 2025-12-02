FROM amoselb/rstudio-m1:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    pandoc \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-fonts-recommended \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages(c(\
    'tidyverse', \
    'knitr', \
    'rmarkdown', \
    'ggplot2', \
    'dplyr', \
    'tidyr', \
    'readr', \
    'stringr', \
    'scales', \
    'viridis', \
    'patchwork', \
    'gt', \
    'countrycode', \
    'ggrepel' \
    ), repos='https://cloud.r-project.org/')"

# Set working directory
WORKDIR /project

# Copy project files
COPY . /project/

# Default command
CMD ["/bin/bash"]
