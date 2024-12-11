docker_registry_secret:
	kubectl create secret docker-registry regcred \
	--docker-server={AWS-ACCOUNT}.dkr.ecr.{}.amazonaws.com \
	--docker-username=AWS \
	--docker-password=$(aws ecr get-login-password) \

docker-build:
	docker build -f bird/Dockerfile -t bird .


docker-push:


k8s-deploy:
