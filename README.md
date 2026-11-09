# 한국 로스트아크 Linux 실행 기록 · STOVE + GE-Proton

**2026-11-10, Ubuntu 26.10 / KDE Plasma Wayland / RX 6900 XT / GE-Proton10-24에서 한국 STOVE 로스트아크 인게임 플레이 성공.**

기존 Windows 게임 설치본을 /mnt/d에 마운트해 사용했다. 2026-11-10에는 게임 접속 후 **카오스 던전과 가디언 토벌을 실제 플레이하고 정상 종료**했다. 인게임이 부드러웠다는 체감 보고가 있으며 FPS는 측정하지 않았다.

> 한 PC에서 성공한 **실사용 기록과 재현용 설정 예제**다. 게임·안티치트·Proton 버전이 바뀌면 결과도 달라질 수 있다. 게임 파일이나 보안 모듈은 제공하지 않는다.

## 확인한 환경

| 항목 | 확인된 구성 |
| --- | --- |
| Linux | Ubuntu 26.10 |
| Desktop | KDE Plasma / KWin 6.7.5 Wayland, XWayland |
| CPU | Ryzen 7 7800X3D |
| GPU | AMD Radeon RX 6900 XT (RADV) |
| Launcher | 한국 STOVE PC 3.2.33 |
| Proton | **GE-Proton10-24**, 실플레이 성공 |
| 비교 | GE-Proton11-6에서는 UNCHEATER 오류 E0191009 발생 |
| 게임 | Windows 설치본, /mnt/d에서 Wine D:로 연결 |

## 설치 및 실행

Steam, **GE-Proton10-24**, 공식 STOVE Windows 설치 파일과 접근 가능한 로스트아크 Windows 설치본을 준비한다.

~~~bash
cp config.example.env config.local.env
# config.local.env에서 Proton 실행기와 경로를 수정한다.
./scripts/install-stove.sh
~~~

스토브 설치 마법사를 끝까지 진행한다. STOVE에서 Edge WebView2가 필요하다고 표시하면 다음 명령을 한 번 실행한다.

~~~bash
./scripts/install-webview2.sh
~~~

기존 게임 드라이브와 STOVE 게임 경로를 설정한다. KDE 6.7.5의 Wine 창 포커스 우회 설정도 같은 prefix에 등록된다.

~~~bash
./scripts/configure-prefix.sh
./scripts/run-stove.sh
~~~

STOVE에 로그인한 뒤 **LOST ARK**에서 설치본을 인식시키고, 필요한 게임 복구·업데이트를 정식으로 진행한다. 이 과정의 UI 조작과 계정 인증은 사용자가 직접 수행한다.

### 경로 예시

| Linux | Proton/Wine |
| --- | --- |
| /mnt/d/Smilegate/Games/LOSTARK | D:\Smilegate\Games\LOSTARK |
| ~/Games/stove-linux/compatdata | 이 실험용 별도 Wine prefix |
| prefix의 drive_c/ProgramData/Smilegate/STOVE/STOVE.exe | C:\ProgramData\Smilegate\STOVE\STOVE.exe |

기존 설치된 게임을 Wine prefix 안에 다시 복사하지 않는다. config.local.env의 GAME_MOUNT를 실제 드라이브 마운트 경로로 설정하면 된다. 예제 스크립트는 **D: 드라이브** 기준이며 기존 연결을 함부로 덮어쓰지 않는다.

## 검증한 결과

- 공식 STOVE 설치, WebView2, 로그인, 게임 복구, 게임 본편 시작까지 확인했다.
- **GE-Proton11-6:** UNCHEATER의 E0191009 업데이트 오류 후 게임 종료.
- **GE-Proton10-24:** 별도 prefix에서 UNCHEATER 구성 파일 갱신, 실제 게임 접속, 카오스 던전과 가디언 토벌 완료.
- **남은 문제:** STOVE 런처가 상당히 느림. 일부 글자가 깨져 보이고 KWin 6.7.5에서는 입력 포커스 문제가 발생했다.
- **미측정:** FPS와 프레임 타임, 여러 시간 연속 플레이의 안정성, GE10과 GE11의 내부 차이.

실측 내용은 [2026-11-10 플레이 기록](docs/TESTED-2026-11-10.md), 오류별 대응은 [문제 해결](docs/TROUBLESHOOTING.md)에 정리했다.

## 선행 사례와 출처

- [CHAGAL-Lab/lostark-stove-launcher-fix](https://github.com/CHAGAL-Lab/lostark-stove-launcher-fix): Wine에서 STOVE 업데이트 확인 도중 충돌할 때 사용한 **매니페스트 버전 동기화 방법**의 참고 출처. 이 저장소의 자동화 스크립트는 매니페스트를 변경하지 않는다.
- [KDE Bug 525590](https://bugs.kde.org/show_bug.cgi?id=525590): KWin 6.7.5의 Wine 창 포커스 회귀. [KDE 6.7.6 수정 이력](https://kde.org/announcements/changelogs/plasma/6/6.7.5-6.7.6/).
- [Wellbia UNCHEATER FAQ](https://sega-faq.wellbia.com/index_kr.html): 보안 프로그램 E0191009 오류 설명.

## 저장소에 포함하지 않는 것

STOVE/로스트아크 실행 파일·게임 데이터·UNCHEATER 파일·Wine prefix·설치 프로그램·로그인 정보·토큰·쿠키·실제 사용자 계정 로그·개인정보가 보이는 스크린샷.

다른 PC에서는 아직 재현 테스트를 하지 않았다.
