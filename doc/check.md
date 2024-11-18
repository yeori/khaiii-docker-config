# 설치 후 확인 사항

# 설치

```bash
./install.sh
```

`khaiii` 소스코드를 내려받아서 빌드 후 컨테이너를 실행합니다.(name: `kai`)

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

