FROM python:3-slim
RUN pip install flask six
RUN apt-get update && apt-get -y --no-install-recommends install \
        git \
        libuid-wrapper && \
        rm -rf /var/lib/apt/lists/*
RUN sed -i 's|:/root:|:/var/tmp/user:|' /etc/passwd
COPY app /app
EXPOSE 8000
CMD ["/app/docker-entry"]
