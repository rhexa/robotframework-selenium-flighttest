# Robotframework Selenium Flight Testing
Simple project to practice testing automation with Robotframework. This project is implementing Robotframework, Docker and Github Action to build and run the docker test image.

## Getting Started
Requirements:
- docker

Build the image by running
```console
docker build . --tag <repo-name>/<app-name>:<tag|version>
```
Run the image built on the previous step by running
```console
docker run <repo-name>/<app-name>:<tag|version>
```

## Development
Install these dependencies below before proceeding to the next step:
- Python 3
- pip3
- Chrome Browser
- Chromedriver
- Code editor

After all the requirements above have been satisfied, install the python dependencies by running
```console
pip install -r requirements.txt
```

Then run this command to run the test on the development mode
```console
robot --variable ENVIRONMENT:Development search_flights/
```

