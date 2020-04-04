# Support for Ubuntu Destribution Only
OS_RELEASE              ?= $(shell cat /etc/lsb-release | grep RELEASE | awk -F= '{print $$2}' | awk -F. '{print $$1}')

OAI_BASE_NAME           ?= oai-build-base
OAI_ENB_NAME            ?= oai-enb
OAI_MME_NAME            ?= oai-mme
OAI_HSS_NAME            ?= oai-hss
OAI_SPGWC_NAME          ?= oai-spgwc
OAI_SPGWU_NAME          ?= oai-spgwu

DOCKER_ENV              ?= DOCKER_BUILDKIT=1
DOCKER_TAG              ?= latest
DOCKER_REGISTRY         ?= localhost/
DOCKER_REPOSITORY       ?= $(shell whoami)
DOCKER_BUILD_ARGS       ?= --rm

BASE_IMAGE_NAME         ?= ${DOCKER_REGISTRY}${DOCKER_REPOSITORY}${OAI_BASE_NAME}:${DOCKER_TAG}
ENB_IMAGE_NAME          ?= ${DOCKER_REGISTRY}${DOCKER_REPOSITORY}${OAI_ENB_NAME}:${DOCKER_TAG}
MME_IMAGE_NAME          ?= ${DOCKER_REGISTRY}${DOCKER_REPOSITORY}${OAI_MME_NAME}:${DOCKER_TAG}
HSS_IMAGE_NAME          ?= ${DOCKER_REGISTRY}${DOCKER_REPOSITORY}${OAI_HSS_NAME}:${DOCKER_TAG}
SPGWC_IMAGE_NAME        ?= ${DOCKER_REGISTRY}${DOCKER_REPOSITORY}${OAI_SPGWC_NAME}:${DOCKER_TAG}
SPGWU_IMAGE_NAME        ?= ${DOCKER_REGISTRY}${DOCKER_REPOSITORY}${OAI_SPGWU_NAME}:${DOCKER_TAG}

build-all: build-base build-enb build-hss build-mme build-spgwc build-spgwu

build-base:
    ${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
                    -t ${BASE_IMAGE_NAME} \
                    -f ./${OAI_BASE_NAME}/Dockerfile.ubuntu${OS_RELEASE} \
                    ./${OAI_BASE_NAME}

build-enb: build-base
    @echo "Not Implemented"

build-hss: build-base
    @echo "Not Implemented"

build-mme: build-base
    @echo "Not Implemented"

build-spgwc: build-base
    @echo "Not Implemented"

build-spgwu: build-base
    @echo "Not Implemented"

.PHONY: build-all build-base build-enb build-hss build-mme build-spgwc build-spgwu
