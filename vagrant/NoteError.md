khi sử dụng 
  config.ssh.private_key_path = File.expand_path("./.ssh/insecure_private_key")
  config.ssh.insert_key = false
bị lỗi:
   manager1: Warning: Authentication failure. Retrying...

không sử dụng:
  vagrant ssh manager1  --> ko connect đc
  vagrant ssh manager1 -- -i C:/Users/admin/.vagrant.d/boxes/my_box_docker/0/virtualbox/vagrant_private_key  --> ko connect đc
  vagrant ssh manager1 -- -i vagrant ssh manager1 -- -i ./.ssh/insecure_private_key  --> ko connect đc
  ssh -i ./.ssh/insecure_private_key vagrant@192.168.56.11 -p 2222
  ssh -i ./.ssh/insecure_private_key vagrant@127.0.0.1 -p 2222
  ssh -i C:/Users/admin/.vagrant.d/boxes/my_box_docker/0/virtualbox/vagrant_private_key vagrant@127.0.0.1 -p 2222
  ssh -i C:/Users/admin/.vagrant.d/boxes/my_box_docker/0/virtualbox/vagrant_private_key vagrant@192.168.56.11 -p 2222
  vagrant ssh manager1 -- -i C:/Users/admin/.vagrant.d/boxes/my_box_docker/0/virtualbox/vagrant_private_key
=>> lỗi: Permission denied (publickey) 

tạo box nếu sử dụng  config.ssh.insert_key = false thì ko tạo được máy ảo để tạo box 
như nếu có dùng thi máy
