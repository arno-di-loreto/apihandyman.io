FROM arm64v8/ruby:2.7.1
LABEL maintainer "Arnaud Lauret <arnaudlauret@apihandyman.io>"

ARG JEKYLL_VERSION

RUN gem install jekyll -v ${JEKYLL_VERSION}

CMD ["jekyll", "--help"]
#ENTRYPOINT ["/usr/jekyll/bin/entrypoint"]
WORKDIR /srv/jekyll
VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000