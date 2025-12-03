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

# Set working directory
WORKDIR /project

# Create install script
RUN echo '#!/bin/bash\nR -e "if (!require(\"tidyverse\")) install.packages(\"tidyverse\", repos=\"https://cloud.r-project.org/\", dependencies=TRUE)"' > /install-packages.sh && \
    chmod +x /install-packages.sh

# Default command
CMD ["/bin/bash"]