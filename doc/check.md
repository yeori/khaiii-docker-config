# 설치 후 확인 사항

# 설치

```bash
docker build -t kai-run .
```

# starting container

```bash
docker run \
  -itd --name kai \
  --mount type=bind,source=$(pwd)/runtime,target=/ws \
  kai-run
```

# run

```bash
$ ./run.sh 형태소 분석을 테스트합니다.
```

