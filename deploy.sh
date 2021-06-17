#!/usr/bin/env bash

# Login to Kubernetes Cluster.
aws eks \
    --region ${AWS_REGION} \
    update-kubeconfig --name ${CLUSTER_NAME} \
    --role-arn=${CLUSTER_ROLE_ARN}

# Helm Dependency Update
# helm dependency update ${DEPLOY_CHART_PATH:-helm/}
helm repo add magic ${REPO} --username ${REPO_USERNAME} --password ${REPO_PASSWORD} --pass-credentials
helm repo update

UPGRADE_COMMAND="helm upgrade --install"

if [[ "$ATOMIC" = "true" ]]; then
    UPGRADE_COMMAND="${UPGRADE_COMMAND} --atomic"
elif [[ "$ATOMIC" != "false" ]]; then
    echo "ERROR: 'atomic' input value should be either 'true' or 'false', got ${ATOMIC}"
    exit 1
fi

if [[ "$WAIT" = "true" ]]; then
    UPGRADE_COMMAND="${UPGRADE_COMMAND} --wait"
elif [[ "$WAIT" != "false" ]]; then
    echo "ERROR: 'wait' input value should be either 'true' or 'false', got ${WAIT}"
    exit 1
fi

if [[ "$DEBUG" = "true" ]]; then
    UPGRADE_COMMAND="${UPGRADE_COMMAND} --debug"
elif [[ "$DEBUG" != "false" ]]; then
    echo "ERROR: 'debug' input value should be either 'true' or 'false', got ${DEBUG}"
    exit 1
fi

UPGRADE_COMMAND="${UPGRADE_COMMAND} --timeout ${TIMEOUT} --version ${VERSION}"

if [ -n "$EXTRA_ARGS" ]; then
    UPGRADE_COMMAND="${UPGRADE_COMMAND} ${EXTRA_ARGS}"
fi

for config_file in ${DEPLOY_CONFIG_FILES//,/ }
do
    UPGRADE_COMMAND="${UPGRADE_COMMAND} -f ${config_file}"
done
if [ -n "$DEPLOY_NAMESPACE" ]; then
    UPGRADE_COMMAND="${UPGRADE_COMMAND} -n ${DEPLOY_NAMESPACE}"
fi
if [ -n "$DEPLOY_VALUES" ]; then
    UPGRADE_COMMAND="${UPGRADE_COMMAND} --set ${DEPLOY_VALUES}"
fi
# UPGRADE_COMMAND="${UPGRADE_COMMAND} ${DEPLOY_NAME} ${DEPLOY_CHART_PATH:-helm/}"
UPGRADE_COMMAND="${UPGRADE_COMMAND} ${DEPLOY_NAME} ${DEPLOY_CHART_PATH}"
echo "Executing: ${UPGRADE_COMMAND}"
${UPGRADE_COMMAND}
