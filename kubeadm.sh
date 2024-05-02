#!/bin/bash

# update the system
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl
# Download the public signing key for the Kubernetes package repositories.
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
#Update the apt package index, install kubelet, kubeadm and kubectl, and pin their version
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl start kubelet 
sudo systemctl enable kubelet
sudo mkdir -m 755 /etc/apt/keyrings

# Initialize the cluster with kubeadm 
sudo kubeadm init 

Your Kubernetes control-plane has initialized successfully!

#To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

#You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

#Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.1.27:6443 --token 9ujkzt.iaohgh266iki7487 \
        --discovery-token-ca-cert-hash sha256:1f4ffed3ff7b158c613d85f744f903acde61b4d925d0de546e0d094f49c4e4c0

