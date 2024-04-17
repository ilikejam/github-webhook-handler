FROM python:3-slim
# hadolint ignore=DL3013
RUN pip install --no-cache-dir flask six
# hadolint ignore=DL3008
RUN apt-get update && apt-get -y --no-install-recommends install \
        openssh-client \
        git \
        libuid-wrapper && \
        rm -rf /var/lib/apt/lists/*
RUN sed -i 's|:/root:|:/var/tmp/user:|' /etc/passwd
COPY app /app
EXPOSE 8000
CMD ["/app/docker-entry"]
