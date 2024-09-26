About:
The application was deployed using helm where I essentially built all the k8s resources from the ground up

Steps to reproduce:
1. Build the docker image and push it to ECR(already created using iac):

 Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI:

aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-ID>.dkr.ecr.<region>.amazonaws.com

Build your Docker image using the following command. 

docker build -t <image-name> .

After the build completes, tag your image so you can push the image to this repository:

docker tag <image-name>:<tag> <account-ID>.dkr.ecr.<region>.amazonaws.com/<repo>:<tag>

Run the following command to push this image to your newly created AWS repository:

docker push <account-ID>.dkr.ecr.<region>.amazonaws.com/<repo>:<tag>

NB: I added health check to each of the api and then built/pushed a new docker image to the ECR

2. create a k8 bird namespace using the manifest file or using the command :
  kubectl create ns <name of namespace>

3. create a registry secret in the namespace using the command
   kubectl create secret docker-registry regcred \
  --docker-server=<Account ID>.dkr.ecr.<region>.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password) \
  --namespace=<namespace>

 ensure that the 2 resources (namespace and docker registry secret) have already been created before deploying the helm chart

4. install the application :
  helm install <name of release> <path to helm chart> -n <namespace>

  Note- k8s resources deployed using this helm chart include - deployment, service, hpa
  To test if the helm chart YAML syntax is corrct, we can render the helm chart locally using:
   helm template <path to helm>

5. Health checks are done on each of the api  and liveness probe added to each of the containers in order to monitor the health 

The goal essentially is to build a CICD pipeline that ensues the build and deploy runs automatically rather than do it manually as it is(and it works). My first approach would be to integrate a github action and define the jobs/steps. Already began the process of integrating that but I am almost out of time.Beyond this task, I will ensure that is integrated and demonstrate that it works when we reconvene (hopefully). 

in order to test that the api works use 
<kubectl port-forward svc/bird-service 4201:4201> command
and then enter localhost:4201 into the browser