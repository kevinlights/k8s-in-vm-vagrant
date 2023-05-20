sudo sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
sudo apt update
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

sudo apt install -y apt-transport-https ca-certificates curl libseccomp2
sudo curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update 
sudo apt install -y kubelet=1.23.0-00 kubeadm=1.23.0-00 kubectl=1.23.0-00
sudo apt-mark hold kubelet kubeadm kubectl
mkdir -p /tmp/docker-bionic
wget -q -P /tmp/docker-bionic https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/containerd.io_1.6.21-1_amd64.deb https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-cli_24.0.1-1~ubuntu.18.04~bionic_amd64.deb https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_24.0.1-1~ubuntu.18.04~bionic_amd64.deb https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-buildx-plugin_0.10.4-1~ubuntu.18.04~bionic_amd64.deb https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-compose-plugin_2.18.1-1~ubuntu.18.04~bionic_amd64.deb
sudo dpkg -i /tmp/docker-bionic/*.deb
sudo rm -rf /tmp/docker-bionic
echo "{\"exec-opts\":[\"native.cgroupdriver=systemd\"],\"log-driver\":\"json-file\",\"log-opts\":{\"max-size\":\"100m\"},\"storage-driver\":\"overlay2\"}" | sudo tee /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl start containerd
sudo systemctl enable containerd
sudo usermod -aG docker $USER
newgrp docker

sudo ufw disable
sudo apt install selinux-utils
setenforce 0

echo KUBELET_EXTRA_ARGS=\"--cgroup-driver=cgroupfs\" | sudo tee /etc/default/kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet
sudo rm -rf /etc/containerd/config.toml
sudo systemctl restart containerd

free -h 
echo "192.168.56.100 k8s-master" | sudo tee -a /etc/hosts
cat /etc/hosts

id

# sudo kubeadm join [master-node-ip]:6443 --token abcdef.1234567890abcdef --discovery-token-ca-cert-hash sha256:1234..cdef
# sudo kubeadm join 192.168.56.100:6443 --token yrclr9.rk4gqhv1ygee9kmb --discovery-token-ca-cert-hash sha256:029a30436a432e5b201caa71268cd11f4d305efa2e236586ea1558ad4b3e5ab8

# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/kubelet.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config
# sudo chown $(id -u):$(id -g) /var/lib/kubelet/pki/kubelet-client-current.pem