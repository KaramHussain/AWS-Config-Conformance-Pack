
Markdown
# AWS CONFIG WITH CONFORMANCE PACK

[![AWS Conig](images/config.png)](images/config.png)

# AWS Config: Your AWS Environment's X-Ray Vision

AWS Config is your all-in-one solution for gaining complete visibility and control over your AWS infrastructure. It provides a detailed inventory of your resources, tracks configuration changes, and helps you ensure compliance and security.


## Core Features

1. **Configuration Recorder:**
   - Automatically captures and records the configuration details of your AWS resources at regular intervals.
   - Provides a snapshot of your resources' current state, allowing you to track changes over time.

2. **Delivery Channel:**
   - Delivers configuration snapshots and change notifications to an Amazon S3 bucket for storage and analysis.
   - Optionally, sends notifications to an Amazon SNS topic to alert you of configuration changes in real time.

3. **Config Rules (Optional):**
   - Define the desired configuration settings for your AWS resources.
   - Use AWS Managed Rules for common use cases or create custom rules with Lambda functions for specific requirements.
   - Config Rules constantly monitor your resources and evaluate their compliance with the defined criteria.

## Why AWS Config is Essential

* **Security & Compliance:** Detect unauthorized changes and ensure your environment adheres to industry standards and regulations.
* **Operational Excellence:**  Gain insights into your infrastructure's configuration history, simplifying troubleshooting and root cause analysis.
* **Cost Optimization:** Identify unused or underutilized resources, leading to potential cost savings.
* **Change Management:** Understand the impact of changes before they are implemented, reducing the risk of unexpected disruptions. 


## The Missing Piece: Enter Conformance Packs

While AWS Config gives you incredible visibility into your AWS environment, it doesn't automatically enforce compliance with your desired standards. That's where Conformance Packs come in.

### Why AWS Config Alone Wasn't Enough

* **Manual Rule Management:** Creating and managing individual Config Rules for every compliance requirement was time-consuming and prone to errors.
* **Inconsistent Enforcement:** Ensuring consistent rule enforcement across multiple AWS accounts and regions required manual effort.
* **Lack of Pre-Built Standards:** You had to develop and maintain your own custom rules to align with industry standards like PCI DSS or HIPAA.
* **No Automated Remediation:** Non-compliant resources triggered notifications, but fixing them required manual intervention.
* **Scaling Challenges:** As your AWS environment grew, managing individual Config Rules became increasingly complex.

### How Conformance Packs Elevate Your Compliance

* **Pre-Defined Rule Sets:** Conformance Packs bundle multiple Config Rules into a single package, making it easy to deploy and enforce entire compliance standards with a few clicks.
* **Automated Compliance Checks:** Conformance Packs continuously evaluate your resources against the defined rules, ensuring ongoing adherence to your chosen standards.
* **Consistent Enforcement:** Easily deploy Conformance Packs across multiple AWS accounts and regions, ensuring consistent compliance throughout your organization.
* **Immutable Rules:** Once deployed, Conformance Packs are immutable, preventing unauthorized changes to your compliance standards.
* **Automated Remediation:**  You can configure Conformance Packs to automatically remediate non-compliant resources, saving you time and effort.


# aws config terraform overiew.drawio.png

[![High Level Overview](images/terraform-highlvl.png)](images/terraform-highlvl.png)

[![How Score is Calculated](images/score.png)](images/score.png)
Conformance Packs fill the gaps in AWS Config by providing:
By combining AWS Config with Conformance Packs, you gain a complete solution for monitoring, enforcing, and maintaining compliance in your AWS infrastructure.


# AWS Config Conformance & Recorder Terraform Project


## Key Components & How They Work Together

1. **AWS Config Recorder:**
   * Continuously records the configuration changes of your AWS resources (in this project, we focus on S3 buckets).
   * This creates a historical record of how your infrastructure has evolved over time.

2. **Conformance Packs:**
   * Define a set of desired configurations (compliance rules) for your resources.
   * In this project, a conformance pack checks if your S3 buckets are publicly accessible (which is a security risk). You can customize the rules by modifying the templates in the `Conformance_templates` folder.
   * AWS Config compares your actual resource configurations against these rules, and reports any non-compliance.

3. **IAM Roles and Policies:**
   * Provide the necessary permissions for the AWS Config service to operate.
   * The project carefully defines these permissions to ensure least privilege security.

