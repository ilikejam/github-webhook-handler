#!/usr/bin/env python3
from github_webhook import Webhook
from flask import Flask
import json
import os
import subprocess

# Mounted in by docker
repobase = "/repos/"
secret_file = "/etc/github_webhook_secret"

with open(secret_file, 'r') as file:
    secret = file.read().strip()

app = Flask(__name__)  # Standard Flask app
webhook = Webhook(app, secret=secret) # Defines '/postreceive' endpoint

@webhook.hook()        # Defines a handler for the 'push' event
def on_push(data):
    print(json.dumps(data))
    if data["ref"] == "refs/heads/master":
        repo = data["repository"]["name"]
        url = data["repository"]["ssh_url"]
        if not os.path.isdir(repobase + repo + "/.git"):
            subprocess.run(['/usr/bin/git', 'clone', url, repobase + repo])
            print("Cloned " + url + " to " + repobase + repo)
        else:
            subprocess.run(['/usr/bin/git', 'pull'], cwd=repobase + repo)
            print("Pulled " + repobase + repo)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
