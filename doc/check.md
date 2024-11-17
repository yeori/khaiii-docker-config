# 설치 후 확인 사항

# run container

```bash
docker run \
  -itd --name khai-con \
  --mount type=bind,source=$(pwd)/runtime,target=/ws \
  khai-img bash
```
```bash
docker run \
  -e LC_ALL=en_US.UTF-8 \
  -itd --name khai-con \
  --mount type=bind,source=$(pwd)/runtime,target=/ws \
  khai-img bash
```

# locale

Docker로 설치한 후 python 인터프리터가 인식하는 로케일을 확인해야 한다.

다음의 코드로 docker container의 locale을 출력해본다.

```python
import locale
print(f"Locale encoding: {locale.getpreferredencoding()}")
```

나의 경우에는 `ANSI_X3.4-1968`이라는 괴상한 locale값이 출력된다.

