bash "install_audiowaveform" do
  code <<-EOH
    sudo add-apt-repository -y ppa:chris-needham/ppa
    sudo apt-get update
    sudo apt-get install -y audiowaveform
    sudo apt-get update
  EOH

  not_if do
    File.exist?("/usr/local/bin/audiowaveform")
  end
end
