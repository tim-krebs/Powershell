# Powershell

PowerShell Core is a cross-platform (Windows, Linux, and macOS) automation and configuration tool/framework that works well with your existing tools and is optimized
for dealing with structured data (e.g. JSON, CSV, XML, etc.), REST APIs, and object models.
It includes a command-line shell, an associated scripting language and a framework for processing cmdlets.

## Get PowerShell

You can download and install a PowerShell package for any of the following platforms.

| Supported Platform                         | Download (LTS)          | Downloads (stable)      | Downloads (preview)   | How to Install                |
| -------------------------------------------| ------------------------| ------------------------| ----------------------| ------------------------------|
| [Windows (x64)][corefx-win]                | [.msi][lts-windows-64]  | [.msi][rl-windows-64]   | [.msi][pv-windows-64] | [Instructions][in-windows]    |
| [Windows (x86)][corefx-win]                | [.msi][lts-windows-86]  | [.msi][rl-windows-86]   | [.msi][pv-windows-86] | [Instructions][in-windows]    |
| [Ubuntu 20.04][corefx-linux]               | [.deb][lts-deb]         | [.deb][rl-ubuntu20]     | [.deb][pv-deb]        | [Instructions][in-ubuntu20]   |
| [Ubuntu 18.04][corefx-linux]               | [.deb][lts-deb]         | [.deb][rl-ubuntu18]     | [.deb][pv-deb]        | [Instructions][in-ubuntu18]   |
| [Ubuntu 16.04][corefx-linux]               | [.deb][lts-deb]         | [.deb][rl-ubuntu16]     | [.deb][pv-deb]        | [Instructions][in-ubuntu16]   |
| [Debian 9][corefx-linux]                   | [.deb][lts-deb]         | [.deb][rl-debian9]      | [.deb][pv-deb]        | [Instructions][in-deb9]       |
| [Debian 10][corefx-linux]                  | [.deb][lts-deb]         | [.deb][rl-debian10]     | [.deb][pv-deb]        | [Instructions][in-deb9]       |
| [Debian 11][corefx-linux]                  | [.deb][lts-deb]         | [.deb][rl-debian11]     | [.deb][pv-deb]        |                               |
| [CentOS 7][corefx-linux]                   | [.rpm][lts-rh]          | [.rpm][rl-centos]       | [.rpm][pv-rpm]        | [Instructions][in-centos]     |
| [CentOS 8][corefx-linux]                   | [.rpm][lts-rh]          | [.rpm][rl-centos8]      | [.rpm][pv-rpm]        |                               |
| [Red Hat Enterprise Linux 7][corefx-linux] | [.rpm][lts-rh]          | [.rpm][rl-centos]       | [.rpm][pv-rpm]        | [Instructions][in-rhel7]      |
| [openSUSE 42.3][corefx-linux]              | [.rpm][lts-rh]          | [.rpm][rl-centos]       | [.rpm][pv-rpm]        | [Instructions][in-opensuse]   |
| [Fedora 30][corefx-linux]                  | [.rpm][lts-rh]          | [.rpm][rl-centos]       | [.rpm][pv-rpm]        | [Instructions][in-fedora]     |
| [macOS 10.13+ (x64)][corefx-macos]         | [.pkg][lts-macos]       | [.pkg][rl-macos]        | [.pkg][pv-macos]      | [Instructions][in-macos]      |
| [macOS 10.13+ (arm64)][corefx-macos]       | [.pkg][lts-macos-arm64] | [.pkg][rl-macos-arm64]  | [.pkg][pv-macos-arm64]| [Instructions][in-macos]      |
| Docker                                     |                         |                         |                       | [Instructions][in-docker]     |

You can download and install a PowerShell package for any of the following platforms, **which are supported by the community.**

| Platform                 | Downloads (stable)      | Downloads (preview)           | How to Install                |
| -------------------------| ------------------------| ----------------------------- | ------------------------------|
| Arch Linux               |                         |                               | [Instructions][in-archlinux]  |
| Kali Linux               | [.deb][rl-ubuntu16]     | [.deb][pv-deb]           | [Instructions][in-kali]       |
| Many Linux distributions | [Snapcraft][rl-snap]    | [Snapcraft][pv-snap]          |                               |

You can also download the PowerShell binary archives for Windows, macOS and Linux.

