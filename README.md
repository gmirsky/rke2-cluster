# RKE2 Kubernetes Cluster

## Prerequisites

- Three (3) Linux hosts that will act as master control servers for the RKE2 cluster.
- Three (3) or more Linux hosts that will act as the worker nodes for the RKE2 cluster.
- All six (6) Ansible host targets have been fully updated and have a static IP address.
- All six (6) Ansible host targets have been modified in accordance to RKE2 prequisites.
- A dedicated IP address for the floating IP that kubectl will use to access the cluster.
- A contiguous IP range for the MetalLB load balancer.
- Kubectl and Helm installed on your client machine to access the cluster.

> [!IMPORTANT]
>
> This walk-through has been tested with Rocky Linux 9. Other distributions may require some tweaking of the code to work properly.

## Terraform

> [!NOTE]
>
> This section is optional. 
>
> Use the terraform code to provision virtual machines on a ProxMox cluster as targets to install the RKE2 Kubernetes cluster. If you are planning to install the RKE2 nodes on other platforms can skip this step.

Change to the Terraform directory of this repository.

```shell
cd terraform
```

Update the `terraform.tfvars` file. The values for `password` and `proxmox_password` need to be updated. Password is the password you want the user of the virtual machines to have. The proxmox_password is the Proxmox Administrator password.

Update the `proxmox_username` if it is not the default `root@pam` username.

Use the following commands to provision the virtual machines

```shell
terraform init -upgrade
terraform validate
terraform validate
terraform plan -out=tfplan
```

Use the following bash shell script to copy your SSH keys to the newly created VMs.

```shell
bash add_python3.sh
```

> [!IMPORTANT]
>
> You must have `pssh` and `ssh-keyscan` installed to run the above script.

## Ansible

Change into the Ansible directory of this repository.

```bash
cd ansible
```

Update the values in the inventory/group_vars/all.yaml that are appropriate for your environment.

