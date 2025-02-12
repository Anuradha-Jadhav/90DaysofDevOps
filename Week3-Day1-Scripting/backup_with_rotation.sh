```
#!/bin/bash

# Check if a directory is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

dir="$1"

# Check if the provided path is a valid directory
if [ ! -d "$dir" ]; then
    echo "Error: '$dir' is not a valid directory."
    exit 1
fi

# Create a timestamp
timestamp=$(date +"%Y%m%d_%H%M%S")
backup_dir="$dir/backup_$timestamp"

# Create the backup directory
mkdir -p "$backup_dir"

# Copy all files to the backup directory
cp -r "$dir"/* "$backup_dir" 2>/dev/null

echo "Backup created at: $backup_dir"

# Implementing rotation - Keeping only the last 3 backups
backup_count=$(ls -dt "$dir"/backup_* 2>/dev/null | wc -l)

if [ "$backup_count" -gt 3 ]; then
    ls -dt "$dir"/backup_* 2>/dev/null | tail -n +4 | xargs rm -rf
    echo "Old backups removed to maintain the last 3 backups."
fi
```
