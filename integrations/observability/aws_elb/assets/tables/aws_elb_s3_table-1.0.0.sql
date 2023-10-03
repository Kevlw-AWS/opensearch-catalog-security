CREATE EXTERNAL TABLE IF NOT EXISTS alb_logs (
            type string as aws.elb.elb_type,
            time string as @timestamp,
            elb string as aws.elb.elb_name,
            client_ip string as aws.elb.client.ip,
            client_port int  as aws.elb.client.port,
            target_ip string as aws.elb.target_ip,
            target_port int as aws.elb.target_port,
            request_processing_time double as aws.elb.request_processing_time,
            target_processing_time double as aws.elb.target_processing_time,
            response_processing_time double as aws.elb.response_processing_time,
            elb_status_code int as aws.elb.elb_status_code,
            target_status_code string as aws.elb.target_status_code,
            received_bytes bigint as aws.elb.received_bytes,
            sent_bytes bigint  as aws.elb.sent_bytes,
            request_verb string as http.request.method,
            request_url string as url.full,
            request_proto string as url.schema,
            user_agent string as http.user_agent.name,
            ssl_cipher string as aws.elb.ssl_cipher,
            ssl_protocol string as aws.elb.ssl_protocol ,
            target_group_arn string as aws.elb.target_group_arn,
            trace_id string as traceId,
            domain_name string as url.domain,
            chosen_cert_arn string as aws.elb.chosen_cert_arn,
            matched_rule_priority string as aws.elb.matched_rule_priority,
            request_creation_time string as aws.elb.request_creation_time,
            actions_executed string as aws.elb.actions_executed,
            redirect_url string as aws.elb.redirect_url,
            lambda_error_reason string as aws.elb.lambda_error_reason,
            target_port_list string as aws.elb.target_port_list,
            target_status_code_list string as aws.elb.target_status_code_list,
            classification string as aws.elb.classification ,
            classification_reason string as  aws.elb.classification_reason
       )PARTITIONED BY ( year STRING, month STRING, day STRING )
            ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
            WITH SERDEPROPERTIES (
            'serialization.format' = '1',
            'input.regex' = 
        '([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*):([0-9]*) ([^ ]*)[:-]([0-9]*) ([-.0-9]*) ([-.0-9]*) ([-.0-9]*) (|[-0-9]*) (-|[-0-9]*) ([-0-9]*) ([-0-9]*) \"([^ ]*) (.*) (- |[^ ]*)\" \"([^\"]*)\" ([A-Z0-9-_]+) ([A-Za-z0-9.-]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" ([-.0-9]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^ ]*)\" \"([^\s]+?)\" \"([^\s]+)\" \"([^ ]*)\" \"([^ ]*)\"')
            LOCATION {location};
            
-- # Add partition individually following Hive convention like year=2022/month=04/day=01
ALTER TABLE alb_logs ADD PARTITION (year='?',month='?', day='?') location '?';