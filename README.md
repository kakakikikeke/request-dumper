# request-dumper
It dumps request info using [sinatra](http://www.sinatrarb.com/).

# How to build
## Rack

```
bundle install
bundle exec rackup config.ru -o 0.0.0.0
```

It was listened to 9292 port on your server.

## Docker

```
docker build -f Dockerfile-local -t kakakikikeke/request-dumper ./
docker run -p 9292:8080 -d kakakikikeke/request-dumper
```

## Heroku

Deploy this app into your heroku account.  

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/kakakikikeke/request-dumper)

## Heroku Container Registry

```
heroku container:login
heroku create -a test-app-20181002
docker build -f Dockerfile-for-heroku-container -t registry.heroku.com/test-app-20181002/web .
docker push registry.heroku.com/test-app-20181002/web
heroku container:release web
heroku open -a test-app-20181002
```

## Google App Engine

```
git clone https://github.com/kakakikikeke/request-dumper.git
cd request-dumper
gcloud app deploy
```

# How to use

For starting a process on local machine.

* GET

```
curl -X GET \
  http://hostname:9292/test?hoge=fuga
```

You get the below json response.

```
{
    "body": "\"\"",
    "params": "{\"hoge\":\"fuga\",\"splat\":[\"test\"],\"captures\":[\"test\"]}",
    "path_info": "/test",
    "method": "GET",
    "query_string": "hoge=fuga",
    "content_length": null,
    "media_type": null,
    "form_data": false
}
```

* POST

```
curl -X POST \
  http://hostname:9292/test \
  -d '{"hoge":"fuga"}' \
  -H "Content-Type: application/json"
```

You get the below json response.

```
{
    "body": "{\"hoge\":\"fuga\"}",
    "params": "{\"splat\":[\"test\"],\"captures\":[\"test\"]}",
    "path_info": "/test",
    "method": "POST",
    "query_string": "",
    "content_length": "15",
    "media_type": "application/json",
    "form_data": false
}
```

* Bonus

You can show the app metrics for prometheus.

```
curl -X GET \
  http://hostname:9292/metrics
```

# Version

* Ruby 2.2.0p61
* Gem 2.4.6
* Other libraries version confirm to Gemfile
