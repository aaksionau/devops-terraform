provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "tf_test"{
    name = "tfmainrg"
    location = "North Central US"
}

resource "azurerm_container_group" "tf_container" {
    name = "weatherapi"
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name
    os_type = "linux"
    dns_name_label = "a2ksionau"

    container {
        name            = "weatherapi"
        image           = "paloni/weatherapp"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}