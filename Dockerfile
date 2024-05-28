ARG CODE_SERVER_VERSION=4.89.1-fedora
ARG HELM_VERSION=3.15.1
ARG KUBECTL_VERSION=1.27.14
ARG OC_VERSION=4.16.0
ARG GO_HTTPBIN=v2.14.0

FROM docker.io/alpine/helm:${HELM_VERSION} AS helm
FROM docker.io/bitnami/kubectl:${KUBECTL_VERSION} AS kubectl
FROM quay.io/openshift/origin-cli:${OC_VERSION} AS oc
FROM docker.io/mccutchen/go-httpbin:${GO_HTTPBIN} AS go-httpbin

FROM codercom/code-server:${CODE_SERVER_VERSION}
ARG K9S_VERSION=v0.32.4
ENV K9S_VERSION=${K9S_VERSION}

COPY --from=helm /usr/bin/helm /usr/local/bin/helm
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl
COPY --from=oc /usr/bin/oc /usr/local/bin/oc
COPY --from=go-httpbin /bin/go-httpbin /usr/local/bin/go-httpbin

RUN sudo dnf update -y && sudo dnf install -y \
	yq \
	vim \
	nc \
	openssl \ 
  tig \
	&& dnf clean all \
  && rm -rf /var/cache/yum

RUN curl -L -o /tmp/k9s.tar.gz https://github.com/derailed/k9s/releases/download/$K9S_VERSION/k9s_Linux_amd64.tar.gz \
  && sudo tar zxf /tmp/k9s.tar.gz -C /usr/local/bin/ k9s

RUN EXT_LIST="eamodio.gitlens rangav.vscode-thunder-client redhat.vscode-yaml" && for EXT in $EXT_LIST; do code-server --install-extension $EXT; done

COPY src/code-server/User/ /home/coder/.local/share/code-server/User/