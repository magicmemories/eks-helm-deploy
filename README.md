# EKS helm deploy GitHub action

This action uses aws cli to login to EKS and deploy a helm chart.

## Inputs

### `atomic`

If set, upgrade process rolls back changes made in case of failed upgrade.

### `wait`

Whether the upgrade should wait for all resources to be Ready before completing.

### `debug`

Whether to enable debug logging.

### `extra-args`

Any extra command line arguments to pass to Helm.

### `aws-secret-access-key`

AWS secret access key part of the aws credentials. This is used to login to EKS.

### `aws-secret-access-key`

AWS secret access key part of the aws credentials. This is used to login to EKS.

### `aws-access-key-id`

AWS access key id part of the aws credentials. This is used to login to EKS.

### `aws-region`

AWS region to use. This must match the region your desired cluster lies in.

### `cluster-name`

The name of the desired cluster.

### `cluster-role-arn`

If you wish to assume an admin role, provide the role arn here to login as.

### `config-files`

Comma separated list of helm values files.

### `namespace`

Kubernetes namespace to use.

### `values`

Comma separates list of value set for helms. e.x: key1=value1,key2=value2

### `name`

The name of the helm deploy.

### `chart-path`

The path to the chart.

### `version`

Version of the Chart

### `timeout`

Timeout for the job

### `repo-username`

Helm repo username

### `repo-password`

Helm repo password

### `repo`

Helm repo

## Example usage

```yaml
- name: MM EKS Helm Deploy
  # You may pin to the exact commit or the version.
  # uses: magicmemories/eks-helm-deploy@485fd8cfb4ad4f7f20c75a5327aa740cf5331c34
  uses: magicmemories/eks-helm-deploy@0.0.5
  with:
    # If set, upgrade process rolls back changes made in case of failed upgrade.
    atomic: # optional
    # AWS credentials used to login to eks.
    aws-secret-access-key: 
    # AWS credentials used to login to eks.
    aws-access-key-id: 
    # AWS region to use (default: us-west-2)
    aws-region: # default is us-west-2
    # EKS cluster name.
    cluster-name: 
    # EKS cluster admin role arn.
    cluster-role-arn: # optional
    # whether to enable debug logging
    debug: #optional
    # Comma separates list of helm values files.
    config-files: # optional
    # Kubernetes namespace to use.
    namespace: # optional
    # Comma separated list of value sets for helms. e.x: key1=value1,key2=value2
    values: # optional
    # Name of the helm deploy.
    name: 
    # The path of the chart.
    chart-path: # default is helm/
    # Chart Version
    version: # optional
    # Timeout for the job.
    timeout: # default is 5m0s
    # Any extra command line arguments to pass to Helm
    extra-args: # optional
    # helm repo username
    repo-username: # optional
    # helm repo password
    repo-password: # optional
    # helm repo
    repo: # optional
    # Whether the upgrade should wait for all resources to be Ready before completing
    wait: # optional
```
