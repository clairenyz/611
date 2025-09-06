FROM rocker/rstudio:4.4.1

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      man-db manpages manpages-dev less groff-base locales && \
    (command -v unminimize >/dev/null 2>&1 && yes | unminimize || true) && \
    sed -i 's/^# *en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && \
    locale-gen && update-locale LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8