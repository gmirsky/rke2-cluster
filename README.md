# RKE2 Kubernetes Cluster

## Prerequisites

- Three (3) Linux hosts that will act as master control servers for the RKE2 cluster.
- Three (3) or more hosts that will act as the worker nodes for the RKE2 cluster.
- One (1) NFS host that has a share that can be mounted to the worker node hosts.
- All six (6) Ansible host targets have been fully updated and have a static IP address.
- All six (6) Ansible host targets have been modified in accordance to RKE2 prequisites.
- A dedicated IP address for the floating kubectl access across the master (server) nodes.
- A contiguous IP range for the MetalLB load balancer.
- Kubectl, Helm and K9S installed on your client machine to access the cluster.

> [!IMPORTANT]
>
> This walk-through has been tested with Ubuntu 24 LTS, Ubuntu22LTS and with Oracle 8 Linux. Other distributions may require some tweaking of the code to work properly.

## Terraform

<Terraform instructions go here>

## Ansible

Change into the Ansible directory of this repository.

```bash
cd ansible
```

Update the values in the inventory/group_vars/all.yaml that are appropriate for your environment.

```yaml
os: "linux"
arch: "amd64"

kube_vip_version: "v0.8.1"
vip_interface: enp6s18 
vip: 192.168.1.190 # This is the common floating IP address for the cluster

metallb_version: "v0.14.7"
lb_range: 192.168.1.240-192.168.1.249
lb_pool_name: first-pool

rke2_version: "v1.30.2+rke2r1"
rke2_install_dir: "/usr/local/bin"
rke2_binary_url: "https://github.com/rancher/rke2/releases/download/{{ rke2_version }}/rke2.linux-amd64"

ansible_user: gmirsky
ansible_become: true
ansible_become_method: sudo 
```

> [!NOTE]
>
> The MetalLB `lb_range` needs to be contiguous. It can be as little as two IP addresses if needed.
>
> Make sure that the vip_interface matches the interface name on all of your servers. Consult the documentation for your Linux distribution to change the name of your network interface to make the name uniform across all of your servers.

Ping all the hosts to insure that you have proper communication between Ansible and the hosts.

```bash
ansible-playbook ping.yaml -i inventory/hosts.ini
```

Mount the NFS share to the worker node (agent) hosts.

```bash
ansible-playbook mount-nfs.yaml -i inventory/hosts.ini
```

Deploy RKE2 to the Ansible host targets (servers and agents).

```bash
ansible-playbook site.yaml -i inventory/hosts.ini
```

## Post Ansible Steps

### Taints

Taint the server (master) nodes so that we don't have pods scheduled on the server (master) nodes.

```bash
kubectl taint node o8rke2m1 special=true:PreferNoSchedule
kubectl taint node o8rke2m2 special=true:PreferNoSchedule
kubectl taint node o8rke2m3 special=true:PreferNoSchedule
```

This is done because the Kobe-VIP and MetalLB are considered applications but are deployed to the master (server) nodes to be closer to the pods they need to interact with.

> [!NOTE]
>
> RKE2 uses the nomenclature of servers to refer to master nodes. Agents are the worker nodes.



### Deploy Test Application Using Helm

Change to the Helm directory of this repository.

If you are currently in the Ansible directory, use this command:

```bash
cd ../helm
```

Otherwise just change into the Helm directory:

```bash
cd helm
```

Deploy the test application using Helm:

```bash
helm install --create-namespace \
    --namespace k8s-test \
    custom-message ./hello-kubernetes \
    --set message='HA RKE2 Kubernetes on Oracle Linux 8.10 (3 pods)' \
    --set deployment.replicaCount=3 \
    --set nodeselector.label=agent 
```

You may change the name of the Kubernetes namespace that the application is deployted to. In addition, you can change the message too. 

