
Image with `eksctl`, `kubectl` and `aws` cli tools.


```sh
GITHUB_USERNAME=otsuarez
docker build -t ${GITHUB_USERNAME}/eksctl .
docker push ${GITHUB_USERNAME}/eksctl
```

If your directory structure reflects the `GITHUB_USERNAME/PROJECT_NAME` schema, `make` commands are available:

```sh
make build
make push
```


