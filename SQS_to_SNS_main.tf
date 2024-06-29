provider "aws" {
  region = "eu-west-1"
}


# Create an SQS Queue
resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-sample-queue"
}

# Create an SNS Topic for notifications
resource "aws_sns_topic" "sqs_alarm" {
  name = "sqsMessagesExceeded"
}

resource "aws_sns_topic_subscription" "sqs_subscription" {
  topic_arn = aws_sns_topic.sqs_alarm.arn
  protocol  = "email"
  endpoint  = "azam****@gmail.com"
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_metrics" {
  alarm_name          = "sqsAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "NumberOfMessagesSent"
  namespace           = "AWS/SQS"
  period              = 300
  statistic           = "Maximum"
  threshold           = 1
  alarm_description   = "Messages are present in SQS topics"
  actions_enabled     = "true"
  dimensions                = {
    QueueName = aws_sqs_queue.terraform_queue.name
  }
  alarm_actions       = [aws_sns_topic.sqs_alarm.arn]
}

output "sqs_queue" {
  value = aws_sqs_queue.terraform_queue.name
}

output "sns_topic" {
  value = aws_sns_topic.sqs_alarm.name
}

output "sns_topic_subscription" {
  value = aws_sns_topic_subscription.sqs_subscription.arn
}
