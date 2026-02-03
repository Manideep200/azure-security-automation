variable "location"{
    type = string
    default = "SouthCentral US"
}
variable "vnet_address_space"{
    type = list(string)
    default = ["10.0.0.0/16"]
}