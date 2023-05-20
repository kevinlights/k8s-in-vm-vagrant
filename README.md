

```shell
vagrant up
vagrant ssh
vagrant destroy
vagrant ssh k8s-master
vagrant ssh k8s-worker1
vagrant status

vagrant up > k8s.log

sudo kubeadm join k8s-master:6443 --token z8ypvo.ftcbgxlutbyaq236 --discovery-token-ca-cert-hash sha256:3e9c12fde031575edcbe602fd6b1dc3155fb63924ed51f8fa89da69f66ff0687

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/kubelet.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo chown $(id -u):$(id -g) /var/lib/kubelet/pki/kubelet-client-current.pem

kubectl cluster-info
kubectl get nodes
kubectl get pods -A
```