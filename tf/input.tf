variable "data" {
  type = object({
    username=string
    password=string
    region=string
  })
  default = {
    username="admin"
    password="admin"
    region = "ap-south-1"
  }
}
