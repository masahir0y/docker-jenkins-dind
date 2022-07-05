# LTS
#FROM jenkins/jenkins:lts-jdk11

# Latest weekly
FROM jenkins/jenkins:jdk11

USER root

COPY jenkins-dind-entrypoint.sh /usr/local/bin/

RUN \
	curl --fail -o /usr/local/bin/dind https://raw.githubusercontent.com/docker/docker/42b1175eda071c0e9121e1d64345928384a93df1/hack/dind \
	&& curl --fail -o /usr/local/bin/dockerd-entrypoint.sh https://raw.githubusercontent.com/docker-library/docker/4c1b73e7046422ca1339b76935c2e2f4251b9c20/22.06-rc/dind/dockerd-entrypoint.sh \
	&& chmod +x \
		/usr/local/bin/dind \
		/usr/local/bin/jenkins-dind-entrypoint.sh \
		/usr/local/bin/dockerd-entrypoint.sh \
	&& apt-get update \
	&& apt-get install -y \
		bridge-utils \
		curl \
		docker.io \
		# dig
		dnsutils \
		gosu \
		# ip
		iproute2 \
		iptables \
		# ping
		iputils-ping \
		kmod \
		less \
		lsb-release \
		netcat \
		# ps
		procps \
		# pstree
		psmisc \
		wget \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& usermod -aG docker jenkins

VOLUME /var/lib/docker

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins-dind-entrypoint.sh"]
