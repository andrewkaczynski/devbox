ARG CODE_SERVER_VERSION=4.89.1-fedora
ARG HELM_VERSION=3.15.1
ARG KUBECTL_VERSION=1.27.14
ARG GO_HTTPBIN=v2.14.0

FROM docker.io/alpine/helm:${HELM_VERSION} AS helm
FROM docker.io/bitnami/kubectl:${KUBECTL_VERSION} AS kubectl
FROM docker.io/mccutchen/go-httpbin:${GO_HTTPBIN} AS go-httpbin

FROM codercom/code-server:${CODE_SERVER_VERSION}
ARG K9S_VERSION=v0.32.4
ENV K9S_VERSION=${K9S_VERSION}

ARG OC_VERSION=4.15.15
ENV OC_VERSION=${OC_VERSION}

COPY --from=helm /usr/bin/helm /usr/local/bin/helm
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl
COPY --from=go-httpbin /bin/go-httpbin /usr/local/bin/go-httpbin

RUN \
	sudo dnf update -y \
	&& sudo dnf install -y --skip-broken\
	yq \
	jq \
	skopeo \
	vim \
	nc \
	openssl \ 
	tig \
	python3-pip \
	net-tools \
	zip	\
	bzip2 \
	unzip \
	rsync \
	--exclude container-selinux \
	&& sudo dnf clean all \
	&& sudo rm -rf /var/cache/yum /var/cache /var/log/dnf* /var/log/yum.*

RUN pip3 --no-cache-dir install --upgrade awscli

RUN curl -L -o /tmp/k9s.tar.gz https://github.com/derailed/k9s/releases/download/$K9S_VERSION/k9s_Linux_amd64.tar.gz \
	&&  sudo tar zxf /tmp/k9s.tar.gz -C /usr/local/bin/ k9s

RUN curl -L -o /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$OC_VERSION/openshift-client-linux.tar.gz \
	&&  sudo tar zxf /tmp/oc.tar.gz -C /usr/local/bin/ oc

RUN sudo mkdir /var/run/user/1000 && sudo chown coder:coder /var/run/user/1000

ENV XDG_RUNTIME_DIR=/var/run/user/1000
ENV PATH=$PATH:/home/coder/.local/bin

RUN EXT_LIST="eamodio.gitlens rangav.vscode-thunder-client redhat.vscode-yaml" && for EXT in $EXT_LIST; do code-server --install-extension $EXT; done

COPY src/code-server/User/ /home/coder/.local/share/code-server/User/