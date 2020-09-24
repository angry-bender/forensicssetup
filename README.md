# WINSIFT ForensicsSetup Beta 0.3.1.2

## Contents

- [WINSIFT ForensicsSetup Beta 0.3.1.2](#winsift-forensicssetup-beta-0312)
  - [Contents](#contents)
  - [Announcements](#announcements)
  - [Description](#description)
    - [Licencing](#licencing)
      - [Licenced Software (Included) - Free Licence - Non-Commercial Use](#licenced-software-included---free-licence---non-commercial-use)
      - [Licenced Software (Not Included)](#licenced-software-not-included)
    - [Unlicenced Software (Included)](#unlicenced-software-included)
    - [Unlicenced Software (In Progress)](#unlicenced-software-in-progress)
    - [In Development](#in-development)
    - [Feedback / tool Requests](#feedback--tool-requests)
  - [Pre-requisites](#pre-requisites)
  - [Usage](#usage)
  - [Developer contact](#developer-contact)

## Announcements

Implimented the following software;

- Wireshark
- 
Fixed error logging
Stop sleep on machine
Stop screentimeout by pressing scrolllock between each script

## Description

An open source project to aimed to replicate the Windows SIFT Machine used during SANS Courses minus any payware software. This aims to install the same tools forensics anlaysts have trained with during their SANS Course, or to quickly prepare for a CTF, as there does not appear to be a similar VM available Open Source.

### Licencing

This script Is designed for non-commercial use, By installing these scripts, you agree to be bound by the vendors own licence agreement. No responsibility will be taken for licence misuse.

If you wish to use this script for commercial-use the following software requires licencing

#### Licenced Software (Included) - Free Licence - Non-Commercial Use

- Arsenal Image Mounter
- FTK (With marketing sign up) - Will work on user prompt to download free version by sign up, with user consent [#4](../../issues/4) [#10](../../issues/10)
- Event Log Explorer

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


### Unlicenced Software (In Progress)

- $LogFileParser
- 7-Zip [#9](../../issues/9)
- AbobeAIR [#9](../../issues/9)
- Active State Active Perl
- Adobe Reader [#9](../../issues/9)
- Advanced Prefetch Analyzer
- Auto_XOR_Decryptor.py
- Autorip
- BinText
- Bulk Extractor
- Converter
- cRaRk
- cRaRk GUI
- defraggler
- Diff.exe
- Disk2VHD
- EDD
- EMFSpoolerView
- ESECarve
- Findevil
- FireFox [#9](../../issues/9)
- FixEVT
- Flash Player Activex [#9](../../issues/9)
- Flash Player Plugin [#9](../../issues/9)
- Forensic Copy
- Forensic Image Viewer - FIV
- GA Cookie Cruncher
- Gmail Offline Parser
- Google Chrome [#9](../../issues/9)
- GPG4Win
- Hindsight
- Image Magick
- INDXParse (W. Ballenthin)
- Java Runtime [#9](../../issues/9)
- jl.exe
- jobparse.pl
- JRE8
- Kernel OST Viewer
- Kernel PST Viewer
- Log Parser
- lslnk-directory-parse2.pl
- Magnet Acquire
- MagnetRAMCapture
- Mandiant Highlighter
- Mandiant RedLine
- Mandiant RestorePoint Analyzer
- Mandiant Shimcache Parser
- MFT View
- MiTec Structured Storage View
- MiTec Windows Registry Analyzer
- Notepad++ [#9](../../issues/9)
- Nuix 6
- OpenOffice 4 [#9](../../issues/9)
- OpenVPN GUI [#9](../../issues/9)
- page_brute
- parse_csc_dir.exe
- Patator (password cracker)
- PC Inspector File Recovery
- pdbxtract


- Putty [#9](../../issues/9)
- Python_EVTX (W. Ballenthin)

- RecoverRS
- Recycle Bin Parser
- RegDecoder
- RegDecoderLive
- Registry and File Viewer
- Registry Decoder
- 
- rfc.pl
- rifiuti
- Rot13 String Decoder
- RUStrings.pl (Perl Script)
- SamInside
- Scalpel
- 
- Shadow Kit
- Shellbags
- Simple File Parser
- Skype Parser
- Spider3
- Spider4
- SPL Viewer
- SPL Viewer
- SQLIte Deleted Records Parser

- SRUM Dump
- SSDeep
- Strings
- TCHunt
- ThumbCache Viewer
- Thumbs Viewer
- TriForce
- Universal Extractor

- User Assist
- usnj.pl

- Volatility (zip with source)
- Volatility distrom
- Volatility openpyxl
- Volatility Pycrypto
- Volatility Python Imaging Library (PIL)
- 
- Volatility Twitter / Facebook Plugins
- Volatility yara
- VSC Toolset
- VSS
- Web Page Saver
- Wfa3e Tools
- Wfa4e Tools

- Windows Registry Recovery

- WinMerge
- winpmem

- Woanware Autorunner
- Woanware ChromeForensics
- Woanware ESEDbViewer
- Woanware EXE Finder
- Woanware FFSessionRestoreExt
- Woanware FireFoxForensics
- Woanware Forensic User Info
- Woanware Free D/L Mgr 4n6
- Woanware JavaIDX Parser
- Woanware JumpLister
- Woanware Link Analyser
- Woanware OperaForensics
- Woanware Prefetch Forensics
- Woanware RegRipperRunner
- Woanware ShimCache Parser
- Woanware Snortbert
- Woanware Target Analyser
- Woanware USB Device Forensics
- XORSearch
- XORStrings


### In Development

GUI Replication that categorises each tool, similar to the Windows SIFT VM.
Implimentation of further tools.

### Feedback / tool Requests

Please raise an issue for extra tools.

## Pre-requisites

64 Bit Windows 10 1904 or above setup as default.
Internet Explorer opened, with default settings selected.

## Usage

Install Chocolatey with
Get-Chocolatey.ps1

Install Git with
Get-Git.ps1

Install Forensics Tools with
Get-Forensics-Tools.ps1

## Developer contact

If you have any suggestions or feedback, or; Are the developer or copyright holder of a package you do not want included in this script, please raise an issue.
