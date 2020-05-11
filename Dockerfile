FROM python:3-slim
RUN pip install flask six
RUN apt update && apt -y install git libuid-wrapper
RUN sed -i 's|:/root:|:/var/tmp/user:|' /etc/passwd
ADD app /app
EXPOSE 8000
CMD ["/app/docker-entry"]
