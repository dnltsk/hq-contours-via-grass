FROM ubuntu:xenial

RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update
RUN apt-get install -y grass

RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get -y install openjdk-8-jre

COPY demolocation /usr/lib/grass72/demolocation

RUN echo "GISDBASE: /usr/lib/grass72 \nLOCATION_NAME: demolocation \nMAPSET: PERMANENT \nGUI: text" > $HOME/.grassrc7