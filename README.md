# request-dumper
It dumps request info using sinatra.

# Build

## Rack

```
bundle install
bundle exec puma -C puma.rb -b tcp://0.0.0.0:8080 config.ru
```

## Docker

```
docker build -f Dockerfile -t kakakikikeke/request-dumper ./
docker run -p 8080:8080 -d kakakikikeke/request-dumper
```

# Deploy

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

## k8s

[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/request-dumper)](https://artifacthub.io/packages/search?repo=request-dumper)

```
helm repo add request-dumper https://kakakikikeke.github.io/request-dumper/
helm repo update
helm search repo request-dumper
helm install request-dumper request-dumper/request-dumper
```

# Usage

For starting a process on local machine. The server listens on port 8080.

* GET

```
curl -X GET \
  http://hostname:8080/test?hoge=fuga
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
  http://hostname:8080/test \
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
  http://hostname:8080/metrics
```

# Test

```
bundle exec rspec spec/
```