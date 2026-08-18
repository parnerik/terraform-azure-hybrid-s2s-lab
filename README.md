# Azure Hybrid S2S VPN Lab with Terraform

This project deploys a small Azure hybrid lab using Terraform.

It creates:

- Azure Resource Group
- Virtual Network
- Servers subnet
- Identity subnet
- GatewaySubnet
- Azure VPN Gateway with Public IP
- Local Network Gateway
- Site-to-Site VPN connection
- NAT Gateway with Public IP
- NAT Gateway associations for the Identity and Servers subnets
- Windows Server 2022 VM
- Static private IP
- Custom DNS configuration
- Premium SSD
- Boot Diagnostics

The Windows Server can optionally be joined to an existing Active Directory domain and promoted manually to an additional Domain Controller.

---

## Architecture

```text
On-premises network
192.168.100.0/24
        |
   Firewall / VPN device
        |
      IPsec
        |
 Azure VPN Gateway
        |
 VNet 10.10.0.0/16
        |
        +-- snet-servers     10.10.1.0/24
        |
        +-- snet-identity    10.10.2.0/24
        |        |
        |        +-- AZ-DC02 10.10.2.4
        |
        +-- GatewaySubnet    10.10.255.0/27

Identity + Servers subnets
        |
    NAT Gateway
        |
     Internet
```

The VM itself does not have a public IP.

The Site-to-Site VPN provides private connectivity between Azure and the on-premises network.

---

## NAT Gateway

The Identity and Servers subnets use:

```hcl
default_outbound_access_enabled = false
```

A NAT Gateway provides explicit outbound Internet access for private VMs without assigning a public IP directly to the VM.

This is useful for Windows Update, Microsoft endpoints and other outbound Internet access.

---

## Region

This lab currently uses:

```text
West US 2
```

West US 2 was selected because the lab was created using an Azure Free Trial subscription and some VM SKUs were unavailable in other tested regions.

Change the region in `terraform.tfvars` if required.

---

## Requirements

- Azure subscription
- Terraform
- Azure CLI
- Azure authentication using `az login`
- Public IP of the on-premises firewall/VPN device
- On-premises network address space
- Firewall or VPN appliance supporting Site-to-Site IPsec VPN
- Non-overlapping Azure and on-premises network ranges

Example:

```text
On-premises: 192.168.100.0/24
Azure VNet:  10.10.0.0/16
```

---

## Variables

Copy:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
```

Then update the values for your environment.

Do not commit the real `terraform.tfvars`.

---

## Secrets

The VPN pre-shared key and VM administrator password are not stored in `terraform.tfvars`.

Set them before running Terraform:

```powershell
$env:TF_VAR_s2s_vpn_connection_shared_key="YOUR-VPN-PRESHARED-KEY"
$env:TF_VAR_dc02_admin_password="YOUR-VM-ADMIN-PASSWORD"
```

---

## Deployment

```powershell
az login
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

## Firewall / VPN Configuration

Terraform creates the Azure side of the Site-to-Site VPN.

The on-premises firewall must be configured separately according to the firewall vendor documentation.

Typical requirements include:

- Azure VPN Gateway public IP as the remote peer
- matching pre-shared key
- Site-to-Site IPsec tunnel
- Azure VNet as the remote network
- on-premises subnet as the local network
- compatible IKE/IPsec settings
- firewall policies allowing traffic between both networks
- route toward the Azure VNet through the VPN tunnel

Example:

```text
Local network:  192.168.100.0/24
Azure network:  10.10.0.0/16
```

This lab was tested with a FortiGate firewall using a route-based IPsec tunnel.

Some firewall configurations may require a static route:

```text
Destination: 10.10.0.0/16
Interface:   Azure S2S VPN tunnel
```

Normal private Site-to-Site traffic should generally not use source NAT.

If the firewall is behind another NAT device, NAT Traversal may also be required.

---

## Testing

Example connectivity tests from Azure:

```powershell
Test-NetConnection 192.168.100.200 -Port 53
Test-NetConnection 192.168.100.200 -Port 389
```

DNS:

```powershell
nslookup dc01.example.local
```

---

## Optional Active Directory

The Windows VM can optionally be:

1. joined to an existing domain
2. rebooted
3. promoted to an additional Domain Controller
4. configured as an additional DNS server

AD configuration is intentionally kept outside Terraform.

---

## Cost

This lab can create billable resources including:

- Virtual Machine
- Managed Disk
- VPN Gateway
- NAT Gateway
- Public IP addresses

Destroy the lab when it is no longer required:

```powershell
terraform destroy
```