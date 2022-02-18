FROM alpine:edge

RUN apk add chromium chromium-chromedriver python3-dev py3-pip
RUN apk add gcc musl-dev libffi-dev openssl-dev

RUN mkdir -p /home/app/search_flights
COPY ./search_flights/ /home/app/search_flights/
COPY ./requirements.txt /home/app/

WORKDIR /home/app/
RUN pip install -r ./requirements.txt

CMD [ "robot", "search_flights/" ]