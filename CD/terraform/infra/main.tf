terraform {
  backend "azurerm" {
    resource_group_name       = "terraform"
    storage_account_name      = "terraformsanthos"
    container_name            = "terraform-state"
    key                       = "mediawiki"  
  }
}

provider "azurerm" {
  features {}
  subscription_id = "348b8c4a-d544-4da4-b252-7d5b46589b99"
  client_id       = "45046d91-77f7-4d64-a44d-8fc3f57b08c7"
  client_secret   = var.client_secret
  tenant_id       = "15875212-4f5c-4365-ad98-25fc3309681c"
}

resource "azurerm_resource_group" "default" {
  name     = "terraform"
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

  tags = {
    environment = "media"
  }
}