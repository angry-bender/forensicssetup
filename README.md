# WINSIFT ForensicsSetup Beta 0.9.0

![image](https://user-images.githubusercontent.com/18164137/116410447-f0d30a00-a873-11eb-9c6f-d496838549a5.png)


## Contents

- [WINSIFT ForensicsSetup Beta 0.9.0](#winsift-forensicssetup-beta-043)
  - [Contents](#contents)
  - [KNOWN ISSUES](#known-issues)
    - [Choco packages that are broken #18](#choco-packages-that-are-broken-18)
    - [Package issues](#package-issues)
    - [Nimi Places](#Nimi-Places)
  - [Announcements](#announcements)
    - [In Development](#in-development)
    - [Feedback / tool Requests](#feedback--tool-requests)
  - [Licencing](#licencing)
  - [Pre-requisites](#pre-requisites)
  - [Usage](#usage)
  - [Description](#description)
      - [Licenced Software (Included) - Free Licence - Non-Commercial Use](#licenced-software-included---free-licence---non-commercial-use)
      - [Licenced Software (Not Included)](#licenced-software-not-included)
    - [Unlicenced Software (Included)](#unlicenced-software-included)
    - [GUI Tools Included](#gui-tools-included)
    - [Unlicenced Software (In Progress)](#unlicenced-software-in-progress)
  - [Developer contact](#developer-contact)

## KNOWN ISSUES

### Choco packages that are broken [#18](../../issues/18)
 regripper- Maintainer Contacted - (Also part of autospy)
 nimi places not launching, may not show tools by category. All shortcuts are under Forensics tools on the desktop
 

### Package issues

- [ ] Dcode DCode-x86-EN-5.2.20195.4.exe seems to be crashing on launch in a VM. Developer contacted

### Nimi Places
Shortcuts may not be showing in category with nimi places. A workaround can be conducted by changing your profile directory username and user directory to `user` i.e `C:\users\user\`

## Announcements

Initial WSL2 Implimentation
Initial GUI Implimentation

### In Development

GUI Replication that categorises each tool, similar to the Windows SIFT VM.
Implimentation of further tools upon request.

### Feedback / tool Requests

Please raise an issue for extra tools. Or, reopen #17

Attempting to reach out too Kroll again for Kape... requested numourous times

## Licencing

This script Is designed for non-commercial use, By installing these scripts, you agree to be bound by the vendors own licence agreement. No responsibility will be taken for licence misuse.

If you wish to use this script for commercial-use the following software requires licencing
- Arsenal Image Mounter
- FTK (With marketing sign up, by user consent popup at end of script)
- Event Log Explorer
- Kape #23 #10 (Waiting for vendor support from kroll)

## Pre-requisites

64 Bit Windows 10 1904 or above setup as default with username `user` so profiles direct to `C:\users\user` (Failure to do so results in shortcuts and nimiplaces not mapping correctly)

Virtualisation enabled in you're VM if you wish to use WSL

## Usage

Right click on the start menu, and select Administrative Command Prompt

Set the powershell execution policy with
`Set-ExecutionPolicy Unresticted`

Change to the downloaded directory i.e  
`cd $home\Downloads`

Install Chocolatey with
`.\Get-Chocolatey.ps1`

Install Git with
`.\Get-Git.ps1`

- *If Desired* Install WSL(Bash For Windows) with
  - `.\Get-WSL.ps1`
  - Then, Reboot

  - **After reboot**, install ubuntu with
  - `.\Get-Ubuntu`

Install Forensics Tools with
`.\Get-Forensics-Tools.ps1`

## Description

An open source project aimed to replicate the Windows SIFT Machine used during SANS Courses minus any payware software. This aims to install the same tools forensics analysts have trained with during their SANS Course, or to quickly prepare for a CTF, as there does not appear to be a similar VM available Open Source.

#### Licenced Software (Not Included)

- 4n6time
- Blacklight
- Browser History Examiner
- CSC Parser
- EnCase v7
- Findevil
- Foxtron Browser History Examiner
- FTK
- Hibrec
- Internet Evidence Finder
- PRTK
- Recycle Bin Parser
- Registry Recon
- TZWorks $USNJrnl Parser (JP)
- TZWorks Cafae
- TZWorks Event Log Viewer (evtx view)
- TZWorks GENA
- TZWorks Index.dat Parser (id64)
- TZWorks INDX Slack Parser (wisp64)
- TZWorks Jump List Parser (jmp64)
- TZWorks LNK File Parser
- TZWorks NTFS Directory Enum
- TZWorks NTFS Walk
- TZWorks PEView
- TZWorks Prefetch Parser
- TZWorks SBag x64 (Shellbags)
- TZWorks USB Storage Parser
- TZWorks YARU

### Unlicenced Software (Included)

- Chocolately GUI
- Chocolately Installer
- amcacheparser
- AppCompatCacheParser
- bstrings
- ESEDatabase View
- ExifDataView
- Hasher
- issGeolocate
- Jump List Explorer (JLECmd)
- LNK Explorer (LECmd)
- NirLauncher
- Prefetch Explorer (PECmd)
- RegFromApp
- Registry Explorer
- Shellbags Explorer
- TimeApp
- Sleuth Kit
- SysInternals Suite
- strings
- PhotoRec GUI
- Plaso
- Network Miner
- ExifTool
- ExifTool GUI
- Testdisk / PhotoRec
- Dcode Date
- Python2.7
- Python3.8
- Autopsy
- Rekall Forensics
- oclHashcat-plus
- wireshark
- yara
- HXD Hex Editor
- WinDBG
- Volatility Stand Alone Exe
- Unix Utils + 14-04-03 Updates
- sqlitebrowser
- SQLite Expert
- Shadow Explorer
- RegRipper
- Process Hacker
- prefetchparser (pecmd)
- winprefetchview
- Log Parser
- Disk2VHD
- Active State Active Perl
- GPG4Win
- Image Magick
- skypelogview
- skypecontactsview
- Universal Extractor
- WinMerge
- AgentRansack
- Thumbcache Viewer
- ExifToolGUI
- Thunderbird

### GUI Tools Included

- JRE8
- 7-Zip [#9](../../issues/9)
- AbobeAIR [#9](../../issues/9)
- Adobe Reader [#9](../../issues/9)
- FireFox [#9](../../issues/9)
- Flash Player Activex [#9](../../issues/9)
- Flash Player Plugin [#9](../../issues/9)
- Google Chrome [#9](../../issues/9)
- Java Runtime [#9](../../issues/9)
- Notepad++ [#9](../../issues/9)
- OpenOffice 4 [#9](../../issues/9)
- OpenVPN GUI [#9](../../issues/9)

## Developer contact

If you have any suggestions or feedback, or; Are the developer or copyright holder of a package you do not want included in this script, please raise an issue.
