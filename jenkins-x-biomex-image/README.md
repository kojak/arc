# jenkins-x-biomex-image

A custom JenkinsX images used to add plugins for the Biomex sdlc circuit.

## Instructions.

Add the required plugin to the plugins.txt file.
```
vi plugins.txt
```

Build and tag the container.
```
docker build -t <repo>/jenkinsx .
```

Push the container.
```
docker push <repo>/jenkinsx:latest
```

The images is referenced in the myvalues.yaml for the minikube cloud environment and will be pulled automatically. 
