![PNG LOGO](https://github.com/user-attachments/assets/e0fba218-6059-4c69-9d46-c9354e392b93)

#                    🐧 Azure Linux VM Deployment with Terraform

This project uses **Terraform** to deploy a secure **Ubuntu Linux Virtual Machine** in Azure. It includes configuration for networking, OS disk settings, managed identity, and secrets stored in Azure Key Vault. Optional data disk attachment logic is also included but currently commented out.

---

## 📦 Resources Deployed

- Azure Resource Group
- Azure Network Interface (NIC)
- Azure Linux Virtual Machine
- (Optional) Azure Managed Disks + Data Disk Attachments *(commented)*

---

## 📁 Prerequisites

- Azure Subscription
- [Terraform CLI](https://developer.hashicorp.com/terraform/install)
- Existing:
  - Subnet (via `data.azurerm_subnet.subnet`)
  - Azure Key Vault secrets for admin username/password
- Service Principal with appropriate permissions

---

## 📌 Variables

| Variable Name              | Description                                         | Required | Example                          |
|---------------------------|-----------------------------------------------------|----------|----------------------------------|
| `location`                | Azure region                                        | ✅       | `Canada Central`                 |
| `hostname`                | Name of the virtual machine                         | ✅       | `webserver01`                    |
| `VmSize`                  | VM size(s), comma-separated if multiple             | ✅       | `"Standard_D2s_v3,Standard_B1s"` |
| `ipType`                  | IP allocation type (`Dynamic` or `Static`)          | ✅       | `"Dynamic"`                      |
| `tags`                    | Tags for resources                                  | ✅       | `{ environment = "dev" }`        |
| `oscaching`               | Caching type for OS disk                            | ✅       | `"ReadWrite"`                    |
| `OS_storageaccType`       | Storage type for the OS disk                        | ✅       | `"Standard_LRS"`                 |
| `identity`                | Managed identity type (`SystemAssigned`, etc.)      | ✅       | `"SystemAssigned"`               |
| `diskcreate`              | Number of data disks to create                      | ❌       | `2`                              |
| `disksizegb`              | List of disk sizes in GB                            | ❌       | `[128, 256]`                     |
| `diskcaching`             | Caching mode for data disks                         | ❌       | `"None"`                         |
| `datadisk_storageaccType`| Storage type for data disks                         | ❌       | `"Standard_LRS"`                 |

> 🔐 **Note**: Admin credentials are pulled from Azure Key Vault using `data.azurerm_key_vault_secret`.

---

## 🚀 How to Deploy

1. **Clone the repo**

```bash
git clone https://github.com/your-org/azure-linux-vm.git
cd azure-linux-vm
````

2. **Initialize Terraform**

```bash
terraform init
```

3. **Plan the deployment**

```bash
terraform plan -var-file="terraform.tfvars"
```

4. **Apply the configuration**

```bash
terraform apply -var-file="terraform.tfvars"
```

---

## 🔒 Admin Credentials via Key Vault

Ensure the following secrets exist in your Key Vault:

* `wgadminuser`: VM admin username
* `wgadminpass`: VM admin password

They are retrieved using:

```hcl
data.azurerm_key_vault_secret.wgadminuser.value
data.azurerm_key_vault_secret.wgadminpass.value
```

---

## 💾 Optional Data Disk Attachment

To enable and configure data disks:

1. Uncomment the following resources:

   * `azurerm_managed_disk`
   * `azurerm_virtual_machine_data_disk_attachment`

2. Set the required variables:

   * `diskcreate`, `disksizegb`, `diskcaching`, `datadisk_storageaccType`

---

## 🧼 Cleanup

```bash
terraform destroy -var-file="terraform.tfvars"
```

---

## 📬 Contact

**Oluseyi Sunny-Okundia**
Cloud Engineer | YouTube: [Cloudforged with Seyi](https://www.youtube.com/@cloudforgedwithseyi)
📧 [oluseyi@cloudforgedacademy.ca](mailto:oluseyi@cloudforgedacademy.ca)

---

## 📄 License

MIT License. Use at your own discretion.

```