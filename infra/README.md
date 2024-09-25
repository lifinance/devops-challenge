About:
This simple infra was provisioned on AWS using IAC(Terraform) to manage a k8s application already deployed using helm.

Steps to Reproduce
A list of the resources provisioned include:
1. AWS vpc - Provisioned using a module
2. AWS ec2 instance with ubuntu AMI (provisioned using a data source) - The following commands were added to the userdata as part of the bootscript in order to install k8s and docker within the instance

curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--tls-san your_server_ip" sh -
sudo apt update -y && sudo apt install docker.io -y
sudo usermod -aG docker $USER
 newgrp docker

 3. AWS security group
 4. AWS ECR 

As soon as the ec2 instance is deployed you will be able to ssh into it using
ssh -i <private-key> ubuntu@<public-ip-addess>  or using ec2-instance-connect. The k3 will already be installed via the user data. 
An attempt to run kubectl get nodes creates the following error:
'''k3s kubectl version
WARN[0000] Unable to read /etc/rancher/k3s/k3s.yaml, please start server with --write-kubeconfig-mode to modify kube config permissions 
error: error loading config file "/etc/rancher/k3s/k3s.yaml" : open /etc/rancher/k3s/k3s.yaml: permission denied'''

in order to overcome this , run the following commands:
export KUBECONFIG=~/.kube/config
mkdir ~/.kube 2> /dev/null
sudo k3s kubectl config view --raw > "$KUBECONFIG"
chmod 600 "$KUBECONFIG"

afterwards  all commands can run
its important to change the default namespace for the context to bird  using the following commands :
<kubectl config set-context --current --namespace=<namespace>>
<kubectl config  view | grep namespace> command to verify it has been changed to bird as default