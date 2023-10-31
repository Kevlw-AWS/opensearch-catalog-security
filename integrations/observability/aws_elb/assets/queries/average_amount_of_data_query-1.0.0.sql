-- # List the average amount of data (in kilobytes) that's passing through the Application Load Balancer in request or response pairs
SELECT (avg(sent_bytes)/1000.0 + avg(received_bytes)/1000.0) as prewarm_kilobytes from alb_logs;