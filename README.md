#### Dosemu2 packaging

This project is purely to download and produce native distro packages of the latest version of Dosemu2 and its dependencies. Where possible it uses the distro's standard libraries, only adding or upgrading what is necessary for the build.

Currently packages are built for the following:

|Distro| Architecture|
|------|------|
|Debian 12 | arm64|
|| i386|
|| amd64|
|Debian 13 | arm64|
|| i386|
|| amd64|
|RaspiOS Bookworm | 64 bit|
|RaspiOS Trixie | 64 bit|

##### Notes:
- Above packages are found in the [Actions](https://github.com/andrewbird/packaging/actions) in each run's
  job artifacts. The uppermost run is the latest and you must be logged in to Github to see the artifacts.
- Ubuntu packages are provided in Dosemu2's [PPA](https://code.launchpad.net/~dosemu2/dosemu2/+git/dosemu2).
- RaspiOS 32 packages are not possible at this time due to a missing cross compiling tool.
