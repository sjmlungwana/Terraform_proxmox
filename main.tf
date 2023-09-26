# Proxmox Full-Clone
# ---
# Create a new VM from a clone

resource "tls_private_key" "generated" {
  algorithm = "RSA"
}
resource "local_file" "private_key_pem" {
  content  = tls_private_key.generated.private_key_pem
  filename = "MyKey.pem"
}


resource "proxmox_vm_qemu" "Mivu" {

  # VM General Settings
  target_node = "pve"
  vmid        = "100"
  name        = "Mivu"
  desc        = "Description"

  # VM Advanced General Settings
  onboot = true

  # VM OS Settings
  clone = "debian-11-cloudinit-template"

  # VM System Settings
  agent = 1

  # VM CPU Settings
  cores   = 1
  sockets = 1
  cpu     = "host"

  # VM Memory Settings
  memory = 1024

  # VM Network Settings
  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  # VM Cloud-Init Settings
  os_type = "cloud-init"

  # (Optional) IP Address and Gateway
  # ipconfig0 = "ip=0.0.0.0/0,gw=0.0.0.0"

  # (Optional) Default User
  # ciuser = "your-username"

  # (Optional) Add your SSH KEY
  # sshkeys = <<EOF
  # #YOUR-PUBLIC-SSH-KEY
  # EOF
}
