variable "ssh_keys" {
  type = list(object({
    publickey = string
    user = string
  }))
  description = "list of public ssh keys that have access to the VM"
  default = [
      {
        user = "arghy"
        publickey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClv1sJEHNiOu3lva2yuCiWlR5e+uNyDtKY7ckQrIm2TGXo2spMssEBmb1HvZCg1v/S7VgzWTardH2M9FAnU2XauSf9fJ0hobYcpW+H1tpgfJgLf9v9Dv6bT88XbL5E7bBmuNcAjTgqFUjGnRZseyqEFQypODl9KQwB++t65hL2ULoKIttmOfU2XadhOKg77XUVg5gTkbh03DCV85rZqdZOk/wkUwYSCFz+hzNu9WD77uPKhyYWzVw2ots4zozKipd2e5fKcdTFRSdr9ZNJNnVGKTFL8g2T9DkTzTF+pClwWyNVOQBiuqYRuiunoqH4DmxTFGXf95/Po4f0SB/bYv5T arghy"}
  ]
}
