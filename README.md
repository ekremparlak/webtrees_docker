Webtrees Docker Image for testing Webtrees. 

This Image based on Alpine. Using Nginx, PHP-FPM and https://github.com/fisharebest/webtrees master branch

Not ready for production. Only for testing.

### Example Usage
```
docker run -d \
  -p 8080:80 \
  eparlak/webtrees
```

Open http://localhost:8080
