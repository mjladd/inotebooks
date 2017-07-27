# Alpine / Py3 / Insecure / Jupyter
# Mostly from: https://hub.docker.com/r/pshchelo/alpine-jupyter-minimal-py3/
# adds matplotlib and insecure token

FROM alpine:latest
MAINTAINER Pavlo Shchelokovskyy (shchelokovskyy@gmail.com)


RUN apk update \
&& apk add \
    ca-certificates \
    libstdc++ \
    python3 \
    freetype \
&& apk add --virtual=build_dependencies \
    cmake \
    gcc \
    g++ \
    make \
    musl-dev \
    linux-headers \
    gfortran \
    jpeg-dev \
    zlib-dev \
    cairo-dev \
    python3-dev \
&& ln -s /usr/include/locale.h /usr/include/xlocale.h \
&& python3 -m pip --no-cache-dir install \
    cufflinks \
    ipywidgets \
    networkx \
    notebook \
    numpy \
    matplotlib \
    pandas \
    plotly \
    requests \
    sympy \
&& jupyter nbextension enable --py widgetsnbextension \
&& apk del --purge -r build_dependencies \
&& rm -rf /var/cache/apk/* \
&& mkdir /notebooks

VOLUME /notebooks
ENTRYPOINT /usr/bin/jupyter-notebook --no-browser --ip=0.0.0.0 --notebook-dir=/notebooks --allow-root  --NotebookApp.token=''
EXPOSE 8888

