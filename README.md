![](https://raw.githubusercontent.com/hoobs-org/HOOBS/master/docs/logo.png)

## HOOBS Image Generator
Tool used to create the HOOBS Raspbian image.


## Dependencies
Debian is required to run the build process.

Install the required dependencies.

```bash
apt-get install -y coreutils quilt parted qemu-user-static debootstrap zerofree zip dosfstools bsdtar libcap2-bin grep rsync xz-utils file git curl
```

## Building WiFi Connect
HOOBS usess custom build of WiFi Connect. However only the UI changes. Download the latest build of WiFi Connect.

[https://github.com/balena-io/wifi-connect/releases](https://github.com/balena-io/wifi-connect/releases)

Extract and remove the `ui` folder. Then copy the `ui` folder from the HOOBS `wifi-connect` project.

Then rename the folder to this `wifi-connect-4.2.10-hoobs`.

Navigate to the extracted folder and run this.

```bash
tar -cvzf ui.tar.gz ./ui/*
```

Then back up one filder and run this.

```bash
tar -cvzf wifi-connect-4.2.10-hoobs.tar.gz ./wifi-connect-4.2.10-hoobs/*
```

Move `wifi-connect-4.2.10-hoobs.tar.gz` to the `rpi-image/assets` folder.

Adjust the CUI_VERSION and CUI_RELEASE_URL in the `rpi-image/stage3/02-wifi-connect/raspbian-install.sh` file.

## Building
On the build computer navigate to the `rpi-image` project folder.

Update the code.

```bash
git pull
```

Then run the build.

```bash
sudo ./build.sh -c config
```

Once finished the image can be found in the `deploy` folder.