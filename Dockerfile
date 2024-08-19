FROM jenkins/jenkins:2.462.1-jdk17
USER root
RUN apt-get update && apt-get install -y lsb-release maven
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
RUN export M2_HOME=/usr/bin/mvn; export MAVEN_HOME=/usr/bin/mvn
USER jenkins
RUN jenkins-plugin-cli --plugins "maven-plugin workflow-aggregator git sonar nodejs kubernetes aws-credentials docker-workflow ssh-agent email-ext blueocean"



# docker network create jenkins

# docker run --name jenkins --restart=on-failure --detach `
#   --network jenkins --env DOCKER_HOST=tcp://docker:2376 `
#   --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 `
#   --volume jenkins-data:/var/jenkins_home `
#   --volume jenkins-docker-certs:/certs/client:ro `
#   --publish 8080:8080 --publish 50000:50000 myjenkins-blueocean