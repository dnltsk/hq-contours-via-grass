FROM ubuntu:xenial

RUN apt-get update && \
 apt-get install -y software-properties-common python-software-properties && \
 add-apt-repository ppa:ubuntugis/ubuntugis-unstable && \
 apt-get update && \
 apt-get install -y grass

RUN apt-get -y install software-properties-common && \
 add-apt-repository -y ppa:openjdk-r/ppa && \
 apt-get update && \
 apt-get -y install openjdk-8-jre

COPY demolocation /usr/lib/grass72/demolocation

RUN echo "GISDBASE: /usr/lib/grass72 \nLOCATION_NAME: demolocation \nMAPSET: PERMANENT \nGUI: text" > $HOME/.grassrc7