terraform {
  backend "azurerm" {
    subscription_id           = "348b8c4a-d544-4da4-b252-7d5b46589b99"
    resource_group_name       = "terraform"
    storage_account_name      = "terraformsanthos"
    container_name            = "terraform-state"
    key                       = "mediawiki1"  
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "terraform_wiki"
  location = "East US"

  tags = {
    environment = "media"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "mediawiki-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "mediawiki-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }
  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "media"
  }
}