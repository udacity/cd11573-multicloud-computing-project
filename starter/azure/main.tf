resource "azurerm_resource_group" "udacity" {
  name     = "udacity-resources"
  location = "North Central US"
}

resource "azurerm_container_group" "udacity" {
  name                = "udacity-continst"
  location            = azurerm_resource_group.udacity.location
  resource_group_name = azurerm_resource_group.udacity.name
  ip_address_type     = "Public"
  dns_name_label      = "udacity-tscotto-azure"
  os_type             = "Linux"

  container {
    name   = "azure-container-app"
    image  = "docker.io/tscotto5/azure_app:1.0"
    cpu    = "0.5"
    memory = "1.5"
    environment_variables = {
      "AWS_S3_BUCKET"       = "udacity-tscotto-aws-s3-bucket",
      "AWS_DYNAMO_INSTANCE" = "udacity-tscotto-aws-dynamodb"
    }
    ports {
      port     = 3000
      protocol = "TCP"
    }
  }
  tags = {
    environment = "udacity"
  }
}

####### Your Additions Will Start Here ######
