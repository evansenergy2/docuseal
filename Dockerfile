FROM ccyphersatee/ee-build-base

COPY app /app/app
COPY db /app/db
COPY config /app/config
COPY config.ru /app/config.ru
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY package.json /app/package.json
COPY Rakefile /app/Rakefile
COPY Procfile /app/Procfile
COPY bin /app/bin
COPY public /app/public
COPY lib /app/lib
COPY init /app/init


WORKDIR /app

ENV RAILS_ENV=production
ENV BUNDLE_PATH=/app/gems
ENV PATH=/opt/node/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bun/bin:/usr/local/rvm/rubies/ruby-3.3.4/bin
RUN apt update && apt upgrade -y && apt install -y --no-install-recommends sudo ruby-vips && \
    useradd -M -d /app app_user && \
    chmod 755 /app/init && \
    npm i yarn -g && \
    bundle install && \
    npm i webpack -g && \
    yarn && \
    npm i && \
    mkdir -p mkdir -p /app/tmp/pids && chown -R app_user /app
    

CMD [ "/app/init" ]