- The latest version of Kube-VIP can be found [here](https://github.com/kube-vip/kube-vip/releases)
- The latest version of MetalLB can be found [here](https://github.com/metallb/metallb/tags)
- The latest version of RKE2 can be found [here](https://github.com/rancher/rke2/releases)

```yaml
os: "linux"
arch: "amd64"

kube_vip_version: "v1.0.1"
vip_interface: enp6s18 
vip: 192.168.1.190 # This is the common floating IP address for the cluster

metallb_version: "v0.15.2"
lb_range: 192.168.1.240-192.168.1.249
lb_pool_name: first-pool

rke2_version: "v1.34.1+rke2r1"
rke2_install_dir: "/usr/local/bin"
rke2_binary_url: "https://github.com/rancher/rke2/releases/download/{{ rke2_version }}/rke2.linux-amd64"

ansible_user: gmirsky
ansible_become: true
ansible_become_method: sudo 
```

> [!NOTE]
>
> The `ansible_user` should have full sudo privileges.
>
> The MetalLB `lb_range` needs to be contiguous. It can be as little as two IP addresses if needed.
>
> Make sure that the vip_interface matches the interface name on all of your servers. Consult the documentation for your Linux distribution to change the name of your network interface to make the name uniform across all of your servers.

Update the values in ansible/inventory/hosts.ini with the proper IP addresses.

```ini
; Make sure Ansible host has access to these devices
; and snapshot all machines before running Ansible
; so you revert if something fails

[servers]
server1 ansible_host=192.168.1.191
server2 ansible_host=192.168.1.192
server3 ansible_host=192.168.1.193

[servers:vars]
ansible_python_interpreter=/usr/bin/python3
host_key_checking = False

[agents]
agent1 ansible_host=192.168.1.194
agent2 ansible_host=192.168.1.195
agent3 ansible_host=192.168.1.196

[agents:vars]
ansible_python_interpreter=/usr/bin/python3
host_key_checking = False

[all:children]
servers
agents
```

Ping all the hosts to insure that you have proper communication between Ansible and the hosts using the following command:

```shell
ansible-playbook ping.yaml -i inventory/hosts.ini
```

Deploy RKE2 to the Ansible host targets (servers and agents) using the following command:

```bash
ansible-playbook site.yaml -i inventory/hosts.ini
```

> [!NOTE]
>
> If you get a failure on Server1, this may be caused by a timing issue with Server1 not being ready fast enough. Rerun the Ansible command again to clear the error.

Get the .kube/config from the first master node by logging onto that server and using the following command:

```bash
ansible-playbook fetch.yaml -i inventory/hosts.ini
```

The playbook will place the config values into file called `kube.txt`

## Post Ansible Steps

Copy the output and open up your local .kube/config file and paste the contents of kube.txt into that file. <u>Remember to change the IP address in the file to the floating Kube-VIP address.</u>

Once that is completed you shoud be able to execute the following command and get a list of nodes in the cluster:

```bash
kubectl get nodes -A -o=wide
```

To see how the cluster came up, you can list out the pods in the order they were started using the following command:

```bash
kubectl get pods -A -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,NODE:.spec.nodeName,HOSTIP:.status.hostIP,PHASE:.status.phase,START_TIME:.metadata.creationTimestamp --sort-by=.metadata.creationTimestamp
```

### Taints

Taint the server (master) nodes so that we don't have pods scheduled on the server (master) nodes.

```bash
kubectl taint node vm1 special=true:PreferNoSchedule
kubectl taint node vm2 special=true:PreferNoSchedule
kubectl taint node vm3 special=true:PreferNoSchedule
```

> [!NOTE]
>
> Tainting the master nods is done because the Kube-VIP and MetalLB are considered applications but are deployed to the master (server) nodes to be closer to the pods they need to interact with. So the taint cannot be in place when we are creating the cluster.
>
> PreferNoSchedule is used in case the agents become over utilized. Then the scheduler will try to schedule the pods on the master (server) nodes, if it can.
>
> RKE2 uses the nomenclature of: 
>
> - Servers to refer to master control plane nodes. 
> - Agents are the worker nodes where application pods execute.

To view the taints in the cluster execute the following command:

```bash
kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints --no-headers

vm1   [map[effect:PreferNoSchedule key:special value:true]]
vm2   [map[effect:PreferNoSchedule key:special value:true]]
vm3   [map[effect:PreferNoSchedule key:special value:true]]
vm4   <none>
vm5   <none>
vm6   <none>
```

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

Deploy the application using the following command:

```bash
helm install --create-namespace \
    --namespace k8s-test \
    custom-message ./hello-kubernetes \
    --set message='HA RKE2 Kubernetes on Oracle Linux 9 (3 pods)' \
    --set deployment.replicaCount=3 \
    --set nodeselector.label=agent 
```

Use the following command to check what nodes the pods have been deployed to:

```bash
kubectl get pods -n k8s-test --output 'jsonpath={range .items[*]}{.spec.nodeName}{" "}{.metadata.namespace}{" "}{.metadata.name}{"\n"}{end}'
```

The pods should have been deployed to only the Agent nodes in the cluster.

Navigate to the first IP address (`192.168.1.240`) of the load balancer, listed in `ansible/inventory/group_vars/all.yaml` to see the web page of the application the Helm chart deployed.

Change the number of replicas (pods) to six and the display message by using the following command:

```bash
helm upgrade --namespace k8s-test \
    custom-message ./hello-kubernetes \
    --set message='HA RKE2 Kubernetes on Oracle Linux 9 (6 pods)' \
    --set deployment.replicaCount=6 \
    --set nodeselector.label=agent 
```

Use the following command to check what nodes the pods have been deployed to:

```bash
kubectl get pods -n k8s-test --output 'jsonpath={range .items[*]}{.spec.nodeName}{" "}{.metadata.namespace}{" "}{.metadata.name}{"\n"}{end}'
```

The pods should have been deployed to only the Agent nodes in the cluster.

Refresh the web page of the Helm application to see that it now reads six pods.

Let's experiment and remove the taints from the master (server) nodes:

```bash
kubectl taint node vm1 special=true:PreferNoSchedule-
kubectl taint node vm2 special=true:PreferNoSchedule-
kubectl taint node vm3 special=true:PreferNoSchedule-
```

Now, boost the number of replicas (pods) to nine and along with the display message by using the following command:

```bash
helm upgrade --namespace k8s-test \
    custom-message ./hello-kubernetes \
    --set message='HA RKE2 Kubernetes on Oracle Linux 8.10 (9 pods)' \
    --set deployment.replicaCount=9 \
    --set nodeselector.label=agent 
```

Use the following command to check what nodes the pods have been deployed to:

```bash
kubectl get pods -n k8s-test --output 'jsonpath={range .items[*]}{.spec.nodeName}{" "}{.metadata.namespace}{" "}{.metadata.name}{"\n"}{end}'
```

Notice that the pods have been deployed to both the Agent and Server nodes in the cluster.

Let's taint the nodes again to return them to the state we want.

```bash
kubectl taint node vm1 special=true:PreferNoSchedule
kubectl taint node vm1 special=true:PreferNoSchedule
kubectl taint node vm1 special=true:PreferNoSchedule
```

Now, let us uninstall the application using the following command:

```bash
helm uninstall --namespace k8s-test custom-message
```

Delete the namespace to keep the environment clean using the following command:

```bash
kubectl delete namespace k8s-test
```

## Clean up

To destroy the virtual machines in the Proxmox cluster after you are done with them, return to the Terraform directory.

```shell
cd terraform
```

Execute the following Terraform command to delete the virtual machines.

```shell
terraform destroy -auto-approve
```

