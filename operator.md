## AWS OpenSearch Operator Guide

Amazon OpenSearch is a managed service that allows you to set up, manage, and scale a search engine for your website or application. It is built on top of Apache Lucene and provides a simple and easy-to-use interface for adding search functionality to your application.

Amazon OpenSearch Service makes it easy to upgrade your OpenSearch clusters to newer versions without any downtime, using in-place version upgrades. In-place upgrades eliminates the hassle of taking a manual snapshot, restoring it to a cluster running the newer version, and updating all your endpoint references.

### Use Cases

**E-commerce search**: OpenSearch can be used to provide search functionality for e-commerce websites, where customers can search for products by keyword, category, or other attributes. With OpenSearch, you can create complex search queries that take into account factors such as price, availability, and popularity. Additionally, OpenSearch's faceting capabilities allow users to narrow down search results by attributes such as brand, color, and price range.

**Log analysis**: OpenSearch is commonly used for log analysis, which involves collecting, parsing, and analyzing log data. With OpenSearch, you can quickly and easily search through large volumes of log data to find specific events or patterns. OpenSearch also allows you to create alerts and notifications based on certain conditions, such as when a specific error occurs in the logs.

**Business intelligence and analytics**: OpenSearch can be used as a data store for business intelligence and analytics applications. It allows you to easily index and query large amounts of data, and its aggregation capabilities make it well-suited for creating data visualizations and dashboards. Additionally, its real-time search capabilities allow for near real-time data analysis.

**Geo-location search**: OpenSearch has built-in support for geo-location data, which makes it well-suited for applications that involve searching for data based on location. For example, it can be used to build a location-based search engine for finding nearby restaurants, hotels, or shops. It can also be used to analyze location-based data, such as tracking the movement of vehicles or people.

**Real-time monitoring and anomaly detection**: OpenSearch can be used to monitor and analyze real-time data streams, such as sensor data or social media feeds. Its real-time search capabilities make it well-suited for detecting anomalies or patterns in the data. It can be used to detect equipment failures in an industrial setting, or to monitor social media sentiment in real-time.

### Best Practices


* Define your search schema: Before you start indexing data, you should define your search schema, which defines the fields and data types of the documents you will be indexing. This will help ensure that your search results are accurate and relevant.

* Use the right search API: OpenSearch provides several different search APIs, such as search, suggest, and autocomplete. Choose the right API for your use case to ensure that you are getting the most relevant search results.

* Optimize your search query: OpenSearch allows you to use several query parameters to optimize your search results. For example, you can use the "filter" parameter to narrow your search results to a specific subset of documents.

* Monitor and troubleshoot your search index: AWS OpenSearch provides several tools for monitoring and troubleshooting your search index, such as CloudWatch Logs and the OpenSearch console. Use these tools to ensure that your search index is working correctly and to troubleshoot any issues that may arise.

* Use the OpenSearch Query Logging feature: OpenSearch allows you to log all your queries and their results. This can be useful to analyze the search patterns and improve your search schema and ranking.

* Leverage the power of AWS services: OpenSearch integrates with other AWS services, such as Amazon DynamoDB and Amazon S3, which can be leveraged to index and search data stored in DynamoDB tables or S3 buckets.

Learn mote about [operational best practices for Amazon OpenSearch Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/bp.html).


### Design Decisions

* Conditionally creates a service-linked role for OpenSearch. The role is **retained** on decommission since it is a global resource and may be in use by other OpenSearch clusters.
* Node-to-node encryption is enabled.
* Custom KMS keys are created and **retained** after decommissioning.
* Encryption at rest is enabled.
* Creates a logwatch group for each log type, KMS encrypted.
* HTTPS is enforced w/ TLS 1.2.
* When Master Nodes are enabled following [best practices](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-dedicatedmasternodes.html) 3 nodes will be selected. The instance types will be determined based on the data node type and count as documented [here](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-dedicatedmasternodes.html).
* [VPC-based deployment](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/vpc.html)
* Advanced [security](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/security.html) is enabled.
* [Auto-Tune](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html) is enabled to improve cluster speed and stability, with `NO_ROLLBACK` on disable.
* Only [current generation](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/supported-instance-types.html) types are supported.
* [Zone Awareness](https://aws.amazon.com/premiumsupport/knowledge-center/opensearch-fault-tolerance/) is automatically turned on when the data node instance count > 1. 2 zones are used for 2 instances, 3 zones are used for 3+ instances.
* A unique 28 character domain name is automatically created. Custom domains are on our [roadmap](https://github.com/massdriver-cloud/aws-opensearch/issues/5).

### Caveats

When designing bundles, Massdrivers aims for the 80% use case. If any of the caveats below impact your ability to operate OpenSearch please feel free to open an [issue](https://github.com/massdriver-cloud/aws-opensearch/issues) and we'll prioritize adding support.

1. _This bundle does not support Elasticsearch._ If you need Elasticsearch support you can request it [here](https://roadmap.massdriver.cloud/) or [create your own](https://docs.massdriver.cloud/bundles).
2. Cold storage, Warm Nodes, and Cognito aren't supported at this time, but are on our roadmap.
3. No support for T3 Class instances as they frequently time out during provisioning. If you need T3 support, please contact us by clicking the chat icon on your sidebar.
4. Instance count & type are marked immutable as the Terraform provider doesn't appear to support blue/green deploys. We are tracking this issue [here](https://github.com/massdriver-cloud/aws-opensearch/issues/12).
5. Authentication is currently only supported using master user/password and [basic auth](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/fgac-walkthrough-basic.html). If you need another authentication type, please comment on this [issue](https://github.com/massdriver-cloud/aws-opensearch/issues/11) and we will prioritize.

### Additional OpenSearch Resources

* [Home Page](https://opensearch.org/)
* [Developer Guide](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/what-is.html)
* [Instance types](https://instances.vantage.sh/opensearch/)
* [Pricing](https://aws.amazon.com/opensearch-service/pricing/)
* [Blue/Green configuration changes in Amazon OpenSearch Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-configuration-changes.html)
