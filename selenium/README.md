# Seleniumと戯れる

## seleniumコンテナを立ち上げる

参考： https://github.com/SeleniumHQ/docker-selenium

最初
```sh
docker-compose up --build
```

すでにbuildしていたら
```sh
docker-compose start
```

止めるとき
```sh
docker-compose stop
```

### 生存確認

参考：https://i-beam.org/2019/09/08/webdriver-with-curl-01/

コントロールするpathは `/wd/hub/` になる
```sh
curl http://localhost:4444/wd/hub/status
```

### 動かすイメージを変えたい

このへんにするといいかと。  
参考： https://hub.docker.com/u/selenium

- `selenium/standalone-firefox-debug:latest`
- `selenium/standalone-chrome-debug:latest`
- `selenium/standalone-opera-debug:latest`

## webdriverのendpoint

このとおりに。 https://www.w3.org/TR/webdriver/#dfn-endpoints

参考：
- https://qiita.com/hiroshitoda/items/5fa5292ceb1e3e8a9610
