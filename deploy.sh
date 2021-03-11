#!/usr/bin/env bash

# Login to Kubernetes Cluster.
aws eks \
    --region ${AWS_REGION} \
    update-kubeconfig --name ${CLUSTER_NAME} \
    --role-arn=${CLUSTER_ROLE_ARN}

# Helm Dependency Update
# helm dependency update ${DEPLOY_CHART_PATH:-helm/}
helm repo update
helm repo add magic ${REPO} --username ${REPO_USERNAME} --password ${REPO_PASSWORD}

# Helm Deployment
UPGRADE_COMMAND="helm upgrade --atomic --install --timeout ${TIMEOUT} --version ${VERSION}"
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
