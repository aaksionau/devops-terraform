provider "azurerm" {
    features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "terraform"
    storage_account_name = "terraformstorage3"
    container_name = "terraform"
    key = "terraform.tfstate"
  }
}


resource "azurerm_resource_group" "tf_test"{
    name = "tfmainrg"
    location = "North Central US"
}

variable "imagebuild"{
    type = string
    description = "Latest image build"
}

resource "azurerm_container_group" "tf_container" {
    name = "weatherapi"
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name
    os_type = "linux"
    dns_name_label = "a2ksionau"

    container {
        name            = "weatherapi"
        image           = "paloni/weatherapp:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}