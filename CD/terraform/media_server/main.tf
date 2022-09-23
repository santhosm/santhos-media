terraform {
  backend "azurerm" {
    subscription_id           = "348b8c4a-d544-4da4-b252-7d5b46589b99"
    resource_group_name       = "terraform"
    storage_account_name      = "terraformsanthos"
    container_name            = "terraform-state"
    key                       = "mediawikiserver"  
  }
}
provider "azurerm" {
  features {}
}
resource "helm_release" "example" {
  name       = "mediawiki-release"
  repository = "santhosregistry"
  chart      = "media_wiki"
  version    = "0.1.3"
}