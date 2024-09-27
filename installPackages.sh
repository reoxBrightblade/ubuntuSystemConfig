#!/bin/zsh

echo '********************************************************************************'

echo '***** Configurando contraseña de root' && sleep 2
sudo su
passwd
exit

echo '***** Instalando mensajeria'
sudo snap install whatsdesk telegram-desktop spotify mailspring discord
sudo snap install code --classic

echo '***** Actualizando el sistema' && sleep 2
sudo apt update && sudo apt -y full-upgrade && sudo apt install -y curl add-apt-key

echo '***** Agregando repositorios'
sudo dpkg --add-architecture i386 -y
sudo add-apt-repository universe -y
sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-key del 7fa2af80
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb && rm cuda-keyring_1.1-1_all.deb
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-archive-keyring.gpg
sudo mv cuda-archive-keyring.gpg /usr/share/keyrings/cuda-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" | sudo tee /etc/apt/sources.list.d/cuda-ubuntu2204/x86_64.list
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo echo '### LLVM\ndeb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main\ndeb-src http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main' >> /etc/apt/sources.list
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sudo tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc > /dev/null
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
sudo apt update > /dev/null
sleep 5

echo '***** Instalando programas y paqueteria básica' && sleep 2
sudo apt install -y ubuntu-restricted-extras build-essential tilix git htop nvtop gdu zsh gnome-tweaks \
gnome-shell-extensions nautilus-dropbox nautilus-dropbox mpv neofetch unrar transmission-gtk \
speedtest-cli gnome-calendar python3-pip ttf-mscorefonts-installer qml-module-qtquick-controls openssh-server \
software-properties-common net-tools xz-utils environment-modules sqlite3 gdbmtool gnupg icecc moreutils ubuntu-dev-tools \
ca-certificates gcc-12 g++-12 gfortran-12 bison yacc byacc inxi gperf autogen guile-3.0 texinfo texify texlive sphinx \
gfortran-11 gawk gdc-12 m4 ncurses-term linux-headers-$(uname -r) qemu qemu-system qemu-user-static cmake flex
sleep 5

echo '***** Instalando librerías' && sleep 2
sudo apt install -y libncurses-dev libqt5svg5 libssl-dev libgmp-dev libmpfr-dev glibc-tools libpurelibc-dev \
libffi-dev zlib1g-dev libmpc-dev libsisl-dev  libreadline-dev libncursesw5-dev libsqlite3-dev tk-dev libgdbm-dev \
libc6-dev libbz2-dev libncurses5-dev  liblzma-dev libmpdec-dev libopenblas-dev autotools-dev giblib-dev \
libcqrlib-dev libopenlibm-dev libzstd-dev libisl-dev libintelrdfpmath-dev libtool-bin binutils-dev
sleep 5

echo '***** Instalando NVIDIA drivers y CUDA 12' && sleep 2
sudo apt install cuda-toolkit nvidia-gds cudnn-cuda-12 
sudo apt purge -y nvidia-kernel-source-560-open && sudo apt install -V cuda-drivers-560 -y
sudo apt install -y libnvidia-compute-560:i386 libnvidia-decode-560:i386 libnvidia-encode-560:i386 \
libnvidia-extra-560:i386 libnvidia-fbc1-560:i386 libnvidia-gl-560:i386
sleep 5

echo '***** Instalando navegador Brave' && sleep 2
sudo apt install -y brave-browser
sleep 5

echo '***** Instalando Docker' && sleep 2
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sleep 5

echo '***** Instalando OBS Studio' && sleep 2
sudo apt install -y obs-studio
sleep 5

echo '***** Instalando compiladores LLVM y Clang 17' && sleep 2
sudo apt install -y libllvm-17-ocaml-dev libllvm17 llvm-17 llvm-17-dev llvm-17-doc llvm-17-examples \
llvm-17-runtime clang-17 clang-tools-17 clang-17-doc libclang-common-17-dev libclang-17-dev libclang1-17 \
clang-format-17 python3-clang-17 clangd-17 clang-tidy-17 libclang-rt-17-dev lld-17 lldb-17 libc++-17-dev \
libc++abi-17-dev
sleep 5

echo '***** Instalando compilador Bazel' && sleep 2
sudo apt install -y bazel default-jdk
sleep 5