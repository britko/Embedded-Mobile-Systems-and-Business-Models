# Embedded-Mobile-Systems-and-Business-Models
임베디드 리눅스에 기반한 시스템 빌드로 임베디드 시스템에 대한 기획-설계-구현 과정을 이해

## 🛠Equipment
- A1004NS 본체
- A1004NS 받침대
- GIGA bit LAN Cable
- 전원 어댑터
- USB 8G Memory & Cap
- USB AUDIO
- USB HUB
- 본체 포장 박스 및 내부 완충재
- 설명서 및 보증서

## 🎁Tech
- VBOX | VMware | WSL2 - CPU: 4Core / Memory: 4GB / Storage: 50GB(dynamic allocation)
- Ubuntu 18.04 LTS
- OpenWrt 21.02.0

## OpenWrt
- OpneWrt(OPEN Wireless RouTer) Project는 다양한 임베디드 장치를 위한 Linux 배포판.
- 패키지 관리 제공
- 응용 프로그램 선택 및 구성에서 자유로워지며, 응용 프로그램에 밎게 패키지를 사용하여 장치를 사용자 정의할 수 있다.
- [OpenWrt](https://openwrt.org/)
- [OpenWrt GitHub](https://github.com/openwrt/openwrt)

## How to
1. Install `VBOX(or WSL2)`

2. Install `Ubuntu 18.04 LTS`

3. Install `OpenWrt 21.02.0` in Ubuntu

4. Change server to kakao

```bash
# copy this repository
git clone https://github.com/britko/Embedded-Mobile-Systems-and-Business-Models.git
```

```bash
# install openWrt 21.02.0
# https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem#debianubuntu
# https://github.com/openwrt/openwrt
cd Embedded-Mobile-Systems-and-Business-Models
bash install_openwrt.sh
```

### To select your preferred configuration for the toolchain, target system & firmware packages.
1. Copy & Paste code [.config](https://downloads.openwrt.org/releases/21.02.0/targets/ramips/mt7620/config.buildinfo)
```bash
cd openwrt
sudo vi .config
```

2. Run `make menuconfig` to configure the firmware image and the kernel

3. Target Profile -> ipTIME A1004ns

4. Exit - Yes

5. Run `make -j 5 (V=s)` (Never `sudo` mode!) to build the firmware image
   - make개발자에 의하면 -j (Total Core + 20% of Total Core)로 실행하면 가장 효율적인 작업이 가능하다고 한다.
   - `-j $(nproc)`: 빠른 빌드를 위해 동시에 수행가능한 프로세스의 수를 지정
   - `V=s`: 빌드를 수행하면서 실행되는 명령어와 스크립트 내용, 빌드 성공여부와 실패시 에러 내용 등의 정보를 화면에 출력하도록 하는 옵션

6. openwrt/bin/target/ramips/mt7620 is created

### To build your firmware. This will download all sources, build the cross-compile toolchain and then cross-compile the GNU/Linux kernel & all chosen applications for your target system.
![실습환경]()
1. 실습 환경을 위 사진과 같이 구성

2. 브라우저를 통해 192.168.1.1로 접속 (ipTIME 관리도구)

3. ipTIME을 OpenWrt로 펌웨어 업그레이드
   - 기본 설정 - 펌웨어 업그레이드
   - '수동 업그레이드 실행' 선택
   - '파일 선택' - [OpenWrt initramfs kernel](https://github.com/britko/Embedded-Mobile-Systems-and-Business-Models/blob/master/a1004ns_firmware_hjsuh/openwrt-21.02.0-ramips-mt7620-iptime_a1004ns-initramfs-kernel_hjsuh.bin)
   - '수동 업그레이드' 실행

4. 192.168.1.1로 재접속해 OpenWrt 설치 확인

※기존의 데이터를 백업

- 상단 바 - System - Backup / Flash Firmware - Save mtdblock contents를 모두 다운받는다.

5. A1004NS에 맞는 OpenWrt system으로 Firmware 변경
   - 'Flash new firmware image' - [OpenWrt squashfs sysupgrade](https://github.com/britko/Embedded-Mobile-Systems-and-Business-Models/blob/master/a1004ns_firmware_hjsuh/openwrt-21.02.0-ramips-mt7620-iptime_a1004ns-squashfs-sysupgrade_hjsuh.bin) - 'Keep settings and...' 해제 - continue

6. 무선 활성화(2.4GHz, 5GHz)
   - Network - Wireless - Edit
   - Interface Configuration - Wireless Security - Encryption: WPA2-PSK - Key: {암호설정}
   - Device Configuration - Advanced Settings - Country Code: KR - Save
   - Save & Apply

7. Router 암호 설정
   - System - Administration - 암호 설정

8. IP를 192.168.1.1에서 192.168.20.1로 변경
   - ssh를 통해 A1004NS에 접속 `ssh 192.168.1.1 -l root`
   - `vi /etc/config/network` - interface option ipaddr '192.168.20.1'로 변경 - 저장하고 종료
   - `sync`
   - `reboot`
   - HOST PC에서 IP 변경 확인

9. 브라우저에 `192.168.20.1`로 접속
## TODO
- Design & Implement Apllication for Embedded System

- Build

- Test