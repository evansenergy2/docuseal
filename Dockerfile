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



WORKDIR /app

ENV PATH=/opt/node/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bun/bin:/usr/local/rvm/rubies/ruby-3.3.4/bin
RUN apt update && apt upgrade -y && apt install -y --no-install-recommends sudo ruby-vips && \
    useradd -M -d /app app_user && \
    npm i yarn -g && \
    bundle install && \
    npm i webpack -g && \
    npm i && \
    bundle exec rake assets:precompile && \
    mkdir -p mkdir -p /app/tmp/pids && chown -R app_user /app
    
    
# apt remove -y build-essential unzip curl gnupg && apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*

CMD [ "bundle exec rails s -p 5000" ]



# Rails.application.secret_key_base
# opm get bungle/lua-resty-nettle
# opm get fffonion/lua-resty-openssl

