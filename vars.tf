variable "vpc_info" {
  type = object({
    cidr_block           = string
    tags                 = map(string)
    enable_dns_hostnames = bool
  })
  description = "This refers vpc info"
}

variable "public_subnet" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))
  description = "this is a public subnet"
}

variable "private_subnet" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))
  description = "this is a private subnet"
}

variable "web_security_group" {
  type = object({
    name        = string
    description = string
    inbound_rules = list(object({
      protocol    = string
      port        = number
      source      = string
      description = string
    }))

  })

}

variable "app_security_group" {
  type = object({
    name        = string
    description = string
    inbound_rules = list(object({
      protocol    = string
      port        = number
      source      = string
      description = string
    }))

  })

}

variable "db_security_group" {
  type = object({
    name        = string
    description = string
    inbound_rules = list(object({
      protocol    = string
      port        = number
      source      = string
      description = string
    }))

  })

}