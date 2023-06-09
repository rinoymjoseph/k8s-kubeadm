terraform {
  required_providers {
    proxmox = {
      source    =   "Telmate/proxmox"
      version   =   "2.9.14"
    }
  }
}

provider "proxmox" {
  # Configuration options
  pm_api_url    =   "https://192.168.0.111:8006/api2/json"
  pm_user       =   "root@pam"
  pm_password   =   "welcome123#"
}

# Provision bootstrap
resource "proxmox_vm_qemu" "k8s-bootstrap" {
  name          = "k8s-bootstrap"
  vmid          = 149
  target_node   = "proxmox"
  clone         = "Ubuntu-Server-22.04"
  full_clone    = false
  memory        = 2048
  cores         = 1
  network   {
    model       = "virtio"
    macaddr     = "86:AC:41:71:70:7D"
    bridge      = "vmbr0"
    firewall    = true
  }
}

# Provision k8s-controller-1
resource "proxmox_vm_qemu" "k8s-controller-1" {
  name          = "k8s-controller-1"
  vmid          = 151
  target_node   = "proxmox"
  clone         = "Ubuntu-Server-22.04"
  full_clone    = false
  memory        = 8192
  cores         = 2
  network   {
    model       = "virtio"
    macaddr     = "86:AC:41:B6:DC:C2"
    bridge      = "vmbr0"
    firewall    = true
  }
}

# Provision k8s-worker-1
resource "proxmox_vm_qemu" "k8s-worker-1" {
  name          = "k8s-worker-1"
  vmid          = 161
  target_node   = "proxmox"
  clone         = "Ubuntu-Server-22.04"
  full_clone    = false
  memory        = 8192
  cores         = 2
  network   {
    model       = "virtio"
    macaddr     = "86:AC:41:A9:79:16"
    bridge      = "vmbr0"
    firewall    = true
  }
}

# Provision k8s-worker-2
resource "proxmox_vm_qemu" "k8s-worker-2" {
  name          = "k8s-worker-2"
  vmid          = 162
  target_node   = "proxmox"
  clone         = "Ubuntu-Server-22.04"
  full_clone    = false
  memory        = 8192
  cores         = 2
  network   {
    model       = "virtio"
    macaddr     = "86:AC:41:FD:2E:4F"
    bridge      = "vmbr0"
    firewall    = true
  }
}

# Provision k8s-worker-3
resource "proxmox_vm_qemu" "k8s-worker-3" {
  name          = "k8s-worker-3"
  vmid          = 163
  target_node   = "proxmox"
  clone         = "Ubuntu-Server-22.04"
  full_clone    = false
  memory        = 8192
  cores         = 2
  network   {
    model       = "virtio"
    macaddr     = "86:AC:41:01:23:30"
    bridge      = "vmbr0"
    firewall    = true
  }
}

resource "null_resource" "ks8-bootstrap-remote-exec" {

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo DEBIAN_FRONTEND=noninteractive apt install ansible software-properties-common unzip sshpass python3-pip -y",
      "pip3 install kubernetes"
    ]
  }

  connection {
    host        = "192.168.0.149"  
    type        = "ssh"
    port        = 22
    user        = "ability"
    password    = "welcome123#"
  }
}

