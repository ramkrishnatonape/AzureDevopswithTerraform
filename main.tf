provider "azurerm" {
    features {}
}

terraform  {
  backend "azurerm" {
      resource_group_name = "tfrg_storage_rm"
      storage_account_name = "tfstorageram"
      container_name = "tfstate"
      key = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "south india"
}

resource "azurerm_container_group" "tfcg_test" {
  name = "weatherapi"
  location = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type = "public"
  dns_name_label = "ramtonapewp"
  os_type = "Linux"

  container {
    name = "weatherapi"
    image = "ramtonape/weatherapi"
      cpu = "1"
      memory = "1"

      ports {
          port = 80
          protocol = "TCP"
      }

  }
  
}