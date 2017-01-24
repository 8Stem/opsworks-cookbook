bash "install_ffmpeg" do
  code <<-EOH
    # install dependencies
    sudo apt-get update
    sudo apt-get -y install autoconf automake build-essential libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev   libxcb-xfixes0-dev pkg-config texinfo zlib1g-dev

    # install yasm
    sudo apt-get -y install yasm

    # install libx264
    sudo apt-get -y install libx264-dev

    # install libx265
    sudo apt-get -y install cmake mercurial
    mkdir ~/ffmpeg_sources
    cd ~/ffmpeg_sources
    hg clone https://bitbucket.org/multicoreware/x265
    cd ~/ffmpeg_sources/x265/build/linux
    PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/usr/local" -DENABLE_SHARED:bool=off ../../source
    make
    sudo make install
    # make distclean

    # install libfdk-aac
    sudo apt-get -y install libfdk-aac-dev

    # install libmp3lame
    sudo apt-get -y install libmp3lame-dev

    # install libopus
    sudo apt-get -y install libopus-dev

    # install ffmpeg
    cd ~/ffmpeg_sources
    wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
    tar xjvf ffmpeg-snapshot.tar.bz2
    cd ffmpeg
    PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="/usr/local/lib/pkgconfig" ./configure \
      --prefix="/usr/local" \
      --pkg-config-flags="--static" \
      --extra-cflags="-I$HOME/ffmpeg_build/include" \
      --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
      --host-cppflags="-fPIC" \
      --bindir="/usr/local/bin" \
      --enable-avresample \
      --enable-gpl \
      --enable-libass \
      --enable-libfdk-aac \
      --enable-libfreetype \
      --enable-libmp3lame \
      --enable-libopus \
      --enable-libvorbis \
      --enable-libx264 \
      --enable-libx265 \
      --enable-nonfree \
      --enable-shared
    PATH="$HOME/bin:$PATH" make
    sudo make install
    # make distclean
    hash -r

    # install requirements for libkeyfinder
    sudo apt-get -y install qt5-default libfftw3-3 libfftw3-dev

    # install libkeyfinder
    cd ~
    git clone https://github.com/ibsh/libKeyFinder.git
    cd libKeyFinder
    qmake
    make
    sudo make install

    # install libkeyfinder-cli
    cd ~
    git clone https://github.com/EvanPurkhiser/keyfinder-cli.git
    cd keyfinder-cli
    make 
    sudo make install
    sudo ldconfig

    # test that they were built and run
    cd ~
    ffmpeg
    keyfinder-cli
  EOH

  not_if do
    File.exist?("/usr/local/bin/ffmpeg")
  end
end

bash "install_ffmpeg_from_package" do
  user "root"
  code <<-EOH
    sudo apt-get update
    sudo apt-get install curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs
    sudo apt-get install libtag1-dev
    sudo ppa-purge ppa:mc3man/trusty-media
    sudo add-apt-repository ppa:mc3man/trusty-media
    sudo apt-get update
    sudo apt-get dist-upgrade
    sudo apt-get install ffmpeg
  EOH

  not_if do
    File.exist?("/usr/local/bin/ffmpeg")
  end
end
