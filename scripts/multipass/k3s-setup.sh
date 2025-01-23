multipass launch --cpus 2 --disk 20G --memory 4G --name k3s-main
multipass launch --cpus 2 --disk 20G --memory 4G --name k3s-first
multipass launch --cpus 2 --disk 20G --memory 4G --name k3s-second


multipass exec k3s-main -- bash -c "curl -sfL https://get.k3s.io | sh -"
TOKEN=$(multipass exec k3s-main sudo cat /var/lib/rancher/k3s/server/node-token)
IP=$(multipass info k3s-main | grep IPv4 | awk '{print $2}')

multipass exec k3s-first -- bash -c "curl -sfL https://get.k3s.io | K3S_URL=\"https://$IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"
multipass exec k3s-second -- bash -c "curl -sfL https://get.k3s.io | K3S_URL=\"https://$IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"







