# 문제 해결 기록

## 1. STOVE 창이 앞에 있지만 클릭이나 키보드 입력이 안 됨

**환경:** KDE KWin 6.7.5 + Wine/Proton(XWayland).

WM_HINTS.input=False와 WM_TAKE_FOCUS가 나타나는 창에서 포커스가 넘어가지 않는 문제가 있었다. STOVE 전용 Wine prefix에 다음 값을 등록한 뒤 **STOVE를 완전히 재시작**했다.

~~~reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Wine\X11 Driver]
"UseTakeFocus"="N"
~~~

이 저장소의 ./scripts/configure-prefix.sh가 같은 설정을 적용한다. 수정 뒤 WM_HINTS.input=True와 WM_TAKE_FOCUS 제거를 확인했다.

KWin 6.7.6에는 해당 회귀의 수정 사항이 포함돼 있다. 다만 UseTakeFocus=N 적용 후에도 실행 중인 STOVE 창의 포커스가 일시적으로 빠진 적이 있었으므로 이 설정을 모든 입력 문제의 완전한 해결책이라고 부르지는 않는다.

출처: [KDE Bug 525590](https://bugs.kde.org/show_bug.cgi?id=525590) · [6.7.6 변경 내역](https://kde.org/announcements/changelogs/plasma/6/6.7.5-6.7.6/).

## 2. 로그인 후 회색 막, 클릭 시 띵 소리

로그인 후 sns_browser_option_guide라는 SNS 브라우저 옵션 안내 **모달 창**이 떴다. 실제 팝업의 **닫기** 동작을 수행하니 어두운 오버레이와 경고음이 사라졌다. 이는 KWin 포커스 문제와 별개의 현상이었다.

## 3. 로아 업데이트 확인 중 STOVE 종료

초기 실험에서 STOVE 업데이트 확인 직후 STOVE.exe 접근 위반(0xC0000005)이 발생했다. 기존 게임 매니페스트의 local_version 값은 995였고 STOVE가 내려받은 최신 캐시는 1001이었다.

참고 프로젝트 [CHAGAL-Lab/lostark-stove-launcher-fix](https://github.com/CHAGAL-Lab/lostark-stove-launcher-fix)의 매니페스트 버전 동기화 방법을 참고했고, 이후 정식 STOVE 복구로 게임 파일을 갱신했다.

이 변경은 실제로 업데이트가 필요한 게임을 잠시 최신으로 표시할 수도 있어 **자동 수행 스크립트에 포함하지 않았다**. 원문·적용 대상 버전·게임 패치 상태를 먼저 확인해야 한다. 매니페스트를 수정했다면 원본 백업을 남기고 정식 게임 파일 복구를 진행한다.

## 4. E0191009: Failed to update Security Program

Wellbia FAQ에 따르면 UNCHEATER 업데이트 과정의 오류다. 첫 실행에서는 GE-Proton11-6로 게임 프로세스 생성까지 성공했으나 이 코드가 뜬 뒤 게임이 종료됐다.

이 PC에는 게임 드라이브와 prefix 모두 충분한 여유 공간이 있었고, STOVE 게임 파일 복구도 성공했다. 보안 프로그램의 내부 상세 실패 로그는 확보하지 못했다.

별도 GE-Proton10-24 prefix에서 정상 로그인 후 다시 실행하자 UNCHEATER 파일 갱신 및 게임 접속이 성공했고 실제 게임 콘텐츠를 플레이했다. **Proton과 prefix, 게임 패치 상태가 함께 달라졌으므로 특정 변경 한 가지를 원인으로 확정하지 않았다.**

현재 검증된 조합은 GE-Proton10-24다. 보안 모듈을 변조하거나 실행 검사를 무력화하지 않았다.

## 5. 한글 글자 일부가 잘못 그려짐

STOVE 로그인 창의 일부 한글이 깨진 형태로 표시됐다. ko_KR.UTF-8 설정, Tahoma·Segoe UI 대체 설정, Pretendard 폰트 등록을 각각 시험했으나 개선되지 않았다. 번역 문자열은 정상 유니코드였다.

게임 본편의 한국어가 깨진다는 보고는 없었고 이 문제는 STOVE UI에서만 관측됐다.

## 6. STOVE 런처는 느리지만 게임은 부드러움

실사용자가 STOVE의 심한 UI 렉을 보고했다. 동일 환경에서 실제 게임 접속 후 카오스 던전과 가디언 토벌을 완료했고 인게임 반응은 부드러웠다. STOVE 렉의 원인과 개선 방법은 아직 측정하지 않았다.
