## AWS OpenSearch

Amazon OpenSearch Service is a managed service that makes it easy to deploy, operate, and scale OpenSearch clusters in the AWS Cloud. OpenSearch is based on Elasticsearch, which is an open-source, distributed search and analytics engine. With Amazon OpenSearch Service, you can search, analyze, and visualize your data in real-time, secure, and cost-effective manner without the operational overhead.

### Design Decisions

1. **KMS Key for Encryption**: 
   The module provisions an AWS Key Management Service (KMS) key specifically for OpenSearch data encryption. This provides an additional layer of security for the data stored in the OpenSearch domain.

2. **CloudWatch Logs Integration**:
   Logs from OpenSearch clusters are sent to Amazon CloudWatch. This enables you to monitor and debug your clusters effectively. A KMS Key is also configured to secure these logs.

3. **Access Policies**:
   The module configures access policies to control who can manage and access the OpenSearch domain. This ensures that the right set of users and roles can interact with the service as needed.

4. **Randomized Domain Names**:
   Domain names for OpenSearch are generated using a combination of random pet names and strings to avoid collisions and ensure uniqueness.

5. **VPC Support**:
   OpenSearch deployments are configured to operate within a Virtual Private Cloud (VPC) for network security and isolation.

6. **Node Configuration**:
   The module supports various node configurations, including the number of data nodes, their instance types, and whether dedicated master nodes are enabled. EBS (Elastic Block Store) volumes can also be configured if required.

7. **Advanced Security Options**:
   Advanced security is enabled by default, which includes setting up a master user with a randomly generated username and password.

### Runbook

#### Access Denied Error on OpenSearch Domain

This issue usually occurs due to missing or incorrect access policies. The following steps show how to troubleshoot this error.

1. **Check Access Policies**:
   
   ```sh
   aws opensearch describe-domain --domain-name my-opensearch-domain --query 'DomainStatus.AccessPolicies'
   ```

   Ensure that the policies are properly set to allow necessary actions. You should expect to see the policies that were defined in the module.

2. **Verify IAM Role Permissions**:

   ```sh
   aws iam list-attached-role-policies --role-name my-iam-role
   ```

   Ensure the appropriate policies are attached to the IAM role intended for OpenSearch.

#### OpenSearch Cluster Health Issues

If there are issues affecting the health of the OpenSearch cluster, such as red or yellow cluster status, you can use the following commands to diagnose and address them.

1. **Check Cluster Health**:

   ```sh
   curl -XGET "https://my-opensearch-domain/_cluster/health?pretty"
   ```

   This command returns the health status of the cluster. If the status is red or yellow, this requires immediate attention.

2. **Check Node Statistics**:

   ```sh
   curl -XGET "https://my-opensearch-domain/_nodes/stats?pretty"
   ```

   This command provides detailed statistics about each node in the cluster, including memory usage, CPU usage, and shard details.

3. **Check for Unassigned Shards**:

   ```sh
   curl -XGET "https://my-opensearch-domain/_cat/shards?pretty" | grep UNASSIGNED
   ```

   If there are unassigned shards, identify the reason and take necessary action to reassign them.

4. **Increase Cluster Size**:
   
   If needed, you can scale up the cluster by increasing the instance count or instance type:

   ```sh
   aws opensearch update-domain-config --domain-name my-opensearch-domain --cluster-config InstanceType=r5.large.search,InstanceCount=3
   ```

   Verify the changes by describing the domain configuration:

   ```sh
   aws opensearch describe-domain-config --domain-name my-opensearch-domain
   ```

#### Troubleshooting Slow Search Queries

Slow search queries can affect the performance of your application. These commands can help you identify and address the issues.

1. **Enable Slow Logs**:

   Ensure that slow logs are enabled in your OpenSearch domain. You can check this in the domain configuration.

   ```sh
   aws opensearch describe-domain --domain-name my-opensearch-domain --query 'DomainStatus.LogPublishingOptions'
   ```

2. **View Slow Logs in CloudWatch**:

   Go to Amazon CloudWatch and view the log groups starting with `/aws/opensearch/my-opensearch-domain/search-slow-logs/`.

3. **Optimize Indexes**:

   Analyze and optimize your indexes for better performance.

   ```sh
   curl -XGET "https://my-opensearch-domain/_cat/indices?v"
   ```

   Look for indexes that are too large or have high numbers of shards.

4. **Analyze Query Performance**:

   Use the `_profile` API to get detailed information about search queries.

   ```sh
   curl -XGET "https://my-opensearch-domain/my-index/_search?pretty&filter_path=took,hits.total,hits.hits._source,profile" -H 'Content-Type: application/json' -d '{
     "query": {
       "match_all": {}
     },
     "profile": true
   }'
   ```

   This command profiles the search query and helps identify bottlenecks. 

---

This guide provides essential troubleshooting steps to manage and debug your Amazon OpenSearch Service effectively.

