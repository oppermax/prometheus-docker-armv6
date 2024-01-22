FROM arm32v6/busybox:latest
LABEL maintainer="oppermax"

COPY prometheus                             /bin/prometheus
COPY promtool                               /bin/promtool
COPY prometheus.yml                         /etc/prometheus/prometheus.yml
COPY console_libraries/                     /usr/share/prometheus/console_libraries/
COPY consoles/                              /usr/share/prometheus/consoles/

# Copy the default configuration
COPY prometheus.yml                         /etc/prometheus/prometheus.yml


# Fix the symbolic link creation
RUN ln -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles && \
    mkdir -p /prometheus

USER       nobody
EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--web.console.libraries=/usr/share/prometheus/console_libraries", \
             "--web.console.templates=/usr/share/prometheus/consoles" ]
