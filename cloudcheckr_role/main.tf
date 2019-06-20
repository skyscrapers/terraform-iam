resource "aws_iam_role_policy" "cloudcheckr_policy" {
  name   = "cloudcheckr"
  role   = aws_iam_role.cloudcheckr_role.id
  policy = <<EOF
{

    "Version": "2012-10-17",

    "Statement": [

        {

            "Sid": "FullPolicy",

            "Action": [

                "acm:DescribeCertificate",

                "acm:ListCertificates",

                "acm:GetCertificate",

                "autoscaling:Describe*",

                "cloudformation:DescribeStacks",

                "cloudformation:GetStackPolicy",

                "cloudformation:GetTemplate",

                "cloudformation:ListStackResources",

                "cloudfront:List*",

                "cloudfront:GetDistributionConfig",

                "cloudfront:GetStreamingDistributionConfig",

                "cloudhsm:Describe*",

                "cloudhsm:List*",

                "cloudsearch:DescribeDomains",

                "cloudsearch:DescribeServiceAccessPolicies",

                "cloudsearch:DescribeStemmingOptions",

                "cloudsearch:DescribeStopwordOptions",

                "cloudsearch:DescribeSynonymOptions",

                "cloudsearch:DescribeDefaultSearchField",

                "cloudsearch:DescribeIndexFields",

                "cloudsearch:DescribeRankExpressions",

                "cloudtrail:DescribeTrails",

                "cloudtrail:GetTrailStatus",

                "cloudwatch:DescribeAlarms",

                "cloudwatch:GetMetricStatistics",

                "cloudwatch:ListMetrics",

                "config:DescribeConfigRules",

                "config:GetComplianceDetailsByConfigRule",

                "config:DescribeDeliveryChannels",

                "config:DescribeDeliveryChannelStatus",

                "config:DescribeConfigurationRecorders",

                "config:DescribeConfigurationRecorderStatus",

                "datapipeline:ListPipelines",

                "datapipeline:GetPipelineDefinition",

                "datapipeline:DescribePipelines",

                "directconnect:DescribeLocations",

                "directconnect:DescribeConnections",

                "directconnect:DescribeVirtualInterfaces",

                "dynamodb:ListTables",

                "dynamodb:DescribeTable",

                "ec2:Describe*",

                "ec2:GetConsoleOutput",

                "ecs:ListClusters",

                "ecs:DescribeClusters",

                "ecs:ListContainerInstances",

                "ecs:DescribeContainerInstances",

                "ecs:ListServices",

                "ecs:DescribeServices",

                "ecs:ListTaskDefinitions",

                "ecs:DescribeTaskDefinition",

                "ecs:ListTasks",

                "ecs:DescribeTasks",

                "elasticache:DescribeCacheClusters",

                "elasticache:DescribeReservedCacheNodes",

                "elasticache:DescribeCacheSecurityGroups",

                "elasticache:DescribeCacheParameterGroups",

                "elasticache:DescribeCacheParameters",

                "elasticache:DescribeCacheSubnetGroups",

                "elasticbeanstalk:DescribeApplications",

                "elasticbeanstalk:DescribeConfigurationSettings",

                "elasticbeanstalk:DescribeEnvironments",

                "elasticbeanstalk:DescribeEvents",

                "elasticloadbalancing:DescribeLoadBalancers",

                "elasticloadbalancing:DescribeInstanceHealth",

                "elasticloadbalancing:DescribeLoadBalancerAttributes",

                "elasticloadbalancing:DescribeTags",

                "elasticmapreduce:DescribeJobFlows",

                "elasticmapreduce:DescribeStep",

                "elasticmapreduce:DescribeCluster",

                "elasticmapreduce:DescribeTags",

                "elasticmapreduce:ListSteps",

                "elasticmapreduce:ListInstanceGroups",

                "elasticmapreduce:ListBootstrapActions",

                "elasticmapreduce:ListClusters",

                "elasticmapreduce:ListInstances",

                "es:ListDomainNames",

                "es:DescribeElasticsearchDomains",

                "glacier:List*",

                "glacier:DescribeVault",

                "glacier:GetVaultNotifications",

                "glacier:DescribeJob",

                "glacier:GetJobOutput",

                "iam:Get*",

                "iam:List*",

                "iot:DescribeThing",

                "iot:ListThings",

                "iam:GenerateCredentialReport",

                "kinesis:ListStreams",

                "kinesis:DescribeStream",

                "kinesis:GetShardIterator",

                "kinesis:GetRecords",

                "kms:Describe*",

                "kms:Get*",

                "kms:List*",

                "lambda:ListFunctions",

                "rds:Describe*",

                "rds:ListTagsForResource",

                "redshift:Describe*",

                "redshift:ViewQueriesInConsole",

                "route53:ListHealthChecks",

                "route53:ListHostedZones",

                "route53:ListResourceRecordSets",

                "s3:GetBucketACL",

                "s3:GetBucketLocation",

                "s3:GetBucketLogging",

                "s3:GetBucketPolicy",

                "s3:GetBucketTagging",

                "s3:GetBucketWebsite",

                "s3:GetBucketNotification",

                "s3:GetLifecycleConfiguration",

                "s3:GetNotificationConfiguration",

                "s3:GetObjectMetadata",

                "s3:List*",

                "sdb:ListDomains",

                "sdb:DomainMetadata",

                "ses:ListIdentities",

                "ses:GetSendStatistics",

                "ses:GetIdentityDkimAttributes",

                "ses:GetIdentityVerificationAttributes",

                "ses:GetSendQuota",

                "sns:GetSnsTopic",

                "sns:GetTopicAttributes",

                "sns:GetSubscriptionAttributes",

                "sns:ListTopics",

                "sns:ListSubscriptionsByTopic",

                "sqs:ListQueues",

                "sqs:GetQueueAttributes",

                "storagegateway:Describe*",

                "storagegateway:List*",

                "support:*",

                "swf:ListClosedWorkflowExecutions",

                "swf:ListDomains",

                "swf:ListActivityTypes",

                "swf:ListWorkflowTypes",

                "workspaces:DescribeWorkspaceDirectories",

                "workspaces:DescribeWorkspaceBundles",

                "workspaces:DescribeWorkspaces"

            ],

            "Effect": "Allow",

            "Resource": "*"

        },

        {

            "Sid": "CloudWatchLogsSpecific",

            "Effect": "Allow",

            "Action": [

                "logs:GetLogEvents",

                "logs:DescribeLogGroups",

                "logs:DescribeLogStreams"

            ],

            "Resource": [

                "arn:aws:logs:*:*:*"

            ]

        }

    ]

}
EOF

}

resource "aws_iam_role" "cloudcheckr_role" {
  name = "CloudCheckrRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::352813966189:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.external_id}"
        }
      }
    }
  ]
}
EOF

}

