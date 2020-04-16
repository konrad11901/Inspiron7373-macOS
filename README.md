# macOS Catalina on Dell Inspiron 7373
This repository contains an OpenCore configuration to run macOS Catalina (10.15.4) on Dell Inspiron 7373 2-in-1 laptop with OpenCore 0.5.7.

## System Configuration
* CPU: Intel Core i7-8550U
* RAM: 16GB 2400MHz
* SSD: SK Hynix SC311 256GB SATA3 M.2 (running [latest firmware](https://www.dell.com/support/home/us/en/19/drivers/driversdetails?driverid=11r73&oscode=wt64a&productcode=inspiron-13-7373-2-in-1-laptop))
* 1080p Touchscreen display, supports stylus (ELAN2097)
* I2C Precision touchpad (DELL07EB)
* Intel 7265 Wi-Fi card
* Realtek ALC295
* Realtek USB Camera + IR Camera (for Windows Hello)
* Firmware: [1.16.0](https://www.dell.com/support/home/us/en/19/drivers/driversdetails?driverid=gdtxp&oscode=wt64a&productcode=inspiron-13-7373-2-in-1-laptop)

## What doesn't work or works partially
* Combo jack (This is a weird thing because you have to pull the headphone jack away from the computer for about 0.2mm, then change the slider balance values for it to work properly).
* Touchscreen - one finger works as a stylus, two fingers behave as one, three as two, four as three
* Wi-fi card (needs to be replaced or wait for [AppleIntelWifiAdapter]https://github.com/appleintelwifi/adapter or [itlwm]https://github.com/zxystd/itlwm/ to work.)
* SD Card reader (Note from Baddles: Port must be injected as a HS0x something along with port type as "internal" (aka 255) in usbmap to work. This works properly on my machine).
* IR Camera
* In some rare cases, the VoodooI2C will crash on boot and thus the touchpad won't work. A simple restart will fix that - I do not currently have a better solution.

**Any contributions are welcome** - it looks like the first two issues can be somehow fixed, I am just out of ideas. Also, check out the Issues tab.

## BIOS Configuration
Turn off the Secure Boot. That should be all.

## UEFI Variables
In order to run macOS without having to use WhatEverGreen's framebuffer patching and CFG-related booter quirks, it is strongly recommended to modify a few UEFI variables. To do that, you can use the included ModifiedGrub.efi (credits *brainsucker*), which provides the `setup_var` command.

The following variables should be updated:
Variable|Offset|Default value|Desired value|Comment
---|---|---|---|---
CFG Lock|0x4C7|0x01 (enabled)|0x00 (disabled)|Disable CFG Lock to prevent MSR 0x02 errors on boot
DVMT Pre-allocated|0x76D|0x01 (32M)|0x02 (64M)|Increase DVMT pre-allocated size to 64M
DVMT Total GFX Memory|0x76E|0x02 (256M)|0x03 (MAX)|Increase total GFX memory limit to maximum

**DISCLAIMER: those offset values are taken from 1.15.0 and 1.16.0 firmwares. DO NOT use them with older versions unless you have checked that they are the same.**

Usage:  
`setup_var <offset> <value>`  
ex.  
`setup_var 0x4C7 0x00`

## Notes
* The included CpuFriendDataProvider is made for i7-8550U. If you have the i5-8250U processor, **DO NOT** use this kext. You can make a new data provider kext for that CPU (and make a PR!).
* In "Optional" directory, you can find "NullEthernet.kext" and "SSDT-RMNP.aml" files. If you haven't swapped the included Wi-Fi card, you may need to use them for Apple services to work properly.
* In the same directory, you can find two kexts - IntelBluetoothFirmware and IntelBluetoothInjector. Add them if you want to use the included Bluetooth card.
* For HiDPI scaling options, I recommend to use [one-key-hidpi](https://github.com/xzhih/one-key-hidpi).

## Credits
* [the-darkvoid](https://github.com/the-darkvoid) for [Dell XPS 9360 repository](https://github.com/the-darkvoid/XPS9360-macOS)
* [acidanthera](https://github.com/acidanthera) for [OpenCore](https://github.com/acidanthera/OpenCorePkg) 
* Kexts developers listed in kexts.txt
