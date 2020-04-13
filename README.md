# OpenAirInterface on Kubernetes for Ubuntu

openair-k8s-ubuntu is inspired by OPENAIRINTERFACE/openair-k8s and can be built on Docker, Kubernetes, and Ubuntu distribution. Currently, we tested some operation of each component alone with Ubuntu 18.04.3 LTS (Bionic).

Note: We used  Ubuntu 18.04.3 LTS (Bionic), Docker CE 19.03, OAI(RAN) 1.2.1, and OAI-CN/CUPS develop-vco3 branch as test environment.

## Building OAI Container Images

### Prerequisites for all nodes

#### Upgrade to low-latency kernel (for realtime handling)
```
sudo apt update
sudo apt install -y 
sudo apt-get install -y linux-image-5.3.0-42-lowlatency linux-headers-5.3.0-42-lowlatency
sudo reboot
```

#### Disabling Swap
```
sudo swapoff -a
```

#### Setting kernel parameters and disabling iptables with nftables
```
sudo cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system

# Disable iptables with nftables
sudo apt-get install -y iptables arptables ebtables

sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
sudo update-alternatives --set arptables /usr/sbin/arptables-legacy
sudo update-alternatives --set ebtables /usr/sbin/ebtables-legacy
```

#### Installing Docker CE
```
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg2 pass
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update && sudo apt-get install -y containerd.io=1.2.10-3 docker-ce=5:19.03.4~3-0~ubuntu-$(lsb_release -cs) docker-ce-cli=5:19.03.4~3-0~ubuntu-$(lsb_release -cs)
sudo cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "features": {
    "buildkit": true
  }
}
EOF
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo systemctl daemon-reload
sudo systemctl restart docker
```

### Prerequisites for e-NodeB nodes

#### Installing a tool to control some hardware devices.
```
sudo apt install -y cpufrequtils
echo 'GOVERNOR="performance"' | tee -a /etc/default/cpufrequtils
```

#### Configuration of kernel modules and GRUB parameters
```
echo "blacklist intel_powerclamp" | sudo tee -a /etc/modprobe.d/blacklist.conf
sudo vim /etc/default/grub
=> Added the following parameters
GRUB_CMDLINE_LINUX_DEFAULT="intel_pstate=disable processor.max_cstate=1 intel_idle.max_cstate=0 idle=poll"
```
