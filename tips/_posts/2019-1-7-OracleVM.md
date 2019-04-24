---
layout: post
title: "Oracle VM"
description: ""
category: tips
tags: []
comments: false
---
{% include JB/setup %}

<img src="{{site.url}}/images/Tips/Virtualbox_logo.png" alt="Oracle VM" style="width: 250px;" align="right"/>

# Host Shared Folder in Ubuntu

1. Expectations:
   * Ubuntu Installed
   * Logged in
   * Network connection from within Ubuntu
2. Open Machine->Settings
3. Shared Folders (On the left)
4. Add new Shared Folders (Top right)
5. Set the following:
   * Folder Path: The path to a windows folder you wish to share (Backup this folder, just incase)
   * Folder Name: shared
   * Read-Only: Un-checked
   * Auto-mount: Un-checked
   * Mounting poaint: blank
   * Make Permanent: checked
6. Click OK
7. Run the following command in the terminal:
```
sudo-apt-get install virtualbox-guest-utils
```
8. Reboot the VM:
```
sudo shutdown -r now
```
9. Open /etc/fstab for editing
```
sudo vim /etc/fstab
```
10. Add the following tab seperated line:
```
shared	/home/<<USER>>/shared	vboxsf	defaults	0	0
```
11. Add the following line to /etc/modules
```
vboxsf
```
12. Reboot the VM:
```
sudo shutdown -r now
```

# Expand Virtual Disk Size
1. Close oracle VM and your linux virtual box.
2. In windows open a command console.
3. change directory to Virtual box folder:
```
cd “C:\Program Files\Oracle\VirtualBox”
```
4.
Use the following command to resize Virtual Box to 50Gb.
```
VBoxManage modifyhd “C:\Users\<<USER NAME>>\VirtualBox VMs\<<VM NAME>>\<<VM NAME>>.vdi” --resize 51200
```
5. Open the VM in virtual box.

6. The harddrive has now been expanded in size, but we still need to repartition the system to use the expanded range. The suggested method is in linux to use the GUI Gparted. 

7. Gparted may need to be installed, just search for it in the system, and an install option will be available.

8. click on the partition you wish to expand and modify the size.