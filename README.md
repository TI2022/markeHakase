### How to build docker images and start with docker containers

docker-compose build
docker-compose run web bundle exec rails webpacker:install
docker-compose run web bundle exec rails db:create
docker-compose run web bundle exec rails db:migrate
docker-compose down
docker-compose up -d

### config/webpack/environment.js 書き換える
const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)
