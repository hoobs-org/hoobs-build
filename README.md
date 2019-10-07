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

Navigate to the hoobs-connect project root folder and run this.

```bash
./build.sh
```

Move `wifi-connect-hoobs.tar.gz` to the `stage3/02-wifi-connect/files` folder.

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