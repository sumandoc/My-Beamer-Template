FROM debian:sid

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 



LABEL maintainer="Dr Suman Khanal <suman81765@gmail.com>"


RUN apt-get update \
  && apt-get install -y gnupg curl libgetopt-long-descriptive-perl make \
  libdigest-perl-md5-perl wget python-pygments fontconfig  && rm -rf /var/lib/apt/lists/*
  
WORKDIR /
RUN curl -sL http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2017/install-tl-unx.tar.gz | tar zxf - \
  && mv install-tl-20* install-tl \
  && cd install-tl \
  && echo "selected_scheme scheme-full" > profile \
  && ./install-tl -repository http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2017/tlnet-final/ -profile profile \
  && cd .. \
  && rm -rf install-tl

ENV PATH /usr/local/texlive/2017/bin/x86_64-linux:$PATH
WORKDIR /home
CMD ["tlmgr", "--version"]
