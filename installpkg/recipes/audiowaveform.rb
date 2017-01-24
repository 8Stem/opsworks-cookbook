bash "install_audiowaveform" do
  code <<-EOH
    sudo add-apt-repository ppa:chris-needham/ppa
    sudo apt-get update
    sudo apt-get install audiowaveform
    sudo apt-get update
  EOH

  not_if do
    File.exist?("/usr/local/bin/audiowaveform")
  end
end
