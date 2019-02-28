FROM debian:sid


ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8
    
ENV PATH /opt/conda/bin:$PATH
    
LABEL maintainer="Dr Suman Khanal <suman81765@gmail.com>"

ENV NB_USER suman
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends wget bzip2 ca-certificates \
    curl git nano gcc g++ make libblas3 liblapack3 libstdc++6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc \
    && conda update -y --all \
    && conda install -y numpy scipy seaborn \
    cython jupyter notebook scikit-learn scikit-image \
    && conda clean -y -t

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

COPY . ${HOME}

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
WORKDIR ${HOME}


EXPOSE 8888

#CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
CMD ["jupyter", "notebook", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]