| Platform       | Downloads (stable)                                  | Downloads (preview)                             | How to Install                                 |
| ---------------| --------------------------------------------------- | ------------------------------------------------| -----------------------------------------------|
| Windows        | [32-bit][rl-winx86-zip]/[64-bit][rl-winx64-zip]     | [32-bit][pv-winx86-zip]/[64-bit][pv-winx64-zip] | [Instructions][in-windows-zip]                 |
| macOS (x64)    | [64-bit][rl-macos-tar]                              | [64-bit][pv-macos-tar]                          | [Instructions][in-tar-macos]                   |
| macOS (arm64)  | [64-bit][rl-macos-tar-arm64]                        | [64-bit][pv-macos-tar-arm64]                    | [Instructions][in-tar-macos]                   |
| Linux          | [64-bit][rl-linux-tar]                              | [64-bit][pv-linux-tar]                          | [Instructions][in-tar-linux]                   |
| Windows (Arm)  | [64-bit][rl-winarm64] (preview)                     | [64-bit][pv-winarm64]                           | [Instructions][in-arm]                         |
| Raspbian (Arm) | [32-bit][rl-arm32]/[64-bit][rl-arm64]               | [32-bit][pv-arm32]/[64-bit][pv-arm64]           | [Instructions][in-raspbian]                    |

[lts-windows-86]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/PowerShell-7.2.2-win-x86.msi
[lts-windows-64]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/PowerShell-7.2.2-win-x64.msi
[lts-deb]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-lts_7.2.2-1.deb_amd64.deb
[lts-rh]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-lts-7.2.2-1.rh.x86_64.rpm
[lts-macos]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-lts-7.2.2-osx-x64.pkg
[lts-macos-arm64]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-lts-7.2.2-osx-arm64.pkg

[rl-windows-64]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/PowerShell-7.2.2-win-x64.msi
[rl-windows-86]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/PowerShell-7.2.2-win-x86.msi
[rl-ubuntu20]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell_7.2.2-1.deb_amd64.deb
[rl-ubuntu18]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell_7.2.2-1.deb_amd64.deb
[rl-ubuntu16]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell_7.2.2-1.deb_amd64.deb
[rl-debian9]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell_7.2.2-1.deb_amd64.deb
[rl-debian10]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell_7.2.2-1.deb_amd64.deb
[rl-debian11]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell_7.2.2-1.deb_amd64.deb
[rl-centos]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-7.2.2-1.rh.x86_64.rpm
[rl-centos8]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-7.2.2-1.rh.x86_64.rpm
[rl-macos]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-7.2.2-osx-x64.pkg
[rl-macos-arm64]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-7.2.2-osx-arm64.pkg
[rl-winarm64]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/PowerShell-7.2.2-win-arm64.zip
[rl-winx86-zip]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/PowerShell-7.2.2-win-x86.zip
[rl-winx64-zip]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/PowerShell-7.2.2-win-x64.zip
[rl-macos-tar]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-7.2.2-osx-x64.tar.gz
[rl-macos-tar-arm64]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-7.2.2-osx-arm64.tar.gz
[rl-linux-tar]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-7.2.2-linux-x64.tar.gz
[rl-arm32]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-7.2.2-linux-arm32.tar.gz
[rl-arm64]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-7.2.2-linux-arm64.tar.gz
[rl-snap]: https://snapcraft.io/powershell

[pv-windows-64]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/PowerShell-7.3.0-preview.3-win-x64.msi
[pv-windows-86]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/PowerShell-7.3.0-preview.3-win-x86.msi
[pv-deb]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/powershell-preview_7.3.0-preview.3-1.deb_amd64.deb
[pv-rpm]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/powershell-preview-7.3.0_preview.3-1.rh.x86_64.rpm
[pv-macos]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/powershell-7.3.0-preview.3-osx-x64.pkg
[pv-macos-arm64]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/powershell-7.3.0-preview.3-osx-arm64.pkg
[pv-winarm64]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/PowerShell-7.3.0-preview.3-win-arm64.zip
[pv-winx86-zip]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/PowerShell-7.3.0-preview.3-win-x86.zip
[pv-winx64-zip]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/PowerShell-7.3.0-preview.3-win-x64.zip
[pv-macos-tar]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/powershell-7.3.0-preview.3-osx-x64.tar.gz
[pv-macos-tar-arm64]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/powershell-7.3.0-preview.3-osx-arm64.tar.gz
[pv-linux-tar]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/powershell-7.3.0-preview.3-linux-x64.tar.gz
[pv-arm32]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/powershell-7.3.0-preview.3-linux-arm32.tar.gz
[pv-arm64]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.3/powershell-7.3.0-preview.3-linux-arm64.tar.gz
[pv-snap]: https://snapcraft.io/powershell-preview

