# Example AKS cluster using Terraform

This repository showcases using Terraform to provision a new network and AKS cluster with nodes within.

## Install and configure

Ensure that `az` and `terraform` are installed first. This has been tested with Terraform 0.12.

### Initialise Azure CLI

```shell
az login
```

### Setup variables

Fill out `terraform.tfvars` with the variables you'd like.

Required variables are `location`, and `name`, the Azure location/region, and name you'd like your cluster.

See [an Azure regions list](https://github.com/claranet/terraform-azurerm-regions/blob/master/REGIONS.md) for reference.

## Provisioning

```shell
terraform init
terraform apply
```

### Configure kubectl

```shell
az aks get-credentials --resource-group mycluster --name mycluster
```

### Test it works

```shell
kubectl get nodes -o wide
```

## Tearing down

```shell
terraform destroy
```

## What now?

Check out the [Terraform AKS documentation](https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html) for more details on customising the cluster.

Some more things to look at:

* NAT gateway for outgoing traffic from nodes. See `network_profile.outbound_type` Terraform configuration.
* Check the security of the cluster. Role based access to the cluster would be a good step to lock down access.
