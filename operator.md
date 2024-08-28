## AWS OpenSearch

Amazon OpenSearch Service is a managed service that makes it easy to deploy, operate, and scale OpenSearch clusters in the cloud. OpenSearch is a distributed search and analytics suite derived from Elasticsearch. The service provides operational tools and security configurations, enabling users to perform searches on large amounts of data without the need to manage the underlying infrastructure.

### Use Cases

**E-commerce search**: OpenSearch can be used to provide search functionality for e-commerce websites, where customers can search for products by keyword, category, or other attributes. With OpenSearch, you can create complex search queries that take into account factors such as price, availability, and popularity. Additionally, OpenSearch's faceting capabilities allow users to narrow down search results by attributes such as brand, color, and price range.

**Log analysis**: OpenSearch is commonly used for log analysis, which involves collecting, parsing, and analyzing log data. With OpenSearch, you can quickly and easily search through large volumes of log data to find specific events or patterns. OpenSearch also allows you to create alerts and notifications based on certain conditions, such as when a specific error occurs in the logs.

**Business intelligence and analytics**: OpenSearch can be used as a data store for business intelligence and analytics applications. It allows you to easily index and query large amounts of data, and its aggregation capabilities make it well-suited for creating data visualizations and dashboards. Additionally, its real-time search capabilities allow for near real-time data analysis.

**Geo-location search**: OpenSearch has built-in support for geo-location data, which makes it well-suited for applications that involve searching for data based on location. For example, it can be used to build a location-based search engine for finding nearby restaurants, hotels, or shops. It can also be used to analyze location-based data, such as tracking the movement of vehicles or people.

**Real-time monitoring and anomaly detection**: OpenSearch can be used to monitor and analyze real-time data streams, such as sensor data or social media feeds. Its real-time search capabilities make it well-suited for detecting anomalies or patterns in the data. It can be used to detect equipment failures in an industrial setting, or to monitor social media sentiment in real-time.

### Design Decisions

1. **KMS Encryption**: The module provisions a KMS key specifically for encrypting OpenSearch data.
2. **Security Best Practices**: It ensures HTTPS enforcement and TLS security policy adherence.
3. **Resource Policy**: IAM policies are configured to allow CloudWatch access to OpenSearch logs and to enable comprehensive access control.
4. **Subnet Configuration**: The module supports VPC configurations with different subnet types (internal/private).
5. **Instance Recommendations**: Based on node count, the module recommends suitable instance types for master nodes.
6. **Zone Awareness**: Automatic zone awareness enabled for high availability.
7. **Logging**: Configures log groups in CloudWatch for monitoring and troubleshooting.

## Runbook

#### Unable to Access OpenSearch Cluster

If you are unable to connect to your OpenSearch cluster, it might be due to improper security group configurations or VPC settings. First, verify the VPC and security group setup.

**Check VPC Configuration:**

```sh
aws ec2 describe-vpcs --vpc-ids <your-vpc-id>
```

Ensure the correct VPC ID is configured and your instance is part of the VPC.

**Check Security Groups:**

```sh
aws ec2 describe-security-groups --group-ids <your-security-group-id>
```

Ensure that the security groups allow traffic on the required ports (e.g., 443 for HTTPS).

#### Unable to View/OpenSearch Logs in CloudWatch

If OpenSearch logs are not appearing in CloudWatch, verify that the log groups and resource policies are correctly configured.

**Check CloudWatch Log Groups:**

```sh
aws logs describe-log-groups --log-group-name-prefix /aws/opensearch/
```

Verify that the log groups exist and match the prefixes you expect.

**Check Resource Policies:**

```sh
aws logs describe-resource-policies
```

Ensure that the resource policies allow the `opensearchservice.amazonaws.com` principal to write logs.

#### OpenSearch Cluster Performance Issues

If the OpenSearch cluster is experiencing performance issues, check the node configuration and ensure they are configured correctly.

**List OpenSearch Domains:**

```sh
aws opensearch describe-domain --domain-name <your-domain-name>
```

Review the output to ensure the cluster configuration matches the intended settings, including instance types and counts.

**Check ES Cluster Health:**

```sh
curl -XGET "https://<your-domain-endpoint>/_cluster/health?pretty" -u 'username:password'
```

Review the health status of your cluster. You should see a status of "green". If the status is "yellow" or "red", further investigation is needed.

#### Authentication Issues

If you are having issues with authentication to the OpenSearch cluster, verify the credentials used for accessing the cluster.

**Verify Internal User Database Authentication:**

```sh
curl -XGET "https://<your-domain-endpoint>/_opendistro/_security/api/internalusers" -u 'username:password'
```

Ensure that the correct master user credentials are being used.

**Verify IAM Role Assumption:**

```sh
aws sts assume-role --role-arn <your-role-arn> --role-session-name AWSCLI-Session
```

Ensure the IAM role can be assumed correctly. Check the response for credentials and confirm that the role is set up correctly with the necessary policies.

## Additional OpenSearch Resources

* [Home Page](https://opensearch.org/)
* [Developer Guide](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/what-is.html)
* [Instance types](https://instances.vantage.sh/opensearch/)
* [Pricing](https://aws.amazon.com/opensearch-service/pricing/)
* [Blue/Green configuration changes in Amazon OpenSearch Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-configuration-changes.html)