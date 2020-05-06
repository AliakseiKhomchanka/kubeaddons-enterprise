KUTTL_VERSION=0.1.0
KUBERNETES_VERSION=1.17.2

OS=$(shell uname -s | tr '[:upper:]' '[:lower:]')
MACHINE=$(shell uname -m)

export PATH := $(shell pwd)/bin/:$(PATH)

ARTIFACTS=dist

bin/:
	mkdir -p bin/

bin/kubectl-kuttl_$(KUTTL_VERSION): bin/
	curl -Lo bin/kubectl-kuttl_$(KUTTL_VERSION) https://github.com/kudobuilder/kuttl/releases/download/v$(KUTTL_VERSION)/kubectl-kuttl_$(KUTTL_VERSION)_$(OS)_$(MACHINE)
	chmod +x bin/kubectl-kuttl_$(KUTTL_VERSION)
	ln -sf ./kubectl-kuttl_$(KUTTL_VERSION) ./bin/kubectl-kuttl


.PHONY: install-kuttl
install-kuttl: bin/kubectl-kuttl_$(KUTTL_VERSION)

.PHONY: test
test:  install-kuttl
	kubectl kuttl test --kind-config=test/kind/kubernetes-$(KUBERNETES_VERSION).yaml --artifacts-dir=$(ARTIFACTS)

