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

resource "azurerm_service_plan" "udacity" {
  name                = "udacity-service-plan"
  resource_group_name = azurerm_resource_group.udacity.name
  location            = azurerm_resource_group.udacity.location
  os_type             = "Linux"
  sku_name            = "F1"
  tags = {
    environment = "udacity"
  }
}

resource "azurerm_linux_web_app" "udacity_app" {
  name                = "udacity-dotnet-app"
  resource_group_name = azurerm_resource_group.udacity.name
  location            = azurerm_service_plan.udacity.location
  service_plan_id     = azurerm_service_plan.udacity.id

  site_config {
    always_on = false
    application_stack {
      dotnet_version = "6.0"
    }
  }
  

  tags = {
    environment = "udacity"
  }
}

resource "azurerm_mssql_server" "udacity" {
  name                         = "udacitytscottoazuresql"
  resource_group_name          = azurerm_resource_group.udacity.name
  location                     = azurerm_resource_group.udacity.location
  version                      = "12.0"
  administrator_login          = "udacity"
  administrator_login_password = "Password1!"

  tags = {
    environment = "udacity"
  }
}