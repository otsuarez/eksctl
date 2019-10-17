
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

# why debian


```
SessionManagerPlugin is not found. Please refer to SessionManager Documentation here: http://docs.aws.amazon.com/console/systems-manager/session-manager-plugin-not-found
```

using alpine:
```sh
~ # cat /etc/os-release
NAME="Alpine Linux"
```

> Currently, we don't support Alpine Linux OS officially.

https://github.com/aws/amazon-ssm-agent/issues/140

