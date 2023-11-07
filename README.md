<h1>Description: </h1>
Dockerfile for creating a Docker image to run a container designed to manage various AWS resources, including Terraform and Amazon EKS.<br>

This Dockerfile is intended to build an image that facilitates the streamlined management of AWS resources such as Terraform and Amazon EKS. It provides an environment within a container that's configured to efficiently handle the orchestration and administration of diverse AWS services. Users can leverage this containerized environment for deploying, configuring, and maintaining resources on the AWS cloud, including EKS clusters and other infrastructure components. The Dockerfile includes the necessary configurations, dependencies, and tools required to effectively work with Terraform and manage AWS resources.

<b>Note: </b>Before building the Docker image, ensure you have the necessary credentials and configurations for AWS access and proper setup for Terraform and EKS integration within the container.
<h1> HOW TO> </h1>
# Build Docker image based on above file

docker build -t toolbox:1.24 .

# Push new image
docker push <dockerid>/toolbox:1.24

# Volume to mount = tools-box
docker run -d --name toolbox-lower-1.24--volume /home/docker/toolbox:/tools-box --volume /var/run/docker.sock:/var/run/docker.sock -i -t bku-tools.jfrog.io/toolbox:1.24

# Login and use
sudo docker exec -it toolbox-lower-1.24 /bin/bash
