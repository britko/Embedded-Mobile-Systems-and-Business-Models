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
- VBOX(or WSL2) - CPU: 4Core / Memory: 4GB / Storage: 50GB(dynamic allocation)
- Ubuntu 18.04 LTS
- OpenWrt 21.02.0

## OpenWrt
- OpneWrt(OPEN Wireless RouTer) Project는 다양한 임베디드 장치를 위한 Linux 배포판.
- 패키지 관리 제공
- 응용 프로그램 선택 및 구성에서 자유로워지며, 응용 프로그램에 밎게 패키지를 사용하여 장치를 사용자 정의할 수 있다.
- [OpenWrt](https://openwrt.org/)
- [OpenWrt GitHub](https://github.com/openwrt/openwrt)

---

## How to
1. Install `VBOX(or WSL2)`

2. Install `Ubuntu`

3. Install `OpenWrt` in Ubuntu

```bash
# copy this repository
git clone https://github.com/britko/Embedded-Mobile-Systems-and-Business-Models.git
```

```bash
# install openWrt 21.02.0
# https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem#debianubuntu
# https://github.com/openwrt/openwrt
bash install_openwrt.sh
```

### To select your preferred configuration for the toolchain, target system & firmware packages.
1. Copy code (https://downloads.openwrt.org/releases/21.02.0/targets/ramips/mt7620/config.buildinfo)
2. Run `make menuconfig`
3. Target Profile -> ipTIME A1004ns
4. Exit - Yes
5. Run `make -j5` (현재 CPU 개수 +1 하면 효율적인 컴파일이 가능하다고 한다.)

### To build your firmware. This will download all sources, build the cross-compile toolchain and then cross-compile the GNU/Linux kernel & all chosen applications for your target system.
make


4. Configuration OpenWrt for Embedded System

5. Design & Implement Apllication for Embedded System

6. Build

7. Test