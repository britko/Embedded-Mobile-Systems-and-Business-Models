# Embedded-Mobile-Systems-and-Business-Models
임베디드 리눅스에 기반한 시스템 빌드로 임베디드 시스템에 대한 기획-설계-구현 과정을 이해

## Equipment
- A1004NS 본체
- A1004NS 받침대
- GIGA bit LAN Cable
- 전원 어댑터
- USB 8G Memory & Cap
- USB AUDIO
- USB HUB
- 본체 포장 박스 및 내부 완충재
- 설명서 및 보증서

## Tech
- VBOX (Optional: WSL2)
- Ubuntu 18.04 LTS
- OpenWRT 21.02.0

## OpenWRT
OpneWRT(OPEN Wireless RouTer) Project는 다양한 임베디드 장치를 위한 Linux 배포판.

패키지 관리 제공

응용 프로그램 선택 및 구성에서 자유로워지며, 응용 프로그램에 밎게 패키지를 사용하여 장치를 사용자 정의할 수 있다.

---

## How to
1. Install `VBOX(or WSL2)`

2. Install `Ubuntu`

3. Install `OpenWRT` in Ubuntu
```bash
# copy this repository
git clone https://github.com/britko/Embedded-Mobile-Systems-and-Business-Models.git
```

```bash
# install openWRT 21.02.0
# https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem#debianubuntu
# https://github.com/openwrt/openwrt
bash install_openwrt.sh

# To select your preferred configuration for the toolchain, target system & firmware packages.
make menuconfig

# To build your firmware. This will download all sources, build the cross-compile toolchain and then cross-compile the GNU/Linux kernel & all chosen applications for your target system.
make
```

4. Configuration OpenWRT for Embedded System

5. Design & Implement Apllication for Embedded System

6. Build

7. Test