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

---

## How to
...

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