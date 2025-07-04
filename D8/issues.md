efaulted container "kube-flannel" out of: kube-flannel, install-cni-plugin (init), install-cni (init)
I0702 06:18:46.460602       1 main.go:211] CLI flags config: {etcdEndpoints:http://127.0.0.1:4001,http://127.0.0.1:2379 etcdPrefix:/coreos.com/network etcdKeyfile: etcdCertfile: etcdCAFile: etcdUsername: etcdPassword: version:false kubeSubnetMgr:true kubeApiUrl: kubeAnnotationPrefix:flannel.alpha.coreos.com kubeConfigFile: iface:[] ifaceRegex:[] ipMasq:true ifaceCanReach: subnetFile:/run/flannel/subnet.env publicIP: publicIPv6: subnetLeaseRenewMargin:60 healthzIP:0.0.0.0 healthzPort:0 iptablesResyncSeconds:5 iptablesForwardRules:true netConfPath:/etc/kube-flannel/net-conf.json setNodeNetworkUnavailable:true}
W0702 06:18:46.460828       1 client_config.go:659] Neither --kubeconfig nor --master was specified.  Using the inClusterConfig.  This might not work.
I0702 06:18:46.479162       1 kube.go:139] Waiting 10m0s for node controller to sync
I0702 06:18:46.479250       1 kube.go:469] Starting kube subnet manager
I0702 06:18:46.483215       1 kube.go:490] Creating the node lease for IPv4. This is the n.Spec.PodCIDRs: [10.244.3.0/24]
I0702 06:18:46.483259       1 kube.go:490] Creating the node lease for IPv4. This is the n.Spec.PodCIDRs: [10.244.2.0/24]
I0702 06:18:46.483270       1 kube.go:490] Creating the node lease for IPv4. This is the n.Spec.PodCIDRs: [10.244.0.0/24]
I0702 06:18:47.479512       1 kube.go:146] Node controller sync successful
I0702 06:18:47.479651       1 main.go:231] Created subnet manager: Kubernetes Subnet Manager - ip-172-31-26-45
I0702 06:18:47.479659       1 main.go:234] Installing signal handlers
I0702 06:18:47.480165       1 main.go:479] Found network config - Backend type: vxlan
E0702 06:18:47.480241       1 main.go:268] Failed to check br_netfilter: stat /proc/sys/net/bridge/bridge-nf-call-iptables: no such file or directory


==============================
* For the above error

sudo modprobe br_netfilter
 
echo "br_netfilter" | sudo tee /etc/modules-load.d/br_netfilter.conf
 
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system
 
sudo systemctl restart kubelet