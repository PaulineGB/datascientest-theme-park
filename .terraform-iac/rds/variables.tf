variable "db_name" {
    type        = string
}

variable "db_username" {
    type        = string
}

variable "db_password" {
    type        = string
    sensitive   = true
}

variable "private_subnets_ids" {
    type        = list(string)
}

variable "engine" {
    type        = string
    description = "type of database engine"
    default     = "mariadb"
}

variable "engine_version" {
    type        = string
    description = "version of database engine"
    default     = "10.4.14"
}

variable "family" {
    type        = string
    description = "family of database engine"
    default     = "mariadb10.4"
}

variable "instance_class" {
    type        = string
    description = "instance class of database engine"
    default     = "db.t2.micro"
}

variable "allocated_storage" {
    type        = number
    description = "allocated storage of database engine"
    default     = 5
}
