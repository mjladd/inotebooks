# Ubuntu/ Py3 / Insecure / Jupyter / Tensorflow
# https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/Dockerfile


FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libpng-dev \
        libzmq3-dev \
        pkg-config \
        python3 \
        python3-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

RUN pip3 --no-cache-dir install \
    Pillow \
    h5py \
    ipykernel \
    jupyter \
    matplotlib \
    numpy \
    pandas \
    scipy \
    sklearn \
    cufflinks \
    ipywidgets \
    nbterm \
    nbdime \
    networkx \
    notebook \
    plotly \
    requests \
    sympy \
    seaborn \
    Cython \
    patsy \
    cloudpickle \
    dill \
    numba \
    bokeh \
    vincent \
    beautifulsoup4 \
    keras \
    scikit-image \
    statsmodels \
    xlrd \
&& python3 -m ipykernel.kernelspec


RUN python3 -m pip --no-cache-dir install google-api-python-client

VOLUME /notebooks
ENTRYPOINT /usr/local/bin/jupyter-notebook --no-browser --ip=0.0.0.0 --notebook-dir=/notebooks --allow-root  --NotebookApp.token=''

# IPython
EXPOSE 8888

