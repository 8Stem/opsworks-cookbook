directory "/efs" do
  mode 0755
  owner 'root'
  group 'root'
  action :create
end

mount "/efs" do
  device "fs-1de72bb4.efs.us-west-2.amazonaws.com:/"
  fstype "nfs4"
  options "nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2"
  action [:mount, :enable]
end