4. **S3 Buckets:**
   * Two S3 buckets are created:
      * One for storing the AWS Config configuration history (where the recorder puts its data).
      * Another for storing the Conformance Pack template file.
   * Versioning is enabled on these buckets to protect against accidental data loss or changes.

## Customization

### Variables (variables.tf)

| Variable                    | Description                                                                         | Default Value                    |
| -------------------------- | ----------------------------------------------------------------------------------- | --------------------------------- |
| `region`                   | The AWS region to deploy resources.                                                  | "us-east-1"                       |
| `configRecorder_role_name`  | Name of the IAM role for AWS Config.                                                 | "config_role"                     |
| `configRecorder_policy_name` | Name of the IAM policy for AWS Config.                                                | "config_policy"                   |
| `RecorderBucketName`        | Name of the S3 bucket where Config stores its data.                                  | "karam7790123"                     |
| `configRecorder_name`       | Name of the AWS Config recorder.                                                      | "config_recorder"                 |
| `ConformancePack1_bucketName` | Name of the S3 bucket where conformance pack templates are stored.                | "karam7790conformance"           |
| `ConformanceName`           | Name of the conformance pack.                                                        | "conformancepack"                 |

* Modify these variables in the `variables.tf` file to fit your environment and naming conventions.

## How to Use (Step-by-Step)




## 🛠️ Project Structure & How It Works
[![Architecture Diagram](images/folderstructure.png)](images/folderstructure.png)
This project is a well-organized toolkit for setting up AWS Config to monitor and enforce compliance rules on your AWS resources. Let's take a closer look at how it all fits together:

### 📂 Directory Structure

### 🧰 Inside the Toolbox (Directories & Files)

* **`Conformance_templates/`:**
    - **Purpose:** Your rulebook! Stores YAML files defining compliance rules for AWS resources.
    - **Key File:** The included `.yaml` file checks for public S3 buckets (a security risk).

* **`modules/`:**
    - **Purpose:** Reusable building blocks (modules) for different AWS Config components.
    - **Key Modules:**
        - **`ConformancePack/`:**  The tool that creates and enforces your rulebook.
        - **`IAM/`:** Creates the permissions (roles and policies) for AWS Config to function.
        - **`recorder/`:** Sets up the "security camera" (AWS Config Recorder) to track resource changes.
        - **`storage/`:** Creates and configures S3 "storage boxes" for your Config data and rules.

* **`main.tf`:**
    - **Purpose:** The main instruction manual. It connects and configures the modules.
    - **How it Works:** It reads your rules, builds the tools (from the modules), links the recorder to storage, and activates the conformance pack to check your resources.

* **`variables.tf`:**
    - **Purpose:** Your customization panel. Change names, settings, etc. to match your environment.

* **`backend.tf`:**
    - **Purpose:** Tells Terraform where to save its memory (state) about your infrastructure.

### ⚙️ Building the AWS Config System

1. **Define the Rules:** Start by writing or customizing rules in the `.yaml` files within `Conformance_templates/`. Think of these rules as your security guidelines.

2. **Prepare the Tools:** Use the modules to create:
   - The **Conformance Pack Tool** (`ConformancePack/`) that applies your rules.
   - The **IAM Tools** (`IAM/`) to grant AWS Config the necessary permissions.
   - The **Recorder Tool** (`recorder/`) to monitor changes to your resources.
   - The **Storage Boxes** (`storage/`) to safely store your Config data and rules.

3. **Build the System:** The `main.tf` file is like the project manager:
   - It reads your custom rules.
   - It assembles the tools from the modules.
   - It connects the recorder to the storage.
   - It sets up the conformance pack to evaluate your AWS resources against your defined rules.

4. **Customize (Optional):** Make any necessary adjustments in the `variables.tf` file.


1. **Prerequisites:**
   * An AWS account
   * Terraform installed on your machine
   * AWS CLI installed and configured

2. **Clone Repository:**

   ```bash
   git clone https://github.com/KaramHussain/AWS-Config-Conformance-Pack
   cd AWS-Config-Conformance-Pack

2. **Customize:** 
   * Open variables.tf and adjust the values according to your needs.
   * (Optional) Modify conformance pack templates in Conformance_templates/ if you want to add more rules.

3. **Initialize Terraform:**
   * terraform init 

4. **Initialize Terraform:**
   * terraform apply