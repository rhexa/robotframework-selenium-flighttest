# Robotframework Selenium Flight Testing
Simple project to practice testing automation with Robotframework. This project is implementing Robotframework, Docker and Github Action to deploy the testing application automatically to Heroku.

## Getting Started
Requirements:
- docker

## Development
Install these dependencies below before proceeding to the next step:
- Python 3
- pip3
- Chrome Browser
- Chromedriver
- Code editor

After all the requirements above have been installed, install python dependencies by running
```console
pip install -r requirements.txt
```

Then run this command to run the test on the development mode
```console
robot --variable ENVIRONMENT:Development search_flights/
```

