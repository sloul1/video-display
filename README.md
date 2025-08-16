> [!CAUTION]  
> WIP = Work in progress! This warning will be removed after project's documentation is completed.

# video-display

## Automatic video display ***`with headless setup option`***

Goal of this project is to create easy to use ***(switch on / switch off)*** low (or no) maintenance system for viewing videos at exhibition.  
The system is created on `Raspberry Pi 4B (4 GB RAM)`.  

Project **video-display** enables a [`systemd service`](#create-a-service) when the device starts up.  
This service points to a [`bash script`](#create-a-bash-script-for-the-service) that uses [`VLC player`](https://www.videolan.org/vlc/) to play video files with `MP4` file extension in loop from `/home/ubuntu/video` (or other user defined) folder. 


Raspberry Pi OS Lite (Debian Linux 12).

### Hardware used
- [`Raspberry Pi 4B (4 GB RAM)`](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/) with `3A power supply`  
- `64 GB microSD card`  
- `Micro HDMI - HDMI cable` for connecting  
- [`27" Lenovo thinkVision T27h-30`](https://support.lenovo.com/us/en/solutions/pd500590-thinkvision-t27h-30-monitor-overview) display for viewing the videos

### Software  
This system uses [`Raspberry Pi OS Lite (64-bit)`](https://www.raspberrypi.com/software/operating-systems/) as operating system. Bootable microSD for Raspi 4 is created with [`Raspberry Pi Imager`](https://www.raspberrypi.com/software/).  
with [`VLC player`](https://www.videolan.org/vlc/) 

Raspberry Pi OS version information:  
```bash
cat /etc/os-release
```

```bash
PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"
NAME="Debian GNU/Linux"
VERSION_ID="12"
VERSION="12 (bookworm)"
VERSION_CODENAME=bookworm
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
```

### Prepare operating system

Install latest updates on operating system.
```bash
sudo apt update && sudo apt upgrade -y
```
Install VLC player.
```bash
sudo apt install vlc
```



#### Create a bash script for the service

```bash
nano videos-player.sh
```

```bash
#!/bin/bash

VIDEO_DIR=/home/ubuntu/video # Define directory for the videos

while true; do
    for video in "$VIDEO_DIR"/*.mp4; do
        if [ -f "$video" ]; then
            cvlc --no-video-title-show --play-and-exit "$video"
        fi
    done
done
```


### Service

#### Create a service
```bash
sudo nano /etc/systemd/system/playvideos.service
```

```bash
[Unit]
Description=Play Videos Loop

[Service]
ExecStart=/bin/bash /home/ubuntu/videos-player.sh
Restart=always
User=ubuntu

[Install]
WantedBy=multi-user.target
```

#### Enable service to start when the device is started
```bash
   sudo systemctl enable playvideos.service 
```

## Power consumption

System draws less than 26 watts maximum from the power outlet when playing `60 FPS` full HD `(1920 x 1080) resolution videos`. `CHECK THIS WITH DIFFERENT VIDEO FORMATS, RESOLUTON AND BITRATES!!!`
> [!IMPORTANT]  
> List details of video formats used HERE!
