---
layout: post
title: "Oracle VM"
description: ""
category: tips
tags: []
comments: false
---
{% include JB/setup %}


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