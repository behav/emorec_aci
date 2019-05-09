FROM ubuntu:18.04

LABEL author="justinshenk <https://github.com/justinshenk/fer>"
LABEL author="ipazc <https://github.com/ipazc/mtcnn/>"
LABEL author="oarriga <https://github.com/oarriaga/face_classification/>"
LABEL maintainer="Daniel Albohn <d.albohn@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get --assume-yes install \
    python3-dev \
    libopencv-dev \
    python-opencv \
    python3-pip \
    git \
    nano
    # Maybe for the future
    # ffmpeg

RUN cp /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libpthreads.so

RUN cd /opt && \
    git clone https://github.com/d-bohn/fer \
    emorec

RUN cd /opt/emorec && \
    pip3 install -e .

RUN pip3 install requests argparser

ADD ./assets/video_analysis.py /opt/emorec/video_analysis.py

ENV VIDEOFILE="/opt/emorec/test.mp4"
ENV OUTDIR="/opt/emorec/output"
ENV SAVENAME="data.csv"

# ENTRYPOINT ["/usr/bin/python3", "/opt/emorec/video_analysis.py",$VIDEOFILE,$OUTDIR,$SAVENAME]
