Automate Backups with Shell Scripting
```bash
SRC_DIR="/devops_workspace"
BACKUP_DIR="backups"
BACKUP_FILE="$BACKUP_DIR/backup_$(date +%F).zip"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Create the backup
zip -r "$BACKUP_FILE" "$SRC_DIR"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo -e "\e[32mBackup successful! File saved as $BACKUP_FILE\e[0m"
else
    echo -e "\e[31mBackup failed!\e[0m"
    exit 1
fi
```
