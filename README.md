# homebrew-shellinabox

macOS용 [shellinabox](https://github.com/abcyon/shellinabox) Homebrew tap.
브라우저에서 터미널을 사용할 수 있게 해주는 웹 기반 터미널 에뮬레이터입니다.

## 설치

```bash
brew install abcyon/shellinabox/shellinabox
```

## 서비스 관리

```bash
# 시작 (로그인 시 자동 실행)
brew services start abcyon/shellinabox/shellinabox

# 중지
brew services stop abcyon/shellinabox/shellinabox

# 재시작
brew services restart abcyon/shellinabox/shellinabox

# 상태 확인
brew services list | grep shellinabox
```

설치 후 브라우저에서 http://localhost:4200 으로 접속합니다.

## 서비스 설정

기본 실행 옵션은 다음과 같습니다.

| 옵션 | 설명 |
|------|------|
| `--port=4200` | 접속 포트 |
| `--no-beep` | 소리 비활성화 |
| `-t` | SSL 비활성화 (plain HTTP) |

포트 등 옵션을 변경하려면 plist를 직접 수정합니다.

```bash
# plist 파일 열기
open ~/Library/LaunchAgents/homebrew.mxcl.shellinabox.plist
```

수정 후 서비스를 재시작하면 적용됩니다.

## 제거

```bash
brew services stop abcyon/shellinabox/shellinabox
brew uninstall abcyon/shellinabox/shellinabox
brew untap abcyon/shellinabox
```

## 로그

```bash
tail -f $(brew --prefix)/var/log/shellinabox.log
```

## macOS 빌드 관련

이 tap은 macOS에서 빌드되도록 아래 수정이 적용되어 있습니다.

- `_DARWIN_C_SOURCE` 정의 (`strdup`, `snprintf` 등 사용)
- `openssl@3` 정적 링크
- `--disable-runtime-loading` (동적 SSL 로딩 비활성화)
- `--disable-pam` (macOS에서 `misc_conv` 미지원)
