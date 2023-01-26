[![Massdriver][logo]][website]

# aws-opensearch

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]

Amazon OpenSearch is a managed service that allows you to set up, manage, and scale a search engine for your website or application. It is built on top of Apache Lucene and provides a simple and easy-to-use interface for adding search functionality to your application.

---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

<!-- COMPLIANCE:START -->

Security and compliance scanning of our bundles is performed using [Bridgecrew](https://www.bridgecrew.cloud/). Massdriver also offers security and compliance scanning of operational infrastructure configured and deployed using the platform.

| Benchmark                                                                                                                                                                                                                                                       | Description                        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-opensearch/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-opensearch&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![CIS AWS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-opensearch/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-opensearch&benchmark=CIS+AWS+V1.2) | Center for Internet Security, AWS Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-opensearch/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-opensearch&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-opensearch/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-opensearch&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-opensearch/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-opensearch&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-opensearch/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-opensearch&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-opensearch/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-opensearch&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |

<!-- COMPLIANCE:END -->

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`cluster`** *(object)*: Cluster Configuration.
  - **`data_nodes`** *(object)*
    - **`instance_count`** *(integer)*: Number of instances in the cluster. This field is currently immutable [learn more](https://github.com/massdriver-cloud/aws-opensearch/issues/12). Minimum: `1`. Maximum: `80`. Default: `1`.
    - **`instance_type`** *(string)*: Instance type of **data nodes** in the cluster. This field is immutable [learn more](). Default: `r6gd.xlarge.search`.
      - **One of**
        - C6G Compute Optimized Large (2 vCPUs, 4 GiB RAM)
        - C5 Compute Optimized Large (2 vCPUs, 4 GiB RAM)
        - M6G General Purpose Large (2 vCPUs, 8 GiB RAM)
        - M5 General Purpose Large (2 vCPUs, 8 GiB RAM)
        - C6G Compute Optimized Extra Large (4 vCPUs, 8 GiB RAM)
        - C5 Compute Optimized Extra Large (4 vCPUs, 8 GiB RAM)
        - I3 Storage Optimized Large (2 vCPUs, 15.25 GiB RAM)
        - R5 Memory Optimized Large (2 vCPUs, 16 GiB RAM)
        - R6GD Memory Optimized (NVME SSD) Large (2 vCPUs, 16 GiB RAM)
        - M6G General Purpose Extra Large (4 vCPUs, 16 GiB RAM)
        - M5 General Purpose Extra Large (4 vCPUs, 16 GiB RAM)
        - C6G Compute Optimized Double Extra Large (8 vCPUs, 16 GiB RAM)
        - C5 Compute Optimized Double Extra Large (8 vCPUs, 16 GiB RAM)
        - I3 Storage Optimized Extra Large (4 vCPUs, 30.5 GiB RAM)
        - R5 Memory Optimized Extra Large (4 vCPUs, 32 GiB RAM)
        - R6GD Memory Optimized (NVME SSD) Extra Large (4 vCPUs, 32 GiB RAM)
        - M5 General Purpose Double Extra Large (8 vCPUs, 32 GiB RAM)
        - M6G General Purpose Double Extra Large (8 vCPUs, 32 GiB RAM)
        - C5 Compute Optimized Quadruple Extra Large (16 vCPUs, 32 GiB RAM)
        - C6G Compute Optimized Quadruple Extra Large (16 vCPUs, 32 GiB RAM)
        - I3 Storage Optimized Double Extra Large (8 vCPUs, 61 GiB RAM)
        - R5 Memory Optimized Double Extra Large (8 vCPUs, 64 GiB RAM)
        - R6GD Memory Optimized (NVME SSD) Double Extra Large (8 vCPUs, 64 GiB RAM)
        - M6G General Purpose Quadruple Extra Large (16 vCPUs, 64 GiB RAM)
        - M5 General Purpose Quadruple Extra Large (16 vCPUs, 64 GiB RAM)
        - C6G Compute Optimized Eight Extra Large (32 vCPUs, 64 GiB RAM)
        - C5 Compute Optimized 9xlarge (36 vCPUs, 72 GiB RAM)
        - C6G Compute Optimized 12xlarge Extra Large (48 vCPUs, 96 GiB RAM)
        - I3 Storage Optimized Quadruple Extra Large (16 vCPUs, 122 GiB RAM)
        - R5 Memory Optimized Quadruple Extra Large (16 vCPUs, 128 GiB RAM)
        - R6GD Memory Optimized (NVME SSD) Quadruple Extra Large (16 vCPUs, 128 GiB RAM)
        - M6G General Purpose Eight Extra Large (32 vCPUs, 128 GiB RAM)
        - C5 Compute Optimized 18xlarge (72 vCPUs, 144 GiB RAM)
        - M6G General Purpose 12xlarge Extra Large (48 vCPUs, 192 GiB RAM)
        - M5 General Purpose 12xlarge Extra Large (48 vCPUs, 192 GiB RAM)
        - I3 Storage Optimized Eight Extra Large (32 vCPUs, 244 GiB RAM)
        - R6GD Memory Optimized (NVME SSD) Eight Extra Large (32 vCPUs, 256 GiB RAM)
        - R5 Memory Optimized 12xlarge Extra Large (48 vCPUs, 384 GiB RAM)
        - R6GD Memory Optimized (NVME SSD) 12xlarge Extra Large (48 vCPUs, 384 GiB RAM)
        - I3 Storage Optimized 16xlarge Extra Large (64 vCPUs, 488 GiB RAM)
        - R6GD Memory Optimized (NVME SSD) 16xlarge Extra Large (64 vCPUs, 512 GiB RAM)
  - **`master_nodes`** *(object)*
    - **`enabled`** *(boolean)*: Enables 3 dedicated master nodes. Types are automatically selected based on your data node types. Default: `False`.
- **`logging`** *(object)*
  - **`audit_logs`** *(integer)*: Must be one of: `[1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 2192, 2557, 2922, 3288, 3653]`. Default: `365`.
  - **`es_application_logs`** *(integer)*: Must be one of: `[1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 2192, 2557, 2922, 3288, 3653]`. Default: `30`.
  - **`index_slow_logs`** *(integer)*: Must be one of: `[1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 2192, 2557, 2922, 3288, 3653]`. Default: `30`.
  - **`search_slow_logs`** *(integer)*: Must be one of: `[1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 2192, 2557, 2922, 3288, 3653]`. Default: `30`.
- **`networking`** *(object)*
  - **`subnet_type`** *(string)*: Deploy the database to internal subnets (cannot reach the internet) or private subnets (internet egress traffic allowed). Must be one of: `['internal', 'private']`. Default: `internal`.
- **`opensearch`** *(object)*: OpenSearch Configuration.
  - **`version`** *(string)*: Default: `OpenSearch_2.3`.
    - **One of**
      - 2.3
      - 1.3
      - 1.2
      - 1.1
      - 1.0
## Examples

  ```json
  {
      "__name": "Development",
      "cluster": {
          "data_nodes": {
              "instance_count": 1,
              "instance_type": "r6gd.large.search"
          },
          "master_nodes": {
              "enabled": false
          }
      },
      "logging": {
          "audit_logs": 1,
          "es_application_logs": 1,
          "index_slow_logs": 1,
          "search_slow_logs": 1
      },
      "networking": {
          "subnet_type": "internal"
      },
      "opensearch": {
          "version": "OpenSearch_2.3"
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "cluster": {
          "data_nodes": {
              "instance_count": 3,
              "instance_type": "r6gd.large.search"
          },
          "master_nodes": {
              "enabled": true
          }
      },
      "logging": {
          "audit_logs": 90,
          "es_application_logs": 30,
          "index_slow_logs": 30,
          "search_slow_logs": 30
      },
      "networking": {
          "subnet_type": "internal"
      },
      "opensearch": {
          "version": "OpenSearch_2.3"
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`aws_authentication`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`arn`** *(string)*: Amazon Resource Name.

      Examples:
      ```json
      "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
      ```

      ```json
      "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
      ```

    - **`external_id`** *(string)*: An external ID is a piece of data that can be passed to the AssumeRole API of the Security Token Service (STS). You can then use the external ID in the condition element in a role's trust policy, allowing the role to be assumed only when a certain value is present in the external ID.
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

- **`network`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`arn`** *(string)*: Amazon Resource Name.

        Examples:
        ```json
        "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
        ```

        ```json
        "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
        ```

      - **`cidr`** *(string)*

        Examples:
        ```json
        "10.100.0.0/16"
        ```

        ```json
        "192.24.12.0/22"
        ```

      - **`internal_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
      - **`private_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
      - **`public_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`authentication`** *(object)*: Authentication for OpenSearch. Cannot contain additional properties.
  - **`data`** *(object)*: Cannot contain additional properties.
    - **`authentication`** *(object)*: Master Username & Password Authentication.
      - **`hostname`** *(string)*
      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: Cloud specific infrastructure details.
      - **One of**
        - AWS Infrastructure ARN*object*: Minimal AWS Infrastructure Config. Cannot contain additional properties.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

    - **`security`** *(object)*: IAM Security Policies.
      - **Any of**
        - AWS Security information*object*: Informs downstream services of network and/or IAM policies. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Policies. Cannot contain additional properties.
            - **`^[a-z-/]+$`** *(object)*
              - **`policy_arn`** *(string)*: AWS IAM policy ARN.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

          - **`identity`** *(object)*: For instances where IAM policies must be attached to a role attached to an AWS resource, for instance AWS Eventbridge to Firehose, this attribute should be used to allow the downstream to attach it's policies (Firehose) directly to the IAM role created by the upstream (Eventbridge). It is important to remember that connections in massdriver are one way, this scheme perserves the dependency relationship while allowing bundles to control the lifecycles of resources under it's management. Cannot contain additional properties.
            - **`role_arn`** *(string)*: ARN for this resources IAM Role.

              Examples:
              ```json
              "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
              ```

              ```json
              "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
              ```

          - **`network`** *(object)*: AWS security group rules to inform downstream services of ports to open for communication. Cannot contain additional properties.
            - **`^[a-z-]+$`** *(object)*
              - **`arn`** *(string)*: Amazon Resource Name.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

              - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
              - **`protocol`** *(string)*: Must be one of: `['tcp', 'udp']`.
  - **`specs`** *(object)*: Cannot contain additional properties.
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

    - **`opensearch`** *(object)*
      - **`version`** *(string)*: Default: ``.

        Examples:
        ```json
        "1.3"
        ```

        ```json
        "2.0"
        ```

<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/aws-opensearch/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg

[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=aws-opensearch&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=aws-opensearch&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=aws-opensearch&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=aws-opensearch&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=aws-opensearch&utm_content=linkedin

[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/aws-opensearch.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/aws-opensearch/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/aws-opensearch.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/aws-opensearch/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/aws-opensearch.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/aws-opensearch/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/aws-opensearch.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/aws-opensearch/issues
[release_url]: https://github.com/massdriver-cloud/aws-opensearch/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/aws-opensearch.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/aws-opensearch.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/aws-opensearch/blob/main/LICENSE

[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2

[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=aws-opensearch&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=aws-opensearch&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
