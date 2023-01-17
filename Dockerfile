FROM --platform=linux/amd64 localhost/deb_build_base:latest

ARG gcc_ver=12.2.0

ENV ARCH=mips
ENV CROSS_COMPILE=/home/itron/uboot-toolchain/gcc-$gcc_ver-nolibc/mips-linux/bin/mips-linux-

RUN wget https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/$gcc_ver/x86_64-gcc-$gcc_ver-nolibc-mips-linux.tar.xz -P /home/itron/uboot-toolchain && \
    cd /home/itron/uboot-toolchain && tar xf x86_64-gcc-$gcc_ver-nolibc-mips-linux.tar.xz 

RUN cd && git clone --branch itron-hab-2023.01-rc4 git@github.com:fherbert/u-boot.git
RUN cd u-boot && git pull && make mrproper && make itron_hab01_defconfig && make -s -j4
WORKDIR /home/itron/u-boot

CMD ["bash"]
