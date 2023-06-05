# terraform-tfc-deploy-workspaces
Terraform Module for Terraform Cloud Workspace Management

## Getting Started

This module is intended to create templated Workspaces with optional associated variables within Terraform Cloud

Resources
- tfe_workspace
- tfe_variable
- tfe_workspace_policy_set


### Prerequisites

    Terraform ~> 1.4.0

### Tested

    Terraform ~> 1.4.6
### Installing

This module should be called by a Terraform Cloud environment configuration

- Assigning the tag "auto-apply" will configure the target workspace to be flagged as automatic apply
- Tfe_variables must all be of a single type or Terraform will error
- Passing a list of sentinal policy set names will assign them to the deployed workspaces 

##### Usage

```
module "TFC_Workspace_Example" {
  for_each                      = local.workspace_vars.example_vars
  source                        = "app.terraform.io/YOUR-ORG/deploy-workspaces/tfc"
  version                       = "1.0.0"
  name                          = "tfc_workspace_example_${each.key}"
  organization                  = data.tfe_organization.main.name
  vcs_repo                      = local.base_infra_repo
  tfe_variables                 = each.value
  project_id                    = data.tfe_project.main.id
  workspace_tags                = [each.key, "example", "terraform-cloud", "auto-apply"]
  sentinel_policy               = ["Require-Resources-from-PMR","Enforce-Tagging-Policy"]
}
```


```
data "tfe_organization" "main" {
  name = var.organization
}

data "tfe_project" "main" {
  name = var.project
}

data "tfe_github_app_installation" "github" {
  installation_id = var.github_installation_id
}

locals {

  example_repo = [
    {
      identifier                 = "github/example-module"
      github_app_installation_id = data.tfe_github_app_installation.github.id
      branch                     = "main"
    }
  ]

  workspace_vars = {
    example_vars = {
      "dev" = {
        "vpc_name" = {
          value       = "example"
          description = "vpc name identifier"
          category    = "terraform"
        },
        "env_name" = {
          value       = "dev"
          description = "env name for identifier"
          category    = "terraform"
        },
        "project_name" = {
          value       = "TFC Example"
          description = "Project Name for tagging purposes"
          category    = "terraform"
        },
        "vpc_cidr" = {
          value       = "10.0.0.0/20"
          description = "vpc network cidr"
          category    = "terraform"
        },
        "public_subnet_cidr" = {
          value       = join(", ", ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"])
          description = "public subnets cidr"
          category    = "terraform"
          hcl         = true
        },
      },
      "prod" = {
        "vpc_name" = {
          value       = "example"
          description = "vpc name identifier"
          category    = "terraform"
        },
        "env_name" = {
          value       = "prod"
          description = "env name for identifier"
          category    = "terraform"
        },
        "project_name" = {
          value       = "TFC Example"
          description = "Project Name for tagging purposes"
          category    = "terraform"
        },
        "vpc_cidr" = {
          value       = "10.10.0.0/20"
          description = "vpc network cidr"
          category    = "terraform"
        },
        "public_subnet_cidr" = {
          value       = join(", ", ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"])
          description = "public subnets cidr"
          category    = "terraform"
          hcl         = true
        },
      },
    }
  }
}
```



### Outputs

The following values are outputted
```
    id                  = tfe_workspace.main.id
```

