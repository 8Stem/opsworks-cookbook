bash "install_ffmpeg" do
  user "root"
  code <<-EOH
    sudo apt-get update
    sudo apt-get install curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs
    sudo apt-get install libtag1-dev
    sudo add-apt-repository ppa:mc3man/trusty-media
    sudo apt-get update
    sudo apt-get dist-upgrade
    sudo apt-get install ffmpeg
  EOH

  not_if do
    File.exist?("/usr/local/bin/ffmpeg")
  end
end