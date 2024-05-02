#!/bin/bash
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
# load nissessary modules
sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
# Update the system 
sudo apt-get update -y
sudo apt-get install containerd -y
#configure containerd 
sudo mkdir -p /etc/containerd
# you shoud first switch to root for this command 
sudo containerd config default > /etc/containerd/config.toml
# enable and start the service
sudo systemctl enable containerd
sudo systemctl start containerd
