FROM ruby:3.2.2

# Install yarn
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn

# Rails環境を本番環境にする
#ENV RAILS_ENV=production

# データベース用にPostgreSQLをインストール
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
# bundlerバージョンを上げないとエラーになる対策
RUN gem update --system 3.3.20 && bundle install

# Add this before copying the entire app
COPY package.json yarn.lock ./
RUN yarn install

COPY . /myapp

# コンテナ起動時に実行させるentrypoint.shを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Rails サーバ起動
CMD ["bin/dev"]