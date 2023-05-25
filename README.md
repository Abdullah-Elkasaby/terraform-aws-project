### Project Specifications:
![image](https://github.com/Abdullah-Elkasaby/terraform-aws-project/assets/97049761/a8d6f4ea-cf5e-426e-84aa-2b3ce116f01a)

**1. Workspace:**
A new workspace called "dev" was created to work on the project, providing better isolation and organization of resources during development.

**2. Custom Modules:**
The project utilized two custom modules, enabling flexibility and customization options:
- **Network Module:** This module handled the network configurations, including subnets, routing, and security groups. It allowed for easy scalability by accommodating an increase in the number of subnets with minimal changes.
- **EC2 Module:** Responsible for provisioning EC2 instances and associated resources, this module offered customization options such as instance type, storage, and tags. Similar to the network module, it supported scalability by allowing the addition of more EC2 instances without significant modifications.

**3. Remote Backend:**
To ensure reliable state management and facilitate collaborative development, a remote backend was implemented using cloud services. The Terraform statefile was stored in an Amazon S3 bucket, while the locks were managed using Amazon DynamoDB. This setup provided the following benefits:
- **Statefile Storage:** The statefile stored in the S3 bucket allowed for easy access, versioning, and collaboration among team members. It eliminated the risk of losing the statefile and ensured a consistent view of the infrastructure.
- **Locking Mechanism:** DynamoDB was utilized as a locking mechanism to prevent concurrent modifications to the infrastructure. It ensured that only one user or process could make changes to the statefile at a time, preventing conflicts and maintaining the infrastructure's integrity.

**4. Provisioning**
- The provisioning process involved the installation of Apache or a proxy on the target machines.

**5. Datasource for Image ID:**
A datasource was implemented to retrieve the image ID for EC2 instances. This ensured consistent and controlled provisioning, as the specified image was reliably used to create the EC2 resources.

**6. Load Balancers:**
Two load balancers were configured as follows:
- The first load balancer, designed to be public-facing, accepted traffic from the internet. It served as the entry point for external requests and distributed them across the available instances.
- The second load balancer was set to be private and responsible for routing traffic to the private machines within the infrastructure. It provided an additional layer of security by isolating internal resources from direct external access.

### Usage:

Before proceeding, please ensure the following prerequisites are met:

- AWS CLI is installed and properly configured with your AWS credentials.
- Terraform is installed on your system.

To initialize the Terraform project, run the following command in the project directory:

```
terraform init
```

This command initializes the project and downloads the necessary providers and modules.

To apply the infrastructure changes and provision the resources, run the following command:

```
terraform apply
```

Review the proposed changes and confirm by typing "yes" when prompted. Terraform will then create the specified infrastructure resources based on your configuration.
