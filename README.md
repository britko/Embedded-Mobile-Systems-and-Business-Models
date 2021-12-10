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

5. install `OpenWrt`

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
![실습환경](https://github.com/britko/Embedded-Mobile-Systems-and-Business-Models/blob/master/images/%EC%8B%A4%EC%8A%B5%ED%99%98%EA%B2%BD.png)
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
   - `vi /etc/config/network` - interface option ipaddr `192.168.20.1`로 변경 - 저장하고 종료
   - `sync`
   - `reboot`
   - HOST PC에서 IP 변경 확인

9. 브라우저에 `192.168.20.1`로 접속

## OpenWrt on Docker ([docker-openwrt-builder](https://github.com/mwarning/docker-openwrt-builder))
### Prerequisites
- Docker install
- running Docker daemon
- build Docker image:
   ```bash
   sudo apt-get install docker.io
   sudo dockerd &
   mkdir docker && cd docker

   git clone https://github.com/mwarning/docker-openwrt-builder.git
   cd docker-openwrt-builder
   docker build -t openwrt_builder .
   ```

### Usage GNU/Linux
```bash
# Create a build folder and link it into a new docker container:
mkdir ~/mybuild
docker run -v ~/mybuild:/home/user -it openwrt_builder /bin/bash
```

```bash
# In the container console, enter:
sudo git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
sudo ./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
# Target System: MediaTek Ralink MIPS, Subtarget: MT7620 based boards, Target Profile: ipTIME A1004ns, Global build settings - Set build defaults..., luci check
make -j4
```
After the build, the images will be inside `~/mybuild/openwrt/bin/target/`

### but
- 소프트웨어를 OpenWrt에 설치하는데 커널, 라이브러리에서 의존성 문제가 발생할 가능성이 있고, 그 때마다 이를 해결하기 위해 새로 빌드하는데는 시간이 너무 오래 걸리기 때문에 미리 빌드된 [Development Snapshot builds](https://downloads.openwrt.org/snapshots/targets/ramips/mt7620/)를 사용해 빠르게 작업을 진행할 수 있다.

1. Download iptime_a1004ns-squashfs-systpgrade.bin

2. OpenWrt Firmware upgrade

3. Because luci is disenable, it cannot be accessed through a browser.
   ```bash
   ssh 192.168.20.1 -l root
   opkg update
   opkg install luci
   sync
   reboot
   ```

4. Connect to 192.168.20.1 in your browser.

## OpenWrt on x86
### Virtual Machine configuration
1. Create a New Virtual Machine 
   - Linux: Other Linux (64-bit)
   - 1 Core, 512 RAM, [openwrt-21.02.0-x86](https://github.com/britko/Embedded-Mobile-Systems-and-Business-Models/blob/master/openwrt-21.02.0-x86-64-generic-ext4-combined.vdi)

2. Set Virtual Machine
   ```yml
   저장소:
      속성:
         종류: virtio-scsi
   네트워크:
      어댑터 1:
         다음에 연결됨: 내부 네트워크
         고급:
            어댑터 종류: 반가상 네트워크
      어댑터 2:
         다음에 연결됨: 어댑터에 브리지
         고급:
            어댑터 종류: 반가상 네트워크
   ```

### OpenWrt configuration
1. Change lan ip
   ```bash
   vi /etc/config/network

   # Change ipaddr
   config interface 'lan'
          ...
          option ipaddr '192.168.21.1'
          ...
   ```
   `vi /etc/config/network` - interface 'lan' option ipaddr `192.168.21.1`로 변경 - `:wq`저장하고 종료

2. luci 활성화를 위해 주석 제거
   ```bash
   vi /etc/config/firewall

   # Remove annotation & Change dest_ip
   # port redirect port coming in on wan to lan
   config redirect
          option src                wan
          option src_dport    80
          option dest               lan
          option dest_ip      192.168.21.1
          option dest_port    80
          option proto        tcp

   sync
   reboot
   ```

3. Connect to {VM_ip} in your browser.

## OpenWrt on x86 Docker Build
### 
```bash
mkdir mybuild2
sudo -s
doekr run -v ~/mybuild2:/home/user -it openwrt_builder /bin/bash
git clone https://git.openwrt.org/openwrt/openwrt.git

git fetch --tags
git tag -l

git checkout v${version}

./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
```

```yml
# OpenWrt Configuration
target System: x86
Subtartget: x86_64
Target Profile: Generic
Global build settings: [*]Set build defaults...
LuCI:
   1. Collections: <*>luci
```
- Exit
- `make -j $(nproc)`

## OpenWrt MP3 Player

### Plugin Hadware
- USB 8G Memory & Cap
- USB AUDIO
- USB HUB
### Add Software ([OpenWrt Docs: USB audio support](https://openwrt.org/docs/guide-user/hardware/audio/usb.audio))
OpenWrt - System - Software
- Software for mp3 paly
   - kmod-usb-audio
   - kmod-sound-core
   - alsa-utils
   - usbutils
   - madplay
   - mpd
- Software for USB
   - kmod-usb-storage
   - kmod-fs-vfat
### Run MP3 Player
SSH로 A1004NS에 접속 `ssh 192.168.20.1 -l root`
```bash
# 패키지 소프트웨어 업데이트
opkg update

cd /mnt
mkdir USB

# USB Memory에 mount
mount -t vfat /dev/sda1 /mnt/USB

cd USB/mp3

# MP3 파일을 재생
madplay ${MP3 file}
```

### SMB_FileShare
OpenWrt - System - Software
- luci-app-ksmbd
Logout -> Login
Services - Network Shares
   ```yml
   Shared Directories(Add):
   Name: mp3
   Path: /mnt/USB/mp3
   ```
- Save & Apply
- 네트워크 공유폴더 `\\192.168.x.x`

### Shairplay
OpenWrt - System - Software
- luci-app-shairplay
Services - Shairplay
   ```yml
   MAIN:
   Enabled: check
   Respawn: check
   ...
   AO Device ID: 0
   ```

## TODO
- Design & Implement Apllication for Embedded System

- Build

- Test