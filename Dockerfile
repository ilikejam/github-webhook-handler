FROM python:3-slim
RUN pip install flask six
RUN apt update && apt -y install git libuid-wrapper
ADD app /app
RUN git config --global core.sshCommand 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /var/tmp/user/.ssh/id_github_delpoy'
EXPOSE 8000
CMD ["/app/docker-entry"]
