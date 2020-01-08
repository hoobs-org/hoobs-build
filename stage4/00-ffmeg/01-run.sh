on_chroot << EOF
uname -a

set -e
set -x

rm -fR ./fdk-aac
git clone https://github.com/hoobs-org/fdk-aac.git
cd ./fdk-aac

./autogen.sh
./configure --prefix=/usr/local --enable-shared --enable-static --enable-cross-compile

make -j4

make install
ldconfig

cd ../
rm -fR ./fdk-aac

rm -fR ./ffmpeg
git clone https://github.com/hoobs-org/ffmpeg.git
cd ./ffmpeg

./configure --prefix=/usr/local --arch=armel --target-os=linux --enable-omx-rpi --enable-nonfree --enable-gpl --enable-libfdk-aac --enable-mmal --enable-libx264 --enable-decoder=h264 --enable-network --enable-protocol=tcp --enable-demuxer=rtsp --enable-cross-compile
make -j4

make install

cd ../
rm -fR ./ffmpeg
EOF