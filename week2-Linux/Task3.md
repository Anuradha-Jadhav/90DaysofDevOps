
# Log File Analysis with AWK, Grep & Sed

### Logs are crucial in DevOps! You’ll analyze logs using the Linux_2k.log file from LogHub (GitHub Repo).

    Task:
        1) Download the log file from the repository.
        2) Extract insights using commands:
           * Use grep to find all occurrences of the word "error".
           * Use awk to extract timestamps and log levels.
           * Use sed to replace all IP addresses with [REDACTED] for security.
        # Bonus: Find the most frequent log entry using awk or sort | uniq -c | sort -nr | head -10.

---

### **Step 1: Download the Log File**
If the log file is in a Git repository:  
1. Clone the repository:
   ```bash
   git --version
   git clone https://github.com/logpai/loghub.git
  
   ```
2. Navigate to the directory:
   ```bash
    cd loghub/Linux/
   ```
---

### **Step 2: Extract Insights from the Log File**
Assume the log file is named **`Linux_2k.log`**.

#### **Find all occurrences of the word "error"**
```bash
grep -i "error" Linux_2k.log
```
- `-i` makes it case-insensitive (matches `Error`, `ERROR`, etc.).

#### **Extract Timestamps and Log Levels using `awk`**
If log lines follow a pattern like:
```
2025-02-06 12:34:56 ERROR Connection failed from 192.168.1.1
```
Use:
```bash
awk '{print $1, $2, $3, $5, $6}' Linux_2k.log
```
- `$1` and `$2` → Timestamp
- `$3` → Log level (`ERROR`, `INFO`, etc.)

#### **Replace All IP Addresses with `[REDACTED]` using `sed`**
```bash
sed -E 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[REDACTED]/g' Linux_2k.log > sanitized_log.log
```
_ sed → Stream editor for modifying text.
- E → Enables extended regular expressions (needed for + to work).
- 's/.../.../g' → Substitution (s/old/new/g).
- [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ → Matches IPv4 addresses.
- [REDACTED] → Replacement text.
- sanitized_log.log → Saves the modified output to sanitized_log.log.
- This replaces **all IPv4 addresses** with `[REDACTED]`.
- The modified log is saved in `sanitized_log.log`.

---

### **Bonus: Find the Most Frequent Log Entry**
```bash
cat Linux_2k.log | sort | uniq -c | sort -nr | head -10
```
- `sort` → Sorts the log lines.
- `uniq -c` → Counts unique log lines.
- `sort -nr` → Sorts in descending order by frequency.
- `head -10` → Shows the top 10 most common entries.

---

