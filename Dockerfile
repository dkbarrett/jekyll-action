FROM ruby:2.7.1-slim

LABEL version="2.0.0"
LABEL repository="https://github.com/helaili/jekyll-action"
LABEL homepage="https://github.com/helaili/jekyll-action"
LABEL maintainer="Alain Hélaïli <helaili@github.com>"

COPY LICENSE README.md /

# ENV BUNDLER_VERSION 1.17.3
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        build-essential \
        git \
    && bundle config --global silence_root_warning 1

# Install program to configure locales
RUN apt-get install -y locales
RUN dpkg-reconfigure locales && \
  locale-gen C.UTF-8 && \
  /usr/sbin/update-locale LANG=C.UTF-8

# Install needed default locale for Makefly
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
