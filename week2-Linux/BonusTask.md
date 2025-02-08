Here are the commands and a script to achieve your requirements:

### 1. Find the top 5 most common log messages in `Linux_2k.log` using `awk` and `sort`
```bash
awk '{ $1=$2=$3=""; print $0 }' Linux_2k.log | sort | uniq -c | sort -nr | head -5
```
This counts occurrences of each log message, sorts them in descending order, and displays the top 5.

### 2. List all files modified in the last 7 days using `find`
```bash
ubuntu@ip-172-31-33-137:~/loghub/Linux$ find . -type f -mtime -7
./sanitized_log.log
./Linux_2k.log_templates.csv
./Linux_2k.log_structured.csv
./Linux_2k.log
./README.md
ubuntu@ip-172-31-33-137:~/loghub/Linux$ 
```


### 3. Script to Extract and Display Only `ERROR` and `WARNING` Logs

```bash
#!/bin/bash
# Define log file
LOG_FILE="/home/ubuntu/loghub/Linux/Linux_2k.log"

# Extract ERROR and WARNING logs
grep -Ei "ERROR|WARNING" $LOG_FILE
```

Save this script as `filter_logs.sh`, then make it executable:
```bash
chmod +x filter_logs.sh
```
Run it with:
```bash
./filter_logs.sh
```