[in-windows]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-windows
[in-ubuntu16]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#ubuntu-1604
[in-ubuntu18]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#ubuntu-1804
[in-ubuntu20]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#ubuntu-2004
[in-deb9]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#debian-9
[in-deb10]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#debian-10
[in-centos]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#centos-7
[in-rhel7]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#red-hat-enterprise-linux-rhel-7
[in-opensuse]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#opensuse
[in-fedora]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#fedora
[in-archlinux]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#arch-linux
[in-macos]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-macos
[in-docker]: https://github.com/PowerShell/PowerShell-Docker
[in-kali]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#kali
[in-windows-zip]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-windows#zip
[in-tar-linux]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#binary-archives
[in-tar-macos]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-macos#binary-archives
[in-raspbian]: https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux#raspbian
[in-arm]: https://docs.microsoft.com/powershell/scripting/install/powershell-core-on-arm
[corefx-win]:https://github.com/dotnet/core/blob/master/release-notes/3.0/3.0-supported-os.md#windows
[corefx-linux]:https://github.com/dotnet/core/blob/master/release-notes/3.0/3.0-supported-os.md#linux
[corefx-macos]:https://github.com/dotnet/core/blob/master/release-notes/3.0/3.0-supported-os.md#macos

To install a specific version, visit [releases](https://github.com/PowerShell/PowerShell/releases).

## Getting Started with PowerShell

If you are new to PowerShell and would like to learn more, we recommend reviewing the [getting started][] documentation.

[getting started]: https://github.com/tim-krebs/Powershell/tree/main/docs/learning-powershell
Now you have learned the basics of PowerShell.

### PowerShell Editor

In this section, you will create a PowerShell script using a text editor.
You can use your favorite editor to write scripts.
We use Visual Studio Code (VS Code) which works on Windows, Linux, and macOS.
Click on the following link to create your first PowerShell script.

- [Using Visual Studio Code (VS Code)](https://docs.microsoft.com/powershell/scripting/dev-cross-plat/vscode/using-vscode)


### Recommended Training and Reading

- Microsoft Virtual Academy: [Getting Started with PowerShell][getstarted-with-powershell]
- [Why Learn PowerShell][why-learn-powershell] by Ed Wilson
- PowerShell Web Docs: [Basic cookbooks][basic-cookbooks]
- [The Guide to Learning PowerShell][ebook-from-Idera] by Tobias Weltner
- [PowerShell-related Videos][channel9-learn-powershell] on Channel 9
- [PowerShell Quick Reference Guides][quick-reference] by PowerShellMagazine.com
- [Learn PowerShell Video Library][idera-learn-powershell] from Idera
- [PowerShell 5 How-To Videos][script-guy-how-to] by Ed Wilson
- [PowerShell Documentation](https://docs.microsoft.com/powershell)
- [Interactive learning with PSKoans](https://aka.ms/pskoans)

### Commercial Resources

- [Windows PowerShell in Action][in-action] by [Bruce Payette](https://github.com/brucepay)
- [Introduction to PowerShell][powershell-intro] from Pluralsight
- [PowerShell Training and Tutorials][lynda-training] from Lynda.com
- [Learn Windows PowerShell in a Month of Lunches][learn-win-powershell] by Don Jones and Jeffrey Hicks
- [Learn PowerShell in a Month of Lunches][learn-powershell] by Travis Plunk (@TravisEz13),
  Tyler Leonhardt (@tylerleonhardt), Don Jones, and Jeffery Hicks

[in-action]: https://www.amazon.com/Windows-PowerShell-Action-Second-Payette/dp/1935182137
[powershell-intro]: https://www.pluralsight.com/courses/powershell-intro
[lynda-training]: https://www.lynda.com/PowerShell-training-tutorials/5779-0.html
[learn-win-powershell]: https://www.amazon.com/Learn-Windows-PowerShell-Month-Lunches/dp/1617294160
[learn-powershell]: https://www.manning.com/books/learn-powershell-in-a-month-of-lunches

[getstarted-with-powershell]: https://channel9.msdn.com/Series/GetStartedPowerShell3
[why-learn-powershell]: https://blogs.technet.microsoft.com/heyscriptingguy/2014/10/18/weekend-scripter-why-learn-powershell/
[ebook-from-Idera]:https://www.idera.com/resourcecentral/whitepapers/powershell-ebook
[channel9-learn-powershell]: https://channel9.msdn.com/Search?term=powershell#ch9Search
[idera-learn-powershell]: https://community.idera.com/database-tools/powershell/video_library/
[quick-reference]: https://www.powershellmagazine.com/2014/04/24/windows-powershell-4-0-and-other-quick-reference-guides/
[script-guy-how-to]:https://blogs.technet.microsoft.com/tommypatterson/2015/09/04/ed-wilsons-powershell5-videos-now-on-channel9-2/
[basic-cookbooks]:https://docs.microsoft.com/powershell/scripting/samples/sample-scripts-for-administration