
# Support for Ubuntu Destribution Only
OS_RELEASE              ?= $(shell cat /etc/lsb-release | grep RELEASE | awk -F= '{print $$2}' | awk -F. '{print $$1}')

OAI_BASE_NAME           ?= oai-build-base
OAI_ENB_NAME            ?= oai-enb
OAI_MME_NAME            ?= oai-mme
OAI_HSS_NAME            ?= oai-hss
OAI_SPGWC_NAME          ?= oai-spgwc
OAI_SPGWU_NAME          ?= oai-spgwu

DOCKER_ENV              ?= DOCKER_BUILDKIT=1
DOCKER_TAG              ?= ubt18
DOCKER_REGISTRY         ?= localhost
DOCKER_REPOSITORY       ?= $(shell whoami)
DOCKER_BUILD_ARGS       ?= --rm

BASE_IMAGE_NAME         ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${OAI_BASE_NAME}:${DOCKER_TAG}
ENB_IMAGE_NAME          ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${OAI_ENB_NAME}:${DOCKER_TAG}
MME_IMAGE_NAME          ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${OAI_MME_NAME}:${DOCKER_TAG}
HSS_IMAGE_NAME          ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${OAI_HSS_NAME}:${DOCKER_TAG}
SPGWC_IMAGE_NAME        ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${OAI_SPGWC_NAME}:${DOCKER_TAG}
SPGWU_IMAGE_NAME        ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${OAI_SPGWU_NAME}:${DOCKER_TAG}

build-all: build-base build-enb build-hss build-mme build-spgwc build-spgwu

build-base:
    ${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
                    --tag ${BASE_IMAGE_NAME} \
                    --file ./${OAI_BASE_NAME}/Dockerfile.ubuntu${OS_RELEASE} \
                    ./${OAI_BASE_NAME}

build-enb: build-base
    ${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
                    --tag ${ENB_IMAGE_NAME} \
                    --file ./${OAI_ENB_NAME}/Dockerfile.ubuntu${OS_RELEASE} \
                    --build-arg REGISTRY=${DOCKER_REGISTRY} \
                    --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
                    --build-arg TAG=${DOCKER_TAG} \
                    ./${OAI_ENB_NAME}

build-hss: build-base
    ${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
                    --tag ${HSS_IMAGE_NAME} \
                    --file ./${OAI_HSS_NAME}/Dockerfile.ubuntu${OS_RELEASE} \
                    --build-arg REGISTRY=${DOCKER_REGISTRY} \
                    --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
                    --build-arg TAG=${DOCKER_TAG} \
                    ./${OAI_HSS_NAME}

build-mme: build-base
    ${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
                    --tag ${MME_IMAGE_NAME} \
                    --file ./${OAI_MME_NAME}/Dockerfile.ubuntu${OS_RELEASE} \
                    --build-arg REGISTRY=${DOCKER_REGISTRY} \
                    --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
                    --build-arg TAG=${DOCKER_TAG} \
                    ./${OAI_MME_NAME}

build-spgwc: build-base
    ${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
                    --tag ${SPGWC_IMAGE_NAME} \
                    --file ./${OAI_SPGWC_NAME}/Dockerfile.ubuntu${OS_RELEASE} \
                    --build-arg REGISTRY=${DOCKER_REGISTRY} \
                    --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
                    --build-arg TAG=${DOCKER_TAG} \
                    ./${OAI_SPGWC_NAME}

build-spgwu: build-base
    ${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
                    --tag ${SPGWU_IMAGE_NAME} \
                    --file ./${OAI_SPGWU_NAME}/Dockerfile.ubuntu${OS_RELEASE} \
                    --build-arg REGISTRY=${DOCKER_REGISTRY} \
                    --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
                    --build-arg TAG=${DOCKER_TAG} \
                    ./${OAI_SPGWU_NAME}

.PHONY: build-all build-base build-enb build-hss build-mme build-spgwc build-spgwu