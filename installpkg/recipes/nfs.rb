bash "mount_nfs" do
  directory "/efs" do
    mode 0755
    owner 'root'
    group 'root'
    action :create
  end
    
  code <<-EOH
    sudo apt-get install nfs-common
    sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 fs-1de72bb4.efs.us-west-2.amazonaws.com:/ efs
  EOH

  not_if do
    File.exist?("/efs")
  end
end
