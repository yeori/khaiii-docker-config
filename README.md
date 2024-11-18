# 설치

```bash
./install.sh
```

`khaiii` 소스코드를 내려받아서 빌드 후 컨테이너를 실행합니다.(name: `kai`)

**[확인]** 실행 중인 컨테이너를 확인합니다.

```bash
$ docker ps
CONTAINER ID   IMAGE     COMMAND    NAMES
73e7b5320cb5   kai-img   "bash"     kai
```

**[확인]** 설치가 성공하면 `log/base_yyyymmmdd_hhmmss.log` 파일에 빌드 도구들의 버전을 출력합니다.

```log
[Stage] base
 * Python
Python 3.6.9
 * PIP
pip 21.3.1 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
 * CMake
cmake version 3.10.2

CMake suite maintained and supported by Kitware (kitware.com/cmake).
 * g++
g++ (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

* 설치가 실패하면 나오지 않음.

# Run

간단한 테스트를 위해서 다음과 같이 실행합니다.

```bash
$ ./run.sh 형태소 분석을 테스트합니다.
형태소  형태소/NNG
분석을  분석/NNG+을/JKO
테스트합니다.   테스트/NNG+하/VA+ㅂ니다/EF+./SF
```

```bash
$ ./run.sh -f json 너무 춥다.
[
  {
    "phrase": "너무",
    "morphs": [
      {
        "lex": "너무",
        "tag": "MAG"
      }
    ]
  },
  {
    "phrase": "춥다.",
    "morphs": [
      {
        "lex": "춥",
        "tag": "VA"
      },
      {
        "lex": "다",
        "tag": "EF"
      },
      {
        "lex": ".",
        "tag": "SF"
      }
    ]
  }
]
```

# Docker image, container 이름

기본 이름은 다음과 같습니다.

```
* Khaiii docker image: 'kai-img'
* Khaiii container   : 'kai'
```

이름을 변경하려면 `./gen_var.sh`를 실행한 후 `.var` 파일을 수정합니다.

```
./gen_var.sh && cat .var
# name of docker image of khaiii
# (optional) default "kai-img"
kai_img_name=kai-img
# name of docker container created from 
# (optional) default "kai"
kai_con_name=kai
```

* kai_img_name=kai-img
* kai_con_name=kai

# Trouble shooting

설치가 실패하는 경우 다음과 같이 로그를 생성합니다.

```bash
$ ./install.sh 2> base.log
```

